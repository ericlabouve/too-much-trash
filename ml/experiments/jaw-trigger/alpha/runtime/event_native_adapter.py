import ctypes,json
from pathlib import Path
import numpy as np
H=Path(__file__).resolve().parent
F=ctypes.POINTER(ctypes.c_float);D=ctypes.POINTER(ctypes.c_double);U=ctypes.POINTER(ctypes.c_uint8)
class Detector:
 def __init__(self,config,model):
  if isinstance(config,(str,Path)):config=json.loads(Path(config).read_text())
  if isinstance(model,(str,Path)):model=json.loads(Path(model).read_text())
  self.lib=ctypes.CDLL(str(H/'event_native.dylib'));self.lib.fusion_create.argtypes=[ctypes.c_int]*4+[F]*5+[ctypes.c_double]*2+[ctypes.c_int];self.lib.fusion_create.restype=ctypes.c_void_p
  self.lib.fusion_step.argtypes=[ctypes.c_void_p,U,ctypes.c_double,ctypes.c_int,D,F,ctypes.c_int,D,F,D];self.lib.fusion_step.restype=ctypes.c_int;self.lib.fusion_destroy.argtypes=[ctypes.c_void_p]
  sd=model['state_dict'];order=['proj.weight','proj.bias','c1.weight','c1.bias','c2.weight','c2.bias','sp.weight','sp.bias','q.weight','q.bias','key.weight','key.bias','val.weight','val.bias','mix.weight','mix.bias','ff.weight','ff.bias','out.weight','out.bias','pos']
  w=np.concatenate([np.asarray(sd[k],np.float32).ravel() for k in order]);a=[np.ascontiguousarray(model[k],np.float32) for k in ('mean','scale','sensor_mean','sensor_scale')]+[w]
  self.handle=self.lib.fusion_create(model['hidden'],model['context'],int(model['use_sensor']),int(model.get('delta_head',False)),*[x.ctypes.data_as(F) for x in a],config['threshold'],config['threshold']*config['release_ratio'],config['confirm']);self.native_calls=0
  if model.get('sensor_highpass'):
   self.lib.fusion_highpass.argtypes=[ctypes.c_void_p];self.lib.fusion_highpass(self.handle)
  if model.get('late_fusion'):
   self.lib.fusion_late.argtypes=[ctypes.c_void_p,F,ctypes.c_float];sw=np.asarray(sd['sensor_out.weight'],np.float32).ravel();self.lib.fusion_late(self.handle,sw.ctypes.data_as(F),float(sd['sensor_out.bias'][0]))
  if model.get('feature_version')=='wide-event-residual-v1':
   self.lib.fusion_residual.argtypes=[ctypes.c_void_p];self.lib.fusion_residual(self.handle)
  if model.get('event_mode'):
   self.lib.fusion_event_mode.argtypes=[ctypes.c_void_p];self.lib.fusion_event_mode(self.handle)
  self.lib.fusion_outputs.argtypes=[ctypes.c_void_p,D]
 def probabilities(self):
  out=np.zeros(3,np.float64);self.lib.fusion_outputs(self.handle,out.ctypes.data_as(D));return out
 def step(self,frame,timestamp,sensors=None):
  f=np.asarray(frame)
  if f.dtype!=np.uint8 or f.shape!=(240,320):raise ValueError('expected grayscale uint8 240x320')
  f=np.ascontiguousarray(f);args=[];keep=[]
  for name in ('gyroscope','accelerometer'):
   st=(sensors or {}).get(name,{});ts=np.asarray(st.get('times',[]),np.float64);vs=np.asarray(st.get('vectors',[]),np.float32)
   end=int(np.searchsorted(ts,timestamp,side='right'));start=max(0,end-33);ts=np.ascontiguousarray(ts[start:end]);vs=np.ascontiguousarray(vs[start:end]);keep.extend([ts,vs]);args.extend([len(ts),ts.ctypes.data_as(D),vs.ctypes.data_as(F)])
  out=ctypes.c_double();e=self.lib.fusion_step(self.handle,f.ctypes.data_as(U),float(timestamp),*args,ctypes.byref(out));self.native_calls+=1;return float(out.value),{0:None,1:'close',-1:'open'}[e]
 def close(self):
  if self.handle:self.lib.fusion_destroy(self.handle);self.handle=None

def create_detector(config,model):return Detector(config,model)
