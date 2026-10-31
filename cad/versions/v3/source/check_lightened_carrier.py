"""Fixed-jaw through-window audit; CAD integrity is not loaded strength."""
import json
import build as b
p=b.Parameters()
old=b.carrier(p,lightened=False);new=b.carrier(p)
volume=lambda s:sum(v.Volume() for v in s.solids().vals())
assert new.val().isValid() and len(new.val().Solids())==1
assert volume(new.cut(old))<1e-6
# Exact preservation of stud, track root, interlock, stop and band cleat.
bridge=b.box(-150,20,-70,70,4,38)
assert volume(old.intersect(bridge).cut(new))<1e-6
track=b.box(-150,-12,-70,70,-50,90)
assert volume(old.intersect(track).cut(new))<1e-6
for z0,z1 in ((-30,4),(38,60)):
    assert volume(new.intersect(b.box(-12,-.4,-1,1,z0+6,z1-6)))<1e-6
for y,z in b.CLAMP_STATIONS:
    boss=b.cylinder((-15,y,z),(1,0,0),30,18)
    assert volume(old.intersect(boss).cut(new))<1e-6
report=dict(revision=b.REVISION,passed=True,valid=True,solid_count=1,
 baseline_volume_mm3=volume(old),volume_mm3=volume(new),
 removed_volume_mm3=volume(old)-volume(new),
 solid_volume_reduction_percent=100*(1-volume(new)/volume(old)),
 window_width_mm=11,window_z_intervals_mm=[[-30,4],[38,60]],
 preserved_bridge_z_mm=[4,38],side_rail_width_mm=8.3,
 unchanged=['cuff stud and base','track root and interlock','four screw bosses','cap'],
 limits=['No new slice or print; CAD volume is not filament savings.',
 'Perimeter frame stiffness, neck contact and loaded retention require physical testing.',
 'Existing phone-fit and cord-routing issues remain unresolved.'])
(b.ROOT/'review/lightened-fixed-jaw.json').write_text(json.dumps(report,indent=2)+'\n')
print(json.dumps(report,indent=2))
