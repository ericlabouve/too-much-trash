"""Validate serial native phone measurements without changing models or fitness."""
import argparse
from hashlib import sha256
import json
import math
from pathlib import Path


def canonical(value):
    return json.dumps(value, sort_keys=True, separators=(',', ':'))


def percentile(values, fraction):
    values = sorted(values)
    index = (len(values)-1)*fraction
    low = math.floor(index)
    return values[low]+(values[math.ceil(index)]-values[low])*(index-low)


def validate(result, pool, clips, reference, tolerance=0.0001, platform='phone'):
    if platform not in ('phone','laptop-native'):
        raise ValueError('Unknown native benchmark platform')
    prefix = 'phone' if platform == 'phone' else 'laptop_native'
    if (result.get('error') or result.get('interrupted') is not False
            or result.get('low_power') is not False
            or result.get('thermal_start') != 0 or result.get('thermal_end') != 0):
        raise ValueError('Phone run failed, was interrupted, or did not maintain nominal thermal/power conditions')
    if any(result.get(key) != pool[key] for key in ('suite', 'round', 'result_sha256', 'pool_sha256')):
        raise ValueError('Phone result does not match the frozen pool')
    expected = {item['candidate']['name']: item for item in pool['candidates']}
    fixture = {item['file']: item for item in clips}
    records = result.get('results', [])
    if len(records) != len(expected)*pool['repeats']:
        raise ValueError('Missing candidate measurements')
    seen, durations, errors, pass_durations = set(), {}, {}, {}
    previous_end = -math.inf
    for record in records:
        candidate = record['candidate']; name = candidate['name']; repeat = record['pass']
        if name not in expected or candidate != expected[name]['candidate'] or record.get('model_sha256') != expected[name]['model_sha256']:
            raise ValueError('Candidate/model identity changed')
        if type(repeat) is not int or not 0 <= repeat < pool['repeats'] or (name, repeat) in seen:
            raise ValueError('Duplicate or invalid measured pass')
        seen.add((name, repeat))
        if record.get('thermal_start') != 0 or record.get('thermal_end') != 0:
            raise ValueError('Candidate was not measured at nominal thermal state')
        begin, end = record['started_uptime_seconds'], record['finished_uptime_seconds']
        if not all(type(t) in (int,float) and math.isfinite(t) for t in (begin,end)) or begin < previous_end or end <= begin:
            raise ValueError('Candidate measurements overlap or have invalid timing')
        previous_end = end
        outputs = record['clips']
        if len(outputs) != len(fixture) or {out['file'] for out in outputs} != set(fixture):
            raise ValueError('Incomplete clip coverage')
        measured = []
        for out in outputs:
            count = len(fixture[out['file']]['timestamps'])
            if out['sample_count'] != count or len(out['scores']) != count or len(out['ms']) != count:
                raise ValueError('Incomplete per-frame output')
            if any(type(t) not in (float,int) or not math.isfinite(t) or t < 0 for t in out['ms']):
                raise ValueError('Invalid native frame duration')
            target = reference[Path(out['file']).stem]['candidates'][name]
            if len(target['scores']) != count or any(not math.isfinite(t) for t in out['scores']):
                raise ValueError('Invalid score trace')
            error = max(abs(a-b) for a,b in zip(out['scores'],target['scores']))
            errors[name] = max(error,errors.get(name,0))
            if error > tolerance:
                raise ValueError(f'Native score parity failed: {name}, {out["file"]}, max error {error:.6g}')
            if (len(out['events']) != len(target['events']) or any(a[0] != b[0] or abs(a[1]-b[1]) > 1e-8
                                                                       for a,b in zip(out['events'],target['events']))):
                raise ValueError(f'Native event parity failed: {name}, {out["file"]}')
            measured.extend(out['ms'])
        if percentile(measured,.95) <= 0:
            raise ValueError('Timer resolution cannot establish a positive p95 duration')
        durations.setdefault(name,[]).extend(measured)
        pass_durations.setdefault(name,[]).append(percentile(measured,.95))
    return {'status':'validated', 'suite':result['suite'], 'round':pool['round'],
            'platform':platform,
            'source_result_sha256':pool['result_sha256'], 'pool_sha256':pool['pool_sha256'],
            'device':result['model'], 'os':result['os'], 'scope':result['scope'],
            'repeats':pool['repeats'], 'clip_count':len(clips), 'elapsed_ms':result['elapsed_ms'],
            'thermal':'nominal', 'interrupted':False, 'reserved_test_read':False,
            'timer_note':'Individual steps may quantize to zero; retained without rounding upward. Sub-microsecond results are timer-limited and displayed as <0.001 ms.',
            'candidates':{name:{'candidate':item['candidate'],'model_sha256':item['model_sha256'],
                                f'{prefix}_p95_ms':percentile(durations[name],.95),
                                f'{prefix}_median_ms':percentile(durations[name],.5),
                                'pass_p95_ms':pass_durations[name], 'samples':len(durations[name]),
                                'zero_duration_samples':sum(t == 0 for t in durations[name]),
                                'max_score_error':errors[name], 'event_parity':True}
                          for name,item in expected.items()}}


def load_phone_timing(output, prior, platform='phone'):
    """Show measurements only for the exact current result, not a refitted namesake."""
    try:
        pointer = json.loads((output/f'{platform}-timing-current.json').read_text())
        path = Path(pointer['summary_path']).resolve(strict=True)
        if not path.is_relative_to(output.resolve()):
            return None
        if sha256(path.read_bytes()).hexdigest() != pointer['summary_sha256']:
            return None
        summary = json.loads(path.read_text())
        if summary['status'] != 'validated' or summary.get('platform','phone') != platform or summary['source_result_sha256'] != sha256(prior.read_bytes()).hexdigest():
            return None
        return summary
    except (OSError, ValueError, KeyError, TypeError):
        return None


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('run', type=Path)
    parser.add_argument('--output', type=Path)
    parser.add_argument('--platform',choices=('phone','laptop-native'),default='phone')
    args = parser.parse_args()
    read = lambda p: json.loads(p.read_text())
    filename = 'phone-result.json' if args.platform == 'phone' else 'mac-result.json'
    summary = validate(read(args.run/filename),read(args.run/'Fixtures/pool.json'),
                       read(args.run/'Fixtures/clips.json'),read(args.run/'reference.json'),platform=args.platform)
    summary['evidence_sha256'] = {str(p.relative_to(args.run)):sha256(p.read_bytes()).hexdigest()
                                  for p in (args.run/filename,args.run/'reference.json',
                                            args.run/'Fixtures/pool.json',args.run/'provenance.json')}
    target = args.output or args.run/('phone-summary.json' if args.platform == 'phone' else 'mac-summary.json')
    target.write_text(json.dumps(summary,indent=2)+'\n')
    for name,record in summary['candidates'].items():
        key = 'phone_p95_ms' if args.platform == 'phone' else 'laptop_native_p95_ms'
        print(f'{name}: {record[key]:.4f} ms p95; {record["samples"]} frames; parity passed')
