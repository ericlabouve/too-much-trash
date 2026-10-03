"""Assembly-access audit; knot probes are assumptions, not measured twine knots."""
import json, math
import build as b
import model as m

def main():
 p=m.Parameters();s=m.parts(p);results=[]
 for diameter,height in [(8,4),(10,6)]:
  knot=m.cylinder((33,0,21),(0,0,1),height,diameter)
  overlap=b.overlap(knot,s['actuator_bracket'])
  results.append({'assumed_knot_diameter_mm':diameter,'assumed_knot_height_mm':height,'bracket_intersection_mm3':round(overlap,3)})
 path,_,_=m.flexible_paths(p);turns=[]
 for i in range(1,len(path)-1):
  u=m.cq.Vector(*path[i]).sub(m.cq.Vector(*path[i-1])).normalized()
  v=m.cq.Vector(*path[i+1]).sub(m.cq.Vector(*path[i])).normalized()
  turns.append({'waypoint':i,'turn_degrees':round(math.degrees(math.acos(max(-1,min(1,u.dot(v))))),1)})
 result={'revision':'reinforced-r4','status':'Assembly access blocker found; no physical validation claimed','attachment':'6 mm axial hole through rocker input pad; intended tied end is not represented by the viewer centerline','released_pad_top_z_mm':21,'bracket_roof_bottom_z_mm':23,'headroom_mm':2,'knot_probes':results,'route_turns':turns,'limitations':['Knot probes are illustrative cylinders, not actual knots','Clear string centerline is insufficient evidence of attachment access or knot clearance','Route waypoints are prescribed; free twine may take a different contact path','No measured friction, force, strength, fatigue or camera framing'],'next':'Provide accessible knot space or another captive attachment, then repeat knot sweep and physical threading checks before full assembly printing'}
 b.save(b.OUT/'attachment-audit.json',result);print(json.dumps(result,indent=2))
if __name__=='__main__':main()
