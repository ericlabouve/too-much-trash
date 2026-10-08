from pathlib import Path
import zipfile,re,json,hashlib
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
from matplotlib.collections import LineCollection
w=Path(__file__).parent; report={}
with zipfile.ZipFile(w/'tmt-r10-neck-endface-r2.gcode.3mf') as z:
 for plate,name in [(1,'neck_fit_pair')]:
  data=z.read(f'Metadata/plate_{plate}.gcode');text=data.decode();(w/f'plate_{plate}.gcode').write_bytes(data)
  for f in (f'plate_{plate}.png',f'top_{plate}.png'):(w/f).write_bytes(z.read('Metadata/'+f))
  keys=('printer_model','printer_variant','layer_height','wall_loops','sparse_infill_density','curr_bed_type','outer_wall_speed','inner_wall_speed','nozzle_temperature','textured_plate_temp','enable_support','brim_width','print_sequence')
  settings={k:re.search(r'^; '+re.escape(k)+r' = (.*)$',text,re.M).group(1) for k in keys}
  assert settings['printer_model']=='Bambu Lab A1 mini' and settings['printer_variant']=='0.4'
  assert settings['layer_height']=='0.2' and settings['wall_loops']=='3' and settings['curr_bed_type']=='Textured PEI Plate'
  h=None;feature='';x=y=ep=0.;absolute=False;segments=[]
  for line in text.splitlines():
   if line.startswith('; Z_HEIGHT:'):h=float(line.split(':')[1])
   elif line.startswith('; FEATURE:'):feature=line.split(':',1)[1].strip()
   elif line.startswith('M82'):absolute=True
   elif line.startswith('M83'):absolute=False
   elif line.startswith('G92 E'):ep=float(line.split(';')[0].split('E')[1].split()[0])
   elif line.startswith(('G0 ','G1 ','G2 ','G3 ')):
    v={k:float(n) for k,n in re.findall(r'([XYE])(-?(?:\d+(?:\.\d*)?|\.\d+))',line.split(';')[0])};nx=v.get('X',x);ny=v.get('Y',y);ev=v.get('E',ep if absolute else 0);de=ev-ep if absolute else ev
    if h is not None and de>0 and (nx!=x or ny!=y) and feature not in ('Custom','Flush',''):
     assert not line.startswith(('G2 ','G3 '));segments.append((h,feature,(x,y),(nx,ny)))
    x,y=nx,ny
    if 'E' in v:ep=ev if absolute else ep+ev
  pts=[p for h,f,a,b in segments for p in (a,b)];bounds=[[min(p[k] for p in pts) for k in (0,1)],[max(p[k] for p in pts) for k in (0,1)]]
  assert all(0<=v<=180 for row in bounds for v in row),bounds
  modelheights=sorted({h for h,f,a,b in segments if not f.startswith('Support')});targets=[.2,1,3,5,8,12,16,20]
  fig,axes=plt.subplots(2,4,figsize=(14,7))
  for ax,t in zip(axes.flat,targets):
   h=min(modelheights,key=lambda h:abs(h-t));rows=[(a,b,f) for hh,f,a,b in segments if abs(hh-h)<.15]
   ax.add_collection(LineCollection([(a,b) for a,b,f in rows],colors=['#2587be' if f.startswith('Support') else '#e87c30' for a,b,f in rows],linewidths=.4));ax.set_xlim(65,115);ax.set_ylim(60,120);ax.set_aspect('equal');ax.set_title(f'Z {h:.2f} mm ±0.15')
  fig.suptitle(name+' — orange model / blue support; no brim');fig.tight_layout();fig.savefig(w/(name+'-layers.png'),dpi=120);plt.close(fig)
  report[str(plate)]={'name':name,'gcode_md5':hashlib.md5(data).hexdigest(),'actual_settings':settings,'model_support_brim_xy_bounds_mm':bounds,'max_print_z_mm':max(h for h,f,a,b in segments)}
(w/'review.json').write_text(json.dumps(report,indent=2));print(json.dumps(report,indent=2))
