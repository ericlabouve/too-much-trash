"""Local vertex edits of exact accepted mesh: hole peak and matching stud only."""
import json,math
from pathlib import Path
import numpy as np
import trimesh
ROOT=Path(__file__).resolve().parents[1]
OUT=ROOT/'review/concepts/clip-roof-only';OUT.mkdir(exist_ok=True)
source=ROOT/'print/jobs/2026-10-30-straight-arm-clip-tpu/clip-source.stl'
base=trimesh.load_mesh(source);v=base.vertices.copy();p=np.array([7.2,8.9,0]);a=math.radians(-35)
R=np.array([[math.cos(a),-math.sin(a),0],[math.sin(a),math.cos(a),0],[0,0,1]])
u=(v-p)@R.T+p
peak=(abs(u[:,1])<1e-4)&(u[:,0]>6.39)&(u[:,0]<8.01)&(u[:,2]>5.44)&(u[:,2]<5.45)
peg=(v[:,0]>=7.9999)&(v[:,0]<=11.0001)&(abs(v[:,1])<=1.7001)&(v[:,2]>3.15)&(v[:,2]<4.71)
assert peak.sum()==2
rows=[]
for angle in [45,35]:
 m=base.copy();w=v.copy();w[peak,2]=3.3+1.5*math.tan(math.radians(angle))
 # Stud unchanged to isolate roof support behavior.
 m.vertices=w
 assert m.is_watertight and m.is_winding_consistent and m.volume>0
 assert np.array_equal(w[~(peak|peg)],v[~(peak|peg)])
 m.export(OUT/f'roof-{angle}.stl')
 rows.append({'angle_from_bed_deg':angle,'roof_rise_mm':1.5*math.tan(math.radians(angle)),'modified_peak_vertices':int(peak.sum()),'modified_stud_vertices':0,'all_other_vertices_unchanged':True})
(OUT/'fit-attachment-check.json').write_text(json.dumps({'revision':'isolated-roof-angle-study-v1','source':str(source.relative_to(ROOT)),'candidates':rows,'limits':['Only local roof and stud mesh vertices changed; body and arms byte-identical coordinates.','Seated fit and retention require review and physical testing. No print.']},indent=2)+'\n')
