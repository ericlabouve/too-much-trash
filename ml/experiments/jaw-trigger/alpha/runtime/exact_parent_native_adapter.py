import ctypes,json
from pathlib import Path
import importlib.util
H=Path(__file__).resolve().parent
def load(name):
 s=importlib.util.spec_from_file_location('r59p02_ind_'+name,H/(name+'.py'));m=importlib.util.module_from_spec(s);s.loader.exec_module(m);return m
class Detector:
 def __init__(self,config,model):
  if isinstance(config,(str,Path)):config=json.loads(Path(config).read_text())
  if isinstance(model,(str,Path)):model=json.loads(Path(model).read_text())
  self.base=load('assigned_baseline_adapter').create_detector({'event_gate':.1,'additive_high':.8,'visual_delta':.1,'dedup_until_opposite':True},json.loads((H/'baseline-model.json').read_text()))
  self.event=load('event_native_adapter').create_detector({'threshold':.5,'release_ratio':.4,'confirm':1},model);self.lib=self.event.lib
  self.lib.parent_add_create.argtypes=[ctypes.c_double]*2;self.lib.parent_add_create.restype=ctypes.c_void_p;self.lib.parent_add_step.argtypes=[ctypes.c_void_p,ctypes.c_void_p,ctypes.c_int,ctypes.c_double];self.lib.parent_add_step.restype=ctypes.c_int;self.lib.parent_add_destroy.argtypes=[ctypes.c_void_p]
  self.handle=self.lib.parent_add_create(config['independent_high'],config['refractory']);self.native_calls=0
  self.lib.parent_add_gate.argtypes=[ctypes.c_void_p,ctypes.c_double];self.lib.parent_add_gate(self.handle,config.get('independent_gate',0.))
 def step(self,frame,timestamp,sensors=None):
  score,original=self.base.step(frame,timestamp,sensors);self.event.step(frame,timestamp,sensors)
  edge=self.lib.parent_add_step(self.handle,self.event.handle,{None:0,'close':1,'open':-1}[original],float(timestamp));self.native_calls+=1
  return score,{0:None,1:'close',-1:'open'}[edge]
 def probabilities(self):return self.event.probabilities()
 def close(self):
  if self.handle:self.lib.parent_add_destroy(self.handle);self.handle=None
  self.base.close();self.event.close()
def create_detector(config,model):return Detector(config,model)
