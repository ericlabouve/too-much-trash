"""Score complete native train/validation traces without fitting or pool admission."""
import argparse
from copy import deepcopy
from hashlib import sha256
import json
import math
from pathlib import Path

from phone_benchmark import percentile
import round_one


def score(run):
    read=lambda name:json.loads((run/name).read_text())
    provenance=read('provenance.json');source=Path(provenance['result_path'])
    if sha256(source.read_bytes()).hexdigest()!=provenance['source_result_sha256']:
        raise ValueError('Frozen source result changed')
    prior=json.loads(source.read_text());pool=read('Fixtures/pool.json');manifest=read('Fixtures/clips.json')
    splits=read('split-index.json');result=read('mac-result.json')
    if any(result.get(key)!=pool[key] for key in ('suite','round','result_sha256','pool_sha256')):
        raise ValueError('Native outputs do not match frozen models')
    if result.get('interrupted') is not False or result.get('low_power') is not False or result.get('thermal_start')!=0 or result.get('thermal_end')!=0:
        raise ValueError('Invalid native benchmark environment')
    files={c['file']:c for c in manifest};candidates={c['candidate']['name']:c for c in pool['candidates']}
    by_file={row['file']:(split,row) for split,rows in splits.items() for row in rows}
    if set(files)!=set(by_file) or set(splits)!={'train','validation'}:
        raise ValueError('Only the exact frozen train and validation inputs may be scored')
    for name,digest in provenance['fixture_sha256'].items():
        if sha256((run/'Fixtures'/name).read_bytes()).hexdigest()!=digest:
            raise ValueError('Native input fixture changed')
    records=result['results'];seen=set();previous=-math.inf;predictions={};timings={name:[] for name in candidates}
    if len(records)!=len(candidates)*pool['repeats']:raise ValueError('Incomplete candidate replay')
    for record in records:
        name=record['candidate']['name'];repeat=record['pass']
        if (name not in candidates or record['candidate']!=candidates[name]['candidate']
                or record['model_sha256']!=candidates[name]['model_sha256'] or (name,repeat) in seen
                or type(repeat) is not int or not 0<=repeat<pool['repeats']):raise ValueError('Candidate identity or pass mismatch')
        seen.add((name,repeat));begin,end=record['started_uptime_seconds'],record['finished_uptime_seconds']
        if not all(math.isfinite(v) for v in (begin,end)) or begin<previous or end<=begin:raise ValueError('Native candidates were not serial')
        previous=end
        if record['thermal_start']!=0 or record['thermal_end']!=0:raise ValueError('Non-nominal thermal state')
        if len(record['clips'])!=len(files) or {c['file'] for c in record['clips']}!=set(files):raise ValueError('Missing native clips')
        observed={}
        for clip in record['clips']:
            file=clip['file'];count=len(files[file]['timestamps']);split,row=by_file[file]
            if clip['sample_count']!=count or len(clip['scores'])!=count or len(clip['ms'])!=count:raise ValueError('Missing native frames')
            if any(not isinstance(v,(float,int)) or not math.isfinite(v) for v in clip['scores']+clip['ms']) or any(v<0 for v in clip['ms']):raise ValueError('Invalid native scores/durations')
            for event in clip['events']:
                if len(event)!=2 or event[0] not in ('close','open') or event[1] not in files[file]['timestamps']:raise ValueError('Event is not a native confirmation frame')
            observed[file]=clip['events']
            if split=='validation':timings[name].extend(clip['ms'])
        if name in predictions and predictions[name]!=observed:raise ValueError('Native repeated passes disagree on events')
        predictions[name]=observed
    round_one.MATCH_SECONDS=prior['settings']['match_seconds'];entries=[]
    originals={entry['candidate']['name']:entry for entry in prior['ranked']}
    for candidate in prior['next_pool']:
        name=candidate['name'];p=predictions[name]
        metrics={split:round_one.accuracy([p[row['file']] for row in rows],[row['jaw_reference'] for row in rows]) for split,rows in splits.items()}
        p95=percentile(timings[name],.95)
        if p95<=0:raise ValueError('Unmeasurable native p95')
        settings=prior['settings'];speed=min(1.,max(0.,(settings['frame_budget_ms']-p95)/(settings['frame_budget_ms']-settings['full_speed_ms'])))
        entry=deepcopy(originals[name]);entry.update(development=metrics['validation'],split_scores=metrics|{'test':None},p95_ms=p95,
            speed_score=speed,fitness=settings['jaw_weight']*metrics['validation']['f1']+(1-settings['jaw_weight'])*speed)
        labels=[row['jaw_reference'] for row in splits['validation']];events=[p[row['file']] for row in splits['validation']]
        per=[round_one.accuracy([prediction],[label]) for prediction,label in zip(events,labels)]
        entry['clip_f1']=[m['f1'] for m in per];entry['zero_jaw_clips']=sum(m['matched']==0 for m in per)
        entry['worst_clip_accuracy']=min(round_one.precision_weighted_accuracy(m) for m in per)
        entry['jaw_by_event']={kind:round_one.accuracy([[(k,t) for k,t in prediction if k==kind] for prediction in events],[{kind:l[kind]} for l in labels]) for kind in ('close','open')}
        entry['native_validation_samples']=len(timings[name]);entries.append(entry)
    entries.sort(key=lambda e:e['fitness'],reverse=True)
    native={key:deepcopy(prior[key]) for key in ('round','settings','seed','mode','reporting','candidate_metadata',
                                               'evaluation_protocol','integrity_review') if key in prior}
    native.update(benchmark_protocol='deployment-v1',ranked=entries,incumbents=entries,challengers=[],next_pool=[e['candidate'] for e in entries])
    native['settings']=prior['settings']|{'benchmark_protocol':'deployment-v1'}
    counts={split:len(rows) for split,rows in splits.items()}
    return {'status':'validated','platform':'deployment-evaluation','source_result_sha256':provenance['source_result_sha256'],
            'benchmark_protocol':'deployment-v1','round':prior['round'],'device':result['model'],'counts':counts,
            'settings':prior['settings'],'scope':result['scope'],'entries':entries,'native_result':native,
            'candidate_metadata':prior.get('candidate_metadata',{}),'integrity_review':prior.get('integrity_review'),
            'evaluation_protocol':'clip_replay-v1','test_read':False,'fitting_performed':False,
            'summary':f"Deployment C++ CPU · {counts['train']} train / {counts['validation']} validation / reserved test · same artifact supplies F1 and p95",
            'evidence_sha256':{name:sha256((run/name).read_bytes()).hexdigest() for name in ('mac-result.json','split-index.json','provenance.json','Fixtures/pool.json','Fixtures/clips.json')}}


if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__);parser.add_argument('run',type=Path);args=parser.parse_args()
    summary=score(args.run);(args.run/'deployment-summary.json').write_text(json.dumps(summary,indent=2)+'\n')
    for entry in summary['entries']:print(f"{entry['candidate']['name']}: native train F1 {entry['split_scores']['train']['f1']:.6f}, validation F1 {entry['development']['f1']:.6f}, p95 {entry['p95_ms']:.6f} ms",flush=True)
