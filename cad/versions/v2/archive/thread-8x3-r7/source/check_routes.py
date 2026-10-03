"""Geometric passage and optical sensitivity checks; not friction/force validation."""
import json, math
from dataclasses import replace
import build as b
import model as m

def envelope(p,half):
 x0,x1=p.phone_left+2,p.phone_left+40;y0,y1=p.phone_length/2-43,p.phone_length/2-3
 growth=100*math.tan(math.radians(half))
 return m.cq.Workplane('XY',origin=((x0+x1)/2,(y0+y1)/2,22)).rect(x1-x0,y1-y0).workplane(offset=100).rect(x1-x0+2*growth,y1-y0+2*growth).loft()

def main():
 solids=m.parts(m.Parameters());result={'revision':'thread-8x3-r7','assumptions':{'twine_diameter_mm':3,'camera_lens_plane_z_mm':22,'camera':'Illustrative rectangle, not measured lenses; expanding square envelopes at 40/50/60 degree half angles','limitations':'Segmented route clearance only, not a contact, friction, force, wear or physical threading simulation'},'configurations':{}}
 for name,base in b.SAMPLES.items():
  for side in ('near','far'):
   p=replace(base,side=side);a=m.assembly_parts(p,solids);path,bands,_=m.flexible_paths(p)
   targets={**a,'phone':m.stock(p)['phone_envelope'],'shaft':m.stock(p)['stock_neck']}
   hits={}
   for i,(u,v) in enumerate(zip(path,path[1:])):
    cord=m.rod(u,v,3)
    for n,s in targets.items():
     vol=b.overlap(cord,s)
     if vol>.01:hits[f'{i}:{n}']=round(vol,3)
   optical={}
   flex={'twine_attachment':m.polyline(m.attachment_loop(p),3),'twine':m.polyline(path,3),**{n:m.polyline(pts,1.4) for n,pts in bands.items()}}
   for half in (40,50,60):
    view=envelope(p,half);oh={}
    for n,s in {**a,**flex}.items():
     v=b.overlap(view,s)
     if v>.01:oh[n]=round(v,3)
    optical[str(half)]=oh
   result['configurations'][name+'-'+side]={'twine_intersections_mm3':hits,'view_envelope_intersections_mm3':optical}
   print(name,side,json.dumps(result['configurations'][name+'-'+side]),flush=True)
 result['twine_passed']=all(not c['twine_intersections_mm3'] for c in result['configurations'].values())
 b.save(b.OUT/'route-validation.json',result)
if __name__=='__main__':main()
