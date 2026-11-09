"""Compare translated clamp ends and fasteners against sampled V3 assemblies.

Run from any directory. This checks rigid sampled positions, not full motion
or support requirements. The 5 mm candidate is used by build_preview.py.
"""
import sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parents[2] / "v3" / "source"))
import model as m
p=m.Parameters()
parts=m.parts(p)
base=m.assembly_parts(p,parts)
ends=[]
for z0,z1 in ((-40,-20),(50,70)):
    shapes=[parts[n].intersect(m.box(-30,20,-30,30,z0,z1)) for n in ('shaft_cap','carrier')]
    for n,s in base.items():
        if n.startswith('clamp_') and z0 < s.val().Center().z < z1:
            shapes.append(s)
    ends.append(shapes)
for inset in (0,5,8,10):
    print('INSET',inset,flush=True)
    for i,shapes in enumerate(ends):
        shifted=[s.translate((0,0,inset if i==0 else -inset)).val() for s in shapes]
        result={}
        for name in ('pulley','actuator_bracket','sliding_jaw'):
            targets=[]
            for width,button_y in ((66,29),(76,29),(86,44)):
                if name=='sliding_jaw':
                    targets.append(parts[name].translate((p.phone_right-width-m.SLIDING_BEAM_SHIFT,0,0)).val())
                else:
                    targets.append(parts[name].translate((p.phone_right,button_y,0)).val())
                    targets.append(parts[name].translate((p.phone_right,-button_y,0)).val())
            result[name]=round(min(s.distance(t) for s in shifted for t in targets),3)
        print('lower' if i==0 else 'upper',result,flush=True)
