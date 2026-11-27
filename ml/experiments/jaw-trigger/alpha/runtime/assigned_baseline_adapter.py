import ctypes,json
from pathlib import Path
import numpy as np
import importlib.util
H=Path(__file__).resolve().parent
def load(name):
 spec=importlib.util.spec_from_file_location('jaw57_'+name,H/(name+'.py'));mod=importlib.util.module_from_spec(spec);spec.loader.exec_module(mod);return mod
base_create=load('baseline_native_adapter').create_detector
event_create=load('event_native_adapter').create_detector
class Detector:
 def __init__(self,config,model):
  if isinstance(config,(str,Path)):config=json.loads(Path(config).read_text())
  if isinstance(model,(str,Path)):model=json.loads(Path(model).read_text())
  self.base=base_create({'threshold':.75,'release_ratio':.25/.75,'confirm':1},json.loads((H/'visual-component.json').read_text()))
  self.event=event_create({'threshold':.5,'release_ratio':.4,'confirm':1},model);self.lib=self.event.lib
  self.lib.gate_create.argtypes=[ctypes.c_double];self.lib.gate_create.restype=ctypes.c_void_p;self.lib.gate_step.argtypes=[ctypes.c_void_p,ctypes.c_void_p,ctypes.c_int];self.lib.gate_step.restype=ctypes.c_int;self.lib.gate_destroy.argtypes=[ctypes.c_void_p]
  self.lib.correction_create.argtypes=[ctypes.c_double]*3;self.lib.correction_create.restype=ctypes.c_void_p
  self.lib.correction_step.argtypes=[ctypes.c_void_p,ctypes.c_void_p,ctypes.c_int,ctypes.c_double,ctypes.c_double];self.lib.correction_step.restype=ctypes.c_int;self.lib.correction_destroy.argtypes=[ctypes.c_void_p]
  self.handle=self.lib.correction_create(config['additive_high'],config['visual_delta'],config['event_gate']);self.native_calls=0
  if config.get('dedup_until_opposite',False):
   self.lib.correction_dedup.argtypes=[ctypes.c_void_p];self.lib.correction_dedup(self.handle)
 def step(self,frame,timestamp,sensors=None):
  score,be=self.base.step(frame,timestamp);self.event.step(frame,timestamp,sensors)
  e=self.lib.correction_step(self.handle,self.event.handle,{None:0,'close':1,'open':-1}[be],score,float(timestamp));self.native_calls+=1
  return score,{0:None,1:'close',-1:'open'}[e]
 def probabilities(self):return self.event.probabilities()
 def close(self):
  if self.handle:self.lib.correction_destroy(self.handle);self.handle=None
  self.base.close();self.event.close()
def create_detector(config,model):return Detector(config,model)
