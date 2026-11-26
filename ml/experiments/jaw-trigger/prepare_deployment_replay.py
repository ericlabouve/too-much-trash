"""Export every frozen train/validation input for deployment-artifact scoring.

No fitting, inference or test-media read. Ground truth and identity stay in the
host split index, outside the inference fixtures.
"""
import argparse
from hashlib import sha256
import json
from pathlib import Path
import pickle

import numpy as np

from prepare_pool_replay import runtime_model


def export(result_path, output):
    result_path=result_path.resolve(strict=True)
    result=json.loads(result_path.read_text());job=result_path.parent
    index=json.loads((job/'prepared-index.json').read_text())
    fixtures=output/'Fixtures';fixtures.mkdir(parents=True,exist_ok=False)
    canonical=lambda v:json.dumps(v,sort_keys=True,separators=(',',':'))
    spec={'suite':'jaw-pool-native-v1','round':result['round'],'repeats':3,
          'result_sha256':sha256(result_path.read_bytes()).hexdigest(),
          'pool_sha256':sha256(canonical(result['next_pool']).encode()).hexdigest(),
          'candidates':[{'candidate':c,'parameters':runtime_model(result['feature_parameters'].get(c['method'],{})),
                         'model_sha256':sha256(canonical(result['feature_parameters'].get(c['method'],{})).encode()).hexdigest()}
                        for c in result['next_pool']]}
    clips=[];splits={};hashes={}
    for split in ('train','validation'):
        rows=json.loads((job/f'{split}.json').read_text())['clips'];splits[split]=[]
        if len(rows)!=len(index[split]):raise ValueError('Prepared cache and split disagree')
        for row,source in zip(rows,index[split]):
            with open(source,'rb') as stream:data=pickle.load(stream)
            if data['row']['clip']!=row['clip']:raise ValueError('Prepared identity does not match split')
            name=f'clip-{len(clips):03d}.bin';frames=data['frames']
            pixels=np.stack([frame for _,frame in frames]).astype(np.uint8)
            if pixels.shape[1:]!=(240,320):raise ValueError('Unexpected prepared frame dimensions')
            path=fixtures/name;path.write_bytes(pixels.tobytes());hashes[name]=sha256(path.read_bytes()).hexdigest()
            clips.append({'file':name,'timestamps':[float(t) for t,_ in frames],
                          'sensors':{name:{'times':np.asarray(t).tolist(),'vectors':np.asarray(v).tolist()}
                                     for name,(t,v) in data['sensors']['imu'].items() if name in ('accelerometer','gyroscope')}})
            splits[split].append({'file':name,'clip':row['clip'],'jaw_reference':row['jaw_reference'],
                                   'frame_count':len(frames),'source':source})
        print(f'Exported {len(rows)} {split} clips',flush=True)
    (fixtures/'pool.json').write_text(json.dumps(spec));(fixtures/'clips.json').write_text(json.dumps(clips))
    (output/'split-index.json').write_text(json.dumps(splits))
    (output/'provenance.json').write_text(json.dumps({'result_path':str(result_path),
        'source_result_sha256':spec['result_sha256'],'pool_sha256':spec['pool_sha256'],
        'fitting_performed':False,'test_read':False,'fixture_sha256':hashes,
        'train_manifest_sha256':sha256((job/'train.json').read_bytes()).hexdigest(),
        'validation_manifest_sha256':sha256((job/'validation.json').read_bytes()).hexdigest()},indent=2))


if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('result',type=Path);parser.add_argument('output',type=Path)
    args=parser.parse_args();export(args.result,args.output)
