"""45-degree roof and matching stem; preserve all original arm/body vertices."""
import json, math
from pathlib import Path
import numpy as np
import trimesh
ROOT=Path(__file__).resolve().parents[1]
OUT=ROOT/'review/concepts/straight-arm-clip-45';OUT.mkdir(exist_ok=True)
source=ROOT/'print/jobs/2026-10-30-straight-arm-clip-tpu/clip-source.stl'
m=trimesh.load_mesh(source);v=m.vertices.copy();w=v.copy()
p=np.array([7.2,8.9,0]);a=math.radians(-35);R=np.array([[math.cos(a),-math.sin(a),0],[math.sin(a),math.cos(a),0],[0,0,1]])
u=(v-p)@R.T+p
peak=(abs(u[:,1])<1e-4)&(u[:,0]>6.39)&(u[:,0]<8.01)&(u[:,2]>5.44)&(u[:,2]<5.45)
assert peak.sum()==2
w[peak,2]=4.8
# Only trim upper stem; preserve original 35-degree underside and retaining head.
stem=(v[:,0]>=7.9999)&(v[:,0]<=10.0001)&(abs(v[:,1])<=1.3001)&(v[:,2]>3.15)&(v[:,2]<4.31)
w[stem,2]=np.minimum(v[stem,2],3.15+1.3-np.abs(v[stem,1]))
assert np.array_equal(v[~(peak|stem)],w[~(peak|stem)])
m.vertices=w;m.merge_vertices();m.update_faces(m.nondegenerate_faces());m.remove_unreferenced_vertices()
assert m.is_watertight and m.is_winding_consistent and m.volume>0
# Stem section fits inside hole in intended rigid seated relationship (receiver X8.2..9.8).
s=w[(v[:,0]>=7.9999)&(v[:,0]<=10.0001)&(abs(v[:,1])<=1.3001)&(v[:,2]>=1.6999)&(v[:,2]<=4.31)]
clearance=4.8-np.abs(s[:,1])-s[:,2]
assert clearance.min()>.14
m.export(OUT/'clip.stl')
r={'revision':'straight-arm-roof45-fit-v1','source':str(source.relative_to(ROOT)),'nominal_opening_mm':[12.8,17.8],'roof_deg_from_bed':45,'roof_rise_mm':1.5,'band_width_mm':6,'wall_mm':1.6,'arm_print_angle_deg':35,'hole_width_mm':3,'stem_width_mm':2.6,'original_retaining_lip_mm':3.4,'minimum_roof_clearance_mm':float(clearance.min()),'body_arms_unchanged':True,'watertight':True,'limits':['Original lip and underside preserved; only hole peak and upper stem trimmed.','Analytical seated stem clearance is not physical insertion, retention or flex validation.','No print.']}
(OUT/'fit-attachment-check.json').write_text(json.dumps(r,indent=2)+'\n');print(r)
