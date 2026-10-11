"""Matched offline A1 mini reference slices; never communicates with a printer."""
import argparse,hashlib,json,math,re,subprocess
from pathlib import Path
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
from matplotlib.collections import LineCollection

ROOT=Path(__file__).resolve().parents[1]
APP=Path('/Applications/BambuStudio.app/Contents')
OUT=ROOT/'review/flat-back-slice'

def main(before,after):
    OUT.mkdir(parents=True,exist_ok=True)
    index={}
    for f in (APP/'Resources/profiles/BBL').rglob('*.json'):
        try:
            d=json.loads(f.read_text())
            if 'name' in d:index[d['name']]=d
        except (ValueError,UnicodeError):pass
    def resolve(name):
        d=index[name].copy();parent=d.pop('inherits',None)
        base=resolve(parent) if parent else {};base.update(d);return base
    profiles={'machine':resolve('Bambu Lab A1 mini 0.4 nozzle'),
              'process':resolve('0.20mm Standard @BBL A1M'),
              'filament':resolve('Generic PLA @BBL A1M')}
    profiles['process'].update(curr_bed_type='Textured PEI Plate',layer_height='0.2',initial_layer_print_height='0.2',
        wall_loops='3',sparse_infill_density='15%',sparse_infill_pattern='gyroid',
        enable_support='1',support_type='normal(auto)',support_style='snug',support_threshold_angle='30',
        support_on_build_plate_only='0',support_top_z_distance='0.2',support_bottom_z_distance='0.2',
        support_object_xy_distance='0.35',support_interface_top_layers='2',support_interface_bottom_layers='2',
        brim_type='no_brim',brim_width='0',raft_layers='0',enable_arc_fitting='0')
    for kind,p in profiles.items():(OUT/(kind+'.json')).write_text(json.dumps(p,indent=2)+'\n')
    diameter=float(profiles['filament']['filament_diameter'][0]);density=float(profiles['filament']['filament_density'][0])
    report={'revision':'flat-back-mount-v3','reference_only':True,'printer_contacted':False,
        'slicer':'Bambu Studio 02.07.01.62','printer':'A1 mini / 0.4 mm nozzle',
        'recipe':'Generic PLA, 0.2 mm, 3 walls, 15% gyroid, Normal Snug 30 degrees; 0.2 mm top/bottom support gaps, 0.35 mm XY, 2 interface layers, no brim or raft',
        'orientation':'Both brackets -90 degrees about local X, translated to bed; scale 100%; automatic reorientation disabled',
        'parts':{},'limits':['Reference estimates, not qualified PLA+ toolpaths or measured print results.',
          'Lower support quantity does not prove easy removal, good bearing/sliding finish or structural strength.',
          'Support/model/adhesion mass estimates sum positive moving extrusion by G-code role; total mass is the slicer estimate.',
          'Support generation varied slightly between repeated slices; percentages are approximate, not deterministic manufacturing guarantees.']}
    for name,file in [('before',Path(before)),('after',Path(after))]:
        dest=OUT/name;dest.mkdir(exist_ok=True)
        args=[str(APP/'MacOS/BambuStudio'),'--load-settings',str(OUT/'machine.json')+';'+str(OUT/'process.json'),
              '--load-filaments',str(OUT/'filament.json'),'--arrange','1','--orient','0','--slice','0',
              '--export-3mf',name+'.gcode.3mf','--outputdir',str(dest),str(file.resolve())]
        run=subprocess.run(args,capture_output=True,text=True,timeout=180)
        (dest/'cli.log').write_text(run.stdout+run.stderr)
        assert run.returncode==0 and (dest/'result.json').exists(),(name,run.returncode,'No successful slice result; inspect cli.log')
        result=json.loads((dest/'result.json').read_text())
        assert run.returncode==0 and result['return_code']==0,(name,run.returncode,result)
        plate=result['sliced_plates'][0]
        feature='';height=None;x=y=e=0.;absolute=False;lengths={};layers={}
        for line in (dest/'plate_1.gcode').read_text().splitlines():
            if line.startswith('; Z_HEIGHT:'):height=float(line.split(':')[1]);layers.setdefault(height,[])
            elif line.startswith('; FEATURE:'):feature=line.split(':',1)[1].strip()
            elif line.startswith('M82'):absolute=True
            elif line.startswith('M83'):absolute=False
            elif line.startswith('G92 E'):e=float(line.split(';')[0].split('E')[1].split()[0])
            elif line.startswith(('G0 ','G1 ')):
                v={k:float(n) for k,n in re.findall(r'([XYE])(-?(?:\d+(?:\.\d*)?|\.\d+))',line.split(';')[0])}
                nx,ny=v.get('X',x),v.get('Y',y);ev=v.get('E',e if absolute else 0);de=ev-e if absolute else ev
                if height is not None and de>0 and (nx!=x or ny!=y):
                    kind='support' if feature.startswith('Support') else 'adhesion' if feature in ('Brim','Skirt') else 'model'
                    lengths[kind]=lengths.get(kind,0)+de
                    layers[height].append(((x,y),(nx,ny),'#2587be' if kind=='support' else '#e87c30'))
                x,y=nx,ny
                if 'E' in v:e=ev if absolute else e+ev
        grams={k:round(v*math.pi*(diameter/2)**2*density/1000,4) for k,v in lengths.items()}
        heights=sorted(layers);chosen=sorted(set([heights[0]]+[min(heights,key=lambda z:abs(z-h)) for h in (1,2.4,4.6,6,10,14,18)]))
        fig,axes=plt.subplots(2,4,figsize=(12,6));fig.suptitle(name+' — orange model / blue supports (reference slice)')
        for ax,h in zip(axes.flat,chosen):
            seg=layers[h];ax.add_collection(LineCollection([(a,b) for a,b,c in seg],colors=[c for a,b,c in seg],linewidths=.5));ax.autoscale();ax.set_aspect('equal');ax.set_title(f'Z {h:.2f} mm')
        for ax in list(axes.flat)[len(chosen):]:ax.set_visible(False)
        fig.tight_layout();fig.savefig(dest/'layers.png',dpi=120);plt.close(fig)
        report['parts'][name]={'input_sha256':hashlib.sha256(file.read_bytes()).hexdigest(),
            'total_g':plate['filaments'][0]['total_used_g'],'deposited_grams_by_role':grams,
            'support_seconds':sum(t for k,t in plate['feature_type_times'].items() if k.startswith('Support')),
            'warning':plate.get('warning_message',''),'sliced_3mf':name+'/'+name+'.gcode.3mf','preview':name+'/layers.png'}
        print(name,report['parts'][name],flush=True)
    a,b=report['parts']['before'],report['parts']['after']
    report['support_mass_reduction_percent']=100*(1-b['deposited_grams_by_role'].get('support',0)/a['deposited_grams_by_role']['support'])
    report['total_mass_reduction_percent']=100*(1-b['total_g']/a['total_g'])
    (OUT/'comparison.json').write_text(json.dumps(report,indent=2)+'\n')
    print('Comparison complete',report['support_mass_reduction_percent'],report['total_mass_reduction_percent'],flush=True)

if __name__=='__main__':
    parser=argparse.ArgumentParser();parser.add_argument('before',type=Path);parser.add_argument('after',type=Path)
    args=parser.parse_args();main(args.before,args.after)
