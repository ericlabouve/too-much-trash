"""Optional macOS Bambu reference slicing; never sends a print job.
A1 mini/Generic PLA is a reference configuration, not a qualified PLA+ recipe.
Keeps gcode in a temporary folder; records STL hashes, warnings and layer previews.
"""
from pathlib import Path
import hashlib,json,subprocess,tempfile,re
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
from matplotlib.collections import LineCollection
ROOT=Path(__file__).resolve().parents[1]
APP=Path('/Applications/BambuStudio.app/Contents')
SLICER=APP/'MacOS/BambuStudio'
PROFILES=APP/'Resources/profiles/BBL'

def main(print_dir=ROOT/'print', a1_mini_threads=False):
 print_dir=Path(print_dir)
 index={}
 for path in PROFILES.rglob('*.json'):
  try:
   data=json.loads(path.read_text())
   if 'name' in data:index[data['name']]=data
  except (ValueError,UnicodeError):pass
 def resolve(name):
  d=index[name].copy();parent=d.pop('inherits',None)
  base=resolve(parent) if parent else {};base.update(d);return base
 work=Path(tempfile.mkdtemp(prefix='tmt-v3-slice-'))
 machine_name='Bambu Lab A1 mini 0.4 nozzle'
 process_name='0.20mm Standard @BBL A1M'
 filament_name='Generic PLA @BBL A1M'
 for kind,name in [('machine',machine_name),('process',process_name),('filament',filament_name)]:
  profile=resolve(name)
  (work/(kind+'.json')).write_text(json.dumps(profile))
 manifest=json.loads((print_dir/'manifest.json').read_text())
 report={'slicer':'Bambu Studio 02.07.01.62','reference_printer':machine_name,'reference_material':'Generic PLA; not a qualified PLA+ profile','layer_height_mm':'Per part; see parts' ,'actual_prints_validated':False,'scope':'Each design sliced individually at 100%. Supports generated where enabled; review layer PNGs. No printer-ready job supplied. Check support removal and actual machine/material settings.','parts':[]}
 for part in manifest['parts']:
  name=part['name'];file=print_dir/part['file'];out=work/name;out.mkdir()
  trial=name.startswith(('trial_screw_','trial_nut_'))
  threaded=trial or name in ('thumb_screw','thumb_nut','rocker')
  layer=float(part.get('layer_mm',.12 if threaded else .2))
  assert not threaded or layer<=.12,(name,'Threaded parts require 0.12 mm or finer')
  process=resolve('0.12mm Fine @BBL A1M' if layer<=.12 else process_name)
  filament=resolve(filament_name)
  if threaded:
   filament.update(fan_min_speed=['100'],fan_max_speed=['100'],slow_down_layer_time=['12'],close_fan_the_first_x_layers=['1'],full_fan_speed_layer=['3'])
  (work/'filament.json').write_text(json.dumps(filament))
  solid=trial or name in ('thumb_screw','thumb_nut','pivot_key')
  support=not trial and name not in ('thumb_screw','thumb_nut')
  process.update(support_threshold_angle='20' if name=='rocker' else '30',enable_arc_fitting='0',sparse_infill_pattern='zig-zag' if solid else 'grid',curr_bed_type='Textured PEI Plate',layer_height=str(layer),initial_layer_print_height='0.2',enable_support='1' if support else '0',support_type='normal(auto)',support_on_build_plate_only='0',wall_loops='6' if solid else '5',sparse_infill_density='100%' if solid else '60%' if name=='rocker' else '40%' if name in ('shaft_cap','actuator_bracket','string_guide') else '35%')
  if name in ('thumb_screw','thumb_nut'):
   process.update(wall_loops='2',sparse_infill_density='15%',sparse_infill_pattern='grid')
  if threaded:
   process.update(outer_wall_speed=['30'],inner_wall_speed=['60'],internal_solid_infill_speed=['80'],gap_infill_speed=['40'],enable_overhang_speed='1',overhang_1_4_speed=['30'],overhang_2_4_speed=['20'],overhang_3_4_speed=['15'],overhang_4_4_speed=['10'])
  (work/'process.json').write_text(json.dumps(process))
  args=[str(SLICER),'--load-settings',str(work/'machine.json')+';'+str(work/'process.json'),'--load-filaments',str(work/'filament.json'),'--arrange','1','--orient','0','--slice','0','--outputdir',str(out),str(file)]
  run=subprocess.run(args,capture_output=True,text=True,timeout=120)
  (out/'cli.log').write_text(run.stdout+run.stderr)
  result=json.loads((out/'result.json').read_text())
  assert run.returncode==0 and result['return_code']==0,(name,result,run.stderr)
  plate=result['sliced_plates'][0]
  row={'name':name,'stl_sha256':hashlib.sha256(file.read_bytes()).hexdigest(),'return_code':0,'warning':plate.get('warning_message',''),'layer_height_mm':layer,'bed_type':process['curr_bed_type'],'supports_enabled':support,'support_threshold_angle':int(process['support_threshold_angle']),'support_seconds':sum(t for k,t in plate['feature_type_times'].items() if k.startswith('Support')),'wall_loops':int(process['wall_loops']),'infill':process['sparse_infill_density'],'reference_total_g':round(plate['filaments'][0]['total_used_g'],2)}
  # Show actual extrusion paths at selected heights. Orange=model, blue=support.
  layers={};height=None;feature='';x=y=0.;absolute_e=False;e_pos=0.
  for line in (out/'plate_1.gcode').read_text().splitlines():
   if line.startswith('; Z_HEIGHT:'):height=float(line.split(':')[1]);layers.setdefault(height,[])
   elif line.startswith('; FEATURE:'):feature=line.split(':',1)[1].strip()
   elif line.startswith('M82'):absolute_e=True
   elif line.startswith('M83'):absolute_e=False
   elif line.startswith('G92 E'):e_pos=float(line.split(';')[0].split('E')[1].split()[0])
   elif line.startswith(('G0 ','G1 ')):
    vals={k:float(v) for k,v in re.findall(r'([XYE])(-?(?:\d+(?:\.\d*)?|\.\d+))',line.split(';')[0])}
    nx,ny=vals.get('X',x),vals.get('Y',y);ev=vals.get('E',e_pos if absolute_e else 0);extrusion=(ev-e_pos if absolute_e else ev)
    if height is not None and extrusion>0 and (nx!=x or ny!=y):layers[height].append(((x,y),(nx,ny),'#2587be' if feature.startswith('Support') else '#e87c30'))
    x,y=nx,ny
    if 'E' in vals:e_pos=ev if absolute_e else e_pos+ev
  heights=sorted(layers);chosen=sorted(set([heights[0]]+[min(heights,key=lambda z:abs(z-heights[-1]*f)) for f in (.05,.2,.4,.6,.8,.98)]))
  fig,axes=plt.subplots(2,4,figsize=(12,6));fig.suptitle(name+' — reference slice: orange model / blue support')
  for ax,h in zip(axes.flat,chosen):
   seg=layers[h];ax.add_collection(LineCollection([(a,b) for a,b,c in seg],colors=[c for a,b,c in seg],linewidths=.5));ax.autoscale();ax.set_aspect('equal');ax.set_title(f'Z {h:.2f} mm');ax.tick_params(labelsize=6)
  for ax in list(axes.flat)[len(chosen):]:ax.set_visible(False)
  fig.tight_layout();fig.savefig(print_dir/(name+'-slice-review.png'),dpi=110);plt.close(fig)
  if threaded:row['thread_settings']={'outer_wall_mm_s':30,'inner_wall_mm_s':60,'part_cooling_percent_after_initial_layers':100,'slow_down_layer_time_s':12,'source':'Custom experimental settings on official A1 mini 0.12 mm Fine profile; not a qualified PLA+ recipe'}
  row['review_png']=name+'-slice-review.png';report['parts'].append(row);print(name,json.dumps(row),flush=True)
 (print_dir/'slicer-review.json').write_text(json.dumps(report,indent=2)+'\n')
 print('Reference gcode retained only at',work,flush=True)
if __name__=='__main__':
 import argparse
 parser=argparse.ArgumentParser();parser.add_argument('--print-dir',type=Path,default=ROOT/'print');parser.add_argument('--a1-mini-threads',action='store_true',help='Legacy compatibility flag; A1 mini and per-part thread settings are now automatic')
 args=parser.parse_args();main(args.print_dir,args.a1_mini_threads)
