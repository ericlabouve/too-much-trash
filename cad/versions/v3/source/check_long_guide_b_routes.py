"""Conservative capsule clearance between the band sweep and 1 mm string.
The band centerline may shift ±1 mm across its provisional 3 mm total width;
adding 0.5 mm radius gives 1 mm thickness and rounded corners.
"""
from pathlib import Path
import json
import numpy as np
from scipy.optimize import lsq_linear
ROOT=Path(__file__).resolve().parents[1]/'review/concepts/long-guide-b'
frames=json.loads((ROOT/'motion-paths.json').read_text())
def segments(points):return list(zip(np.asarray(points[:-1]),np.asarray(points[1:])))
def clearance(band,string):
 best=float('inf')
 for a,b in segments(band):
  for c,d in segments(string):
   M=np.column_stack((b-a,c-d,[0,0,1]));fit=lsq_linear(M,c-a,bounds=([0,0,-1],[1,1,1]),tol=1e-10)
   best=min(best,float(np.linalg.norm(M@fit.x-(c-a)))-1)
 return best
rows=[]
for f in [frames[i] for i in [0,3,7,10,13,17,20]]:
 row={'travel_mm':f['travel'],'band_to_string_wrap_mm':clearance(f['band'],f['attachment']),'band_to_pulley_lead_mm':clearance(f['band'],f['lead'])};rows.append(row)
report={'method':'Bounded least-squares minimum distance between all segment pairs, continuous band width sweep; subtract both 0.5 mm radii. Nominal paths, no deformation or tension prediction.','band_width_mm':3,'band_thickness_mm':1,'string_diameter_mm':1,'samples':rows}
(ROOT/'band-string-clearance.json').write_text(json.dumps(report,indent=2)+'\n');print(json.dumps(report,indent=2))
assert min(min(r['band_to_string_wrap_mm'],r['band_to_pulley_lead_mm']) for r in rows)>0

# Nut turning envelope, radius 9.3 mm including allowance; fixed at the old mount.
from scipy.optimize import minimize
def nut_gap(point):
 u,v,w=point
 return np.hypot(max(np.hypot(u+18,w-9.8)-9.3,0),max(29.65-v,v-35.65,0))-.5
best=100
for f in frames:
 for a,b in segments(f['band']):
  for start in [[.5,0],[0,-1],[1,1]]:
   fit=minimize(lambda q:nut_gap(a+q[0]*(b-a)+np.array([0,0,q[1]])),start,bounds=[(0,1),(-1,1)],method='SLSQP',options={'ftol':1e-9})
   best=min(best,float(fit.fun))
report['minimum_band_to_nut_envelope_mm']=best
(ROOT/'band-string-clearance.json').write_text(json.dumps(report,indent=2)+'\n')
assert best>.4,best
print('Nut envelope minimum gap',best)
