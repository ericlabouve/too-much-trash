"""Nest projected part silhouettes, retaining the approved bed-facing planes."""
import json,random
from pathlib import Path
import numpy as np
import trimesh
import shapely
from shapely import affinity
from scipy.signal import fftconvolve
ROOT=Path(__file__).resolve().parents[1]
OUT=ROOT/'review/compact-rigid';OUT.mkdir(exist_ok=True)
names=['carrier','shaft_cap','sliding_jaw','actuator_bracket','plunger','pulley','pulley_axle']
variants={};sources={}
for name in names:
    src=ROOT/'print'/f'{name}.stl'
    if name in ('carrier','shaft_cap'):src=ROOT/'print/jobs/2026-10-26-ramped-fixed-hook-source'/f'{name}.stl'
    if name=='shaft_cap':src=ROOT/'print/jobs/2026-10-26-final-materials-source/shaft_cap.stl'
    if name=='sliding_jaw':src=ROOT/'print/sliding_jaw.stl'
    sources[name]=str(src.relative_to(ROOT))
    mesh=trimesh.load_mesh(src)
    triangles=mesh.triangles[:,:,:2]
    polys=shapely.polygons(triangles)
    footprint=shapely.union_all(polys[shapely.area(polys)>1e-8]).buffer(0)
    variants[name]=[]
    for angle in (0,90,180,270):
        poly=affinity.rotate(footprint,angle,origin=(0,0)).buffer(2.2)
        x0,y0,x1,y1=poly.bounds
        poly=affinity.translate(poly,-x0,-y0)
        xx,yy=np.meshgrid(np.arange(int(np.ceil(x1-x0)))+.5,np.arange(int(np.ceil(y1-y0)))+.5)
        mask=shapely.contains_xy(poly,xx,yy)
        variants[name].append((angle,mask,(x0,y0)))
random.seed(26);best=None
for trial in range(400):
    used=np.zeros((180,180),dtype=bool)
    used[:5,:]=True;used[-3:,:]=True;used[:,:3]=True;used[:,-3:]=True
    used[151:,155:]=True
    order=names[:3];random.shuffle(order)
    tail=names[3:];random.shuffle(tail);order+=tail
    placements={}
    for name in order:
        candidates=[]
        for angle,mask,origin in variants[name]:
            scores=fftconvolve(used.astype(float),mask[::-1,::-1].astype(float),mode='valid')
            ys,xs=np.where(scores<.1)
            if len(xs):
                # Alternate compact corners to avoid a one-direction greedy dead end.
                metric=xs+ys if trial%4==0 else -xs+ys if trial%4==1 else xs-ys if trial%4==2 else -xs-ys
                i=int(np.argmin(metric));candidates.append((float(metric[i])+random.random()*8,int(xs[i]),int(ys[i]),angle,mask,origin))
        if not candidates:break
        _,x,y,angle,mask,origin=min(candidates,key=lambda c:c[0])
        used[y:y+mask.shape[0],x:x+mask.shape[1]]|=mask
        # Sources are re-centered by the plate adapter after rotation.
        mesh=trimesh.load_mesh(ROOT/sources[name]);rot=trimesh.transformations.rotation_matrix(np.deg2rad(angle),[0,0,1]);mesh.apply_transform(rot)
        cx,cy=mesh.bounds[:,:2].mean(axis=0)
        placements[name]={'angle':angle,'center_xy_mm':[float(x-origin[0]+cx),float(y-origin[1]+cy)]}
    if len(placements)==len(names):best=placements;break
assert best is not None,'No silhouette packing found; preserve current two-plate layout.'
report={'parts':best,'sources':sources,'trial':trial,'projection_clearance_buffer_mm':2.2,'grid_mm':1,'limits':['Projected geometry only: actual deposited support paths must be checked after slicing.']}
(OUT/'layout.json').write_text(json.dumps(report,indent=2)+'\n');print(json.dumps(report,indent=2))
