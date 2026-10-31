"""Material-separated current assembly slices, never printer control."""
import sys,json,shutil,hashlib
from pathlib import Path
import prepare_cuff_fit_plate as plate
import review_actuator_plate as review

mode=sys.argv.pop(1)
out=Path(sys.argv[sys.argv.index('--output-dir')+1]).resolve()
source=out.parent/(out.name+'-source');source.mkdir()
root=plate.ROOT
all_rigid=['carrier','shaft_cap','sliding_jaw','actuator_bracket','plunger','pulley','pulley_axle']
if mode=='rigid-compact':
    layout=json.loads((root/'review/compact-rigid/layout.json').read_text())
    parts={n:(r['center_xy_mm'],'Z',r['angle'],'Approved bed face preserved; nested XY arrangement.') for n,r in layout['parts'].items()}
elif mode=='rigid-fit':
    parts={n:((90,90),'Z',0,'Approved bed orientation; automatic XY arrangement only.') for n in all_rigid}
elif mode=='rigid-main':
    parts={'carrier':((90,35),'Z',0,'Flat collar underside down; approved ramped hook.'),
           'shaft_cap':((90,120),'Z',0,'Taller cap, flat exterior down.')}
elif mode=='rigid-extra':
    parts={'sliding_jaw':((35,90),'Z',0,'Flush rear beam down; tongue upright.'),
           'actuator_bracket':((110,115),'Z',0,'Current flat-back mount export.'),
           'plunger':((105,65),'Z',0,'Approved flat print orientation.'),
           'pulley':((90,35),'Z',0,'Axis vertical, flange down.'),
           'pulley_axle':((125,35),'Z',0,'Head down; cross-slot bridged.')}
elif mode=='tpu':
    parts={f'phone_cuff_{i}':((40+40*(i-1),120),'Z',0,'Exact successful cuff back-down orientation.') for i in range(1,4)}
    parts.update({f'collar_screw_{i}':((30+28*(i-1),80),'Z',0,'Common long screw, head down.') for i in range(1,6)})
    parts.update({f'thumb_nut_{i}':((30+28*(i-1),50),'Z',0,'Common nut, flat down.') for i in range(1,6)})
    parts.update(pulley_key=((55,25),'Z',0,'TPU T/V key, flat down.'),clip_string_guide=((100,25),'Z',0,'Clip axial end down; eye vertical.'))
else:raise ValueError(mode)
records={}
for n in parts:
    base=n.rsplit('_',1)[0] if n.rsplit('_',1)[-1].isdigit() else n
    path=root/'print'/f'{base}.stl'
    if base in ('carrier','shaft_cap'):path=root/'print/jobs/2026-10-26-ramped-fixed-hook-source'/f'{base}.stl'
    if base=='phone_cuff':path=root/'print/jobs/2026-10-24-three-cuffs-thread-tpu/cuff-1-bed.stl'
    if mode=='rigid-compact':path=root/layout['sources'][n]
    shutil.copy2(path,source/(n+'.stl'))
    records[n]={'design':base,'source':str(path.relative_to(root)),'sha256':hashlib.sha256(path.read_bytes()).hexdigest()}
(source/'fit-attachment-check.json').write_text(json.dumps({'revision':'material-set-ramped-fixed-v3','parts':records,'limits':['Accepted study geometry for cap/fixed jaw; remaining parts from current manufacturing exports. Physical assembly qualification pending.']},indent=2)+'\n')
plate.SOURCE=source;plate.PARTS=parts
real_cli=plate.common.cli
def cli(args,label):
    if mode=='rigid-fit':
        if label=='slice':raise SystemExit('Arrangement-only trial complete; inspect normalized plate count.')
        args=args.copy();args[args.index('--arrange')+1]='1'
        args.insert(0,'--allow-rotations')
    # Preserve per-part support choice while auditing all other shapes automatically.
    if label=='slice':
        import zipfile,xml.etree.ElementTree as ET
        f=out/'cuff-fit-input.3mf'
        with zipfile.ZipFile(f) as z:entries={n:z.read(n) for n in z.namelist()}
        tree=ET.fromstring(entries['Metadata/model_settings.config'])
        disabled={n for n in parts if n.startswith('phone_cuff_') or n=='pulley_axle'}
        for obj in tree.findall('object'):
            name=next(m.get('value') for m in obj.findall('metadata') if m.get('key')=='name')
            if name in disabled:ET.SubElement(obj,'metadata',{'key':'enable_support','value':'0'})
        entries['Metadata/model_settings.config']=ET.tostring(tree)
        with zipfile.ZipFile(f,'w',zipfile.ZIP_DEFLATED) as z:
            for n,data in entries.items():z.writestr(n,data)
        inputs=json.loads((out/'inputs.json').read_text())
        for row in inputs['object_settings']:
            if row['name'] in disabled:row['enable_support']='0'
        inputs['scope']='Material-separated complete-assembly plate: '+mode
        inputs['nested_layout']=mode=='rigid-compact'
        (out/'inputs.json').write_text(json.dumps(inputs,indent=2)+'\n')
    real_cli(args,label)
plate.common.cli=cli
if mode=='tpu':
    plate.PRIOR=root/'print/jobs/2026-10-24-three-cuffs-thread-tpu'
    saved=json.loads((plate.PRIOR/'process.json').read_text())
    speeds={k:saved[k] for k in saved if 'speed' in k or 'acceleration' in k}
    plate.main(process_overrides=speeds,material_status='ELEGOO TPU95A, successful cuff recipe; 230C nozzle /35C bed /2 mm3 per second. New key, guide and long screws remain unqualified.')
else:plate.main()
review.OUT=out
review.main(project_stem='cuff-fit',title={'rigid-compact':'Plate 1 · all seven PETG parts','rigid-main':'Plate 1A · PETG fixed jaw and cap','rigid-extra':'Plate 1B · remaining PETG parts','tpu':'Plate 2 · all TPU parts'}[mode],detail_parts=list(parts)[:3],notes=[
 'Full required quantities at 100% scale; one material per plate. No printer contacted.',
 'Cuffs use the physically successful support-disabled recipe; axle cross-slot is bridged. Automatic supports enabled for other parts.',
 'Support masses include scaffold and interface. Model mass excludes startup purge and adhesion. Physical fit, strength and 35-degree quality still require testing.'])
