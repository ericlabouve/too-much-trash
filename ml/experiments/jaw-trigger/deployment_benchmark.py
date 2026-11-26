"""Bind final event accuracy and latency to one deployable inference artifact.

The final reviewers inspect/execute the recorded runtime. Hashes and traces
prevent accidental prototype/native metric mixing; they are not proof of an
arbitrary evaluator's honesty.
"""
from hashlib import sha256
import json
from math import isfinite
from pathlib import Path

from dashboard_integrity import hashed_artifact
from phone_benchmark import percentile

PROTOCOL = 'deployment-v1'
FORMATS = {'native', 'coreml', 'onnx', 'executorch', 'tflite', 'metal'}


def verify_deployment_benchmarks(job, evaluation, candidates, training_ids, validation_ids, review_bundles=None):
    reports = evaluation.get('deployment_benchmarks', {})
    if set(reports) != set(candidates):
        raise ValueError('Every evaluated candidate needs a deployment benchmark report')
    previous_end = float('-inf')
    host = None
    for name, receipt in reports.items():
        _, report_path, _ = hashed_artifact(job, receipt)
        report = json.loads(report_path.read_text())
        runtime = report.get('runtime', {})
        if (report.get('candidate') != candidates[name] or report.get('protocol') != PROTOCOL
                or runtime.get('mobile_target') != 'iOS' or runtime.get('format') not in FORMATS
                or any(not isinstance(runtime.get(key), str) or not runtime[key].strip()
                       for key in ('engine', 'device', 'compute_units', 'precision'))):
            raise ValueError('Final results require an identified iOS deployment runtime, not prototype inference')
        if host is None:
            host = runtime['device']
        if runtime['device'] != host:
            raise ValueError('Final candidate latency measurements must share the same benchmark device')
        hashes, roles = {}, set()
        for item in report.get('artifacts', []):
            path, _, digest = hashed_artifact(job, item)
            if path in hashes:
                raise ValueError('Duplicate deployed artifact path')
            hashes[path] = digest
            roles.update(item.get('roles', []))
        if not {'runtime', 'model', 'preprocessor', 'decoder'} <= roles:
            raise ValueError('Freeze the deployed runtime, model, preprocessing and decoder')
        if name in (review_bundles or {}):
            reviewed = {hashed_artifact(job,item)[0]:item['sha256'] for item in review_bundles[name]['files']}
            if any(reviewed.get(path) != digest for path,digest in hashes.items()):
                raise ValueError('Final reviewers must cover the exact deployed artifact bundle')
        _, runner, _ = hashed_artifact(job, report['runner'])
        if str(runner.relative_to(job.resolve())) not in hashes:
            raise ValueError('Benchmark runner must belong to the frozen deployment bundle')
        command = report.get('command', [])
        if not isinstance(command, list) or not any(item in (str(runner), str(runner.relative_to(job.resolve()))) for item in command):
            raise ValueError('Record the actual deployment benchmark invocation')
        _, output, _ = hashed_artifact(job, report['outputs'])
        trace = json.loads(output.read_text())
        if trace.get('artifact_hashes') != hashes or trace.get('runtime') != runtime or trace.get('candidate') != candidates[name]:
            raise ValueError('Accuracy and latency must come from the same frozen deployment runtime')
        for key in ('preparation_complete', 'warmup_complete', 'thermal_nominal', 'same_preprocessing_and_decoder'):
            if trace.get(key) is not True:
                raise ValueError('Final deployment measurements require warmup, completed fitting and nominal thermal conditions')
        if trace.get('test_evaluated') is not False:
            raise ValueError('Reserved test must not enter round deployment evaluation')
        begin, end = trace.get('started_uptime_seconds'), trace.get('finished_uptime_seconds')
        if (any(type(t) not in (float,int) or not isfinite(t) for t in (begin,end))
                or begin < previous_end or end <= begin):
            raise ValueError('Deployment candidate benchmarks must run serially in report order')
        previous_end = end
        splits = trace.get('splits', {})
        if set(splits) != {'train', 'validation'}:
            raise ValueError('Replay train and validation only through the deployed artifact')
        timings = []
        for split, ids, source in (('train', training_ids, 'training_predictions'),
                                   ('validation', validation_ids, 'predictions')):
            rows = splits[split]
            if (not isinstance(rows,list) or len(rows) != len(ids)
                    or [row.get('clip') for row in rows] != ids):
                raise ValueError('Deployment traces must cover the exact frozen split order')
            for row in rows:
                times, scores = row.get('sample_times_seconds',[]), row.get('scores',[])
                durations = row.get('timings_ms',[])
                if (len(times) < 2 or len(scores) != len(times) or len(durations) != len(times)
                        or any(type(value) not in (float,int) or not isfinite(value) for value in [*times,*scores,*durations])
                        or any(t < 0 for t in durations) or any(b <= a for a,b in zip(times,times[1:]))):
                    raise ValueError('Deployment output must retain actual per-frame scores and durations')
                if row.get('events') != evaluation.get(source,{}).get(name,{}).get(row['clip']):
                    raise ValueError('Final F1 predictions differ from the deployed artifact outputs')
                if split == 'validation':
                    timings.extend(durations)
        if timings != evaluation.get('timings_ms',{}).get(name):
            raise ValueError('Final p95 timings differ from the deployed artifact outputs')
        if not timings or percentile(timings,.95) <= 0:
            raise ValueError('Final deployment p95 is below the measurable timer range')
    return {'protocol':PROTOCOL, 'device':host, 'candidates':sorted(candidates)}


def load_deployment_evaluation(output, prior):
    """Read a root-published, source-bound benchmark overlay; never admit models."""
    try:
        pointer=json.loads((output/'deployment-evaluation-current.json').read_text())
        path=Path(pointer['summary_path']).resolve(strict=True)
        if not path.is_relative_to(output.resolve()) or sha256(path.read_bytes()).hexdigest()!=pointer['summary_sha256']:
            return None
        summary=json.loads(path.read_text())
        if (summary.get('status')!='validated' or summary.get('benchmark_protocol')!=PROTOCOL
                or summary.get('source_result_sha256')!=sha256(prior.read_bytes()).hexdigest()):return None
        return summary
    except (OSError,ValueError,KeyError,TypeError):
        return None
