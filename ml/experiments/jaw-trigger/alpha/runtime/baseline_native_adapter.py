import ctypes,json
from pathlib import Path
import numpy as np
HERE=Path(__file__).resolve().parent
F=ctypes.POINTER(ctypes.c_float); U=ctypes.POINTER(ctypes.c_uint8)
class Detector:
 def __init__(self,config,model):
  if isinstance(config,(str,Path)):config=json.loads(Path(config).read_text())
  if isinstance(model,(str,Path)):model=json.loads(Path(model).read_text())
  self.lib=ctypes.CDLL(str(HERE/'baseline_native.dylib'))
  self.is_conv=model.get('kind')=='conv'
  if self.is_conv:
   self.lib.create_conv.argtypes=[F,F,F,F,F,F,F,ctypes.c_float,ctypes.c_double,ctypes.c_double,ctypes.c_int];self.lib.create_conv.restype=ctypes.c_void_p
   self.lib.conv_step.argtypes=[ctypes.c_void_p,U,ctypes.c_double,F,ctypes.POINTER(ctypes.c_double)];self.lib.conv_step.restype=ctypes.c_int;self.lib.conv_destroy.argtypes=[ctypes.c_void_p]
   arrays=[np.ascontiguousarray(model[k],dtype=np.float32) for k in ('mean','scale','conv_w','conv_b','fc_w','fc_b','v')]
   self.handle=self.lib.create_conv(*[a.ctypes.data_as(F) for a in arrays],model['intercept'],config['threshold'],config['threshold']*config['release_ratio'],config['confirm']);self.native_calls=0;return
  self.lib.create.argtypes=[ctypes.c_int,ctypes.c_int,F,F,F,F,F,ctypes.c_float,ctypes.c_double,ctypes.c_double,ctypes.c_int];self.lib.create.restype=ctypes.c_void_p
  self.lib.step.argtypes=[ctypes.c_void_p,U,ctypes.c_double,F,ctypes.POINTER(ctypes.c_double)];self.lib.step.restype=ctypes.c_int
  self.lib.destroy.argtypes=[ctypes.c_void_p]
  a=[np.ascontiguousarray(model[k],dtype=np.float32) for k in ('mean','scale','w','b','v')]
  self.handle=self.lib.create((6 if model.get('feature_version')=='wide-visual-v4' else 5 if model.get('feature_version')=='fine-visual-v3' else 4 if model.get('feature_version')=='fine-fusion-v2' else 3 if model.get('feature_version')=='causal-fusion-v1' else 2 if model.get('feature_version')=='fine-grid-v3' else int(model.get('feature_version')=='contrast-grid-v2')),model['hidden'],*[x.ctypes.data_as(F) for x in a],float(model['intercept']),float(config['threshold']),float(config['threshold']*config['release_ratio']),int(config['confirm']));self.native_calls=0
 def step(self,frame,timestamp,sensors=None):
  frame=np.asarray(frame)
  if frame.dtype!=np.uint8 or frame.shape!=(240,320):raise ValueError('expected grayscale uint8 240x320')
  f=np.ascontiguousarray(frame);out=ctypes.c_double();e=(self.lib.conv_step if self.is_conv else self.lib.step)(self.handle,f.ctypes.data_as(U),float(timestamp),sensor_features(sensors,timestamp).ctypes.data_as(F),ctypes.byref(out));self.native_calls+=1
  return float(out.value),{0:None,1:'close',-1:'open'}[e]
 def close(self):
  if self.handle:(self.lib.conv_destroy if self.is_conv else self.lib.destroy)(self.handle);self.handle=None

class VisualDetector(Detector):
 def step(self,frame,timestamp,sensors=None):return Detector.step(self,frame,timestamp,None)

def create_detector(config,model):
 if isinstance(model,(str,Path)):model=json.loads(Path(model).read_text())
 if model.get('kind')=='attention':return AttentionDetector(config,model)
 return (Detector if model.get('feature_version') in ('causal-fusion-v1','fine-fusion-v2') else VisualDetector)(config,model)

def sensor_features(sensors,timestamp):
 out=np.zeros(8,dtype=np.float32)
 for k,name in enumerate(('gyroscope','accelerometer')):
  stream=(sensors or {}).get(name,{})
  times=np.asarray(stream.get('times',[]));vectors=stream.get('vectors',[])
  idx=int(np.searchsorted(times,timestamp,side='right'))-1
  if idx>=0:
   v=np.asarray(vectors[idx],dtype=np.float32);v=np.clip(v,-20,20);out[4*k:4*k+3]=v;out[4*k+3]=np.linalg.norm(v)
 return out

class AttentionDetector:
 def __init__(self,config,model):
  if isinstance(config,(str,Path)):config=json.loads(Path(config).read_text())
  self.lib=ctypes.CDLL(str(HERE/'baseline_native.dylib'));self.lib.attention_create.argtypes=[ctypes.c_int,ctypes.c_int,ctypes.c_int,ctypes.c_int,F,F,F,ctypes.c_double,ctypes.c_double,ctypes.c_int];self.lib.attention_create.restype=ctypes.c_void_p;self.lib.attention_step.argtypes=[ctypes.c_void_p,U,ctypes.c_double,ctypes.POINTER(ctypes.c_double)];self.lib.attention_step.restype=ctypes.c_int;self.lib.attention_destroy.argtypes=[ctypes.c_void_p]
  sd=model['state_dict'];order=['proj.weight','proj.bias','q.weight','q.bias','key.weight','key.bias','val.weight','val.bias','mix.weight','mix.bias','ff.weight','ff.bias','out.weight','out.bias','pos'];w=np.concatenate([np.asarray(sd[k],np.float32).ravel() for k in order]);m=np.asarray(model['mean'],np.float32);sc=np.asarray(model['scale'],np.float32)
  self.handle=self.lib.attention_create(model['hidden'],model['context'],len(model['mean']),2 if model['feature_version']=='fine-residual-v5' else 0,m.ctypes.data_as(F),sc.ctypes.data_as(F),w.ctypes.data_as(F),config['threshold'],config['threshold']*config['release_ratio'],config['confirm']);self.native_calls=0
 def step(self,frame,timestamp,sensors=None):
  f=np.asarray(frame)
  if f.dtype!=np.uint8 or f.shape!=(240,320):raise ValueError('expected grayscale uint8 240x320')
  f=np.ascontiguousarray(f);out=ctypes.c_double();e=self.lib.attention_step(self.handle,f.ctypes.data_as(U),float(timestamp),ctypes.byref(out));self.native_calls+=1;return float(out.value),{0:None,1:'close',-1:'open'}[e]
 def close(self):
  if self.handle:self.lib.attention_destroy(self.handle);self.handle=None
