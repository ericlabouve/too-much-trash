"""Require active jaw/cap geometry to match the approved manufacturing solids."""
import json
from pathlib import Path
import cadquery as cq
import model as m
root=Path(__file__).resolve().parents[1]
vol=lambda s:sum(v.Volume() for v in s.solids().vals())
r={}
for name,path,angle in [('carrier','2026-10-26-ramped-fixed-hook-source',0),('shaft_cap','2026-10-26-final-materials-source',-90)]:
 reference=cq.importers.importStep(str(root/'print/jobs'/path/(name+'.step')))
 if angle:reference=reference.rotate((0,0,0),(0,0,1),angle)
 reference=reference.rotate((0,0,0),(0,1,0),-90)
 current=getattr(m,name)(m.Parameters())
 delta=vol(reference.cut(current))+vol(current.cut(reference))
 r[name]={'symmetric_difference_mm3':delta,'valid_single_solid':current.val().isValid() and len(current.val().Solids())==1,'reference':path}
 print(name,delta,flush=True)
 assert delta<1e-4 and r[name]['valid_single_solid']
(root/'review/plate-bom-match.json').write_text(json.dumps(r,indent=2)+'\n')
