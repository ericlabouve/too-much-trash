"""Two fixed-cuff attachment studies. Common cuff and other V3 parts unchanged."""
import json
import cadquery as cq
import build_concepts as b

HERE=b.HERE
def volume(s):return sum(x.Volume() for x in s.solids().vals())
def overlap(a,c):return round(volume(a.intersect(c)),7)
def placed(s):return b.place(s,-20,0,True)

def build():
    solids={}
    baseline=b.make('c','C · Common 21.6 mm cuffs',solid_output=solids)
    jaw=solids['Fixed jaw and clean L spine']
    cuff=solids['Fixed C cuff'].union(solids['Fixed adaptable seats'])
    neck=solids['Stock neck']
    baseline_overlap=overlap(jaw,cuff)
    # The earlier schematic root clips the cuff's lower outside curve. Keep
    # the common cuff unchanged; align both new upright roots to the backing.
    jaw=jaw.cut(b.box(-18,-13.1,-11,11,0,6.01))
    # Same 9.2 mm head envelope and 6.4 mm stem as the sliding retainer.
    # A tapered nose is only an insertion lead-in, not a simulated snap fit.
    head=(cq.Workplane('XY').polyline([(-5.42,-4.6),(-4.65,-4.6),(-3.9,-3.2),
                                      (-3.9,3.2),(-4.65,4.6),(-5.42,4.6)])
          .close().extrude(3.2,both=True))
    stud=b.soften(b.box(-7.4,-4.8,-3.2,3.2,-3.2,3.2),.25).union(head)
    integral=jaw.union(placed(stud))

    # Existing shared keeper rotated about its insertion axis to put the wide
    # head in Z, not toward the stock neck. No new keeper design is introduced.
    center=-9.7
    short=b.soften(b.box(-12.5,-4.8,-3.2,3.2,-3.2,3.2),.3)
    short=short.union(b.soften(b.box(-5.42,-3.9,-4.6,4.6,-3.2,3.2),.3))
    short=short.cut(b.box(center-1.7,center+1.7,-8,8,-1.7,1.7))
    keeper=(b.small_key('Y').rotate((0,0,0),(0,1,0),90).translate((center,0,0)))
    channel=b.box(-14,-6,-3.4,3.4,-3.4,3.4)
    channel=channel.union(b.box(center-1.7,center+1.7,-6.5,16,-1.7,1.7))
    # Head recess also continues to the side entrance for a straight service path.
    channel=channel.union(b.box(center-1.7,center+1.7,4.7,16,-3.7,3.7))
    removable=jaw.cut(placed(channel))
    short_world,keeper_world=placed(short),placed(keeper)
    options=[]
    for key,title,carrier,extra in [
        ('stud','1 · Integral T-stud',integral,[]),
        ('short','2 · Short T + sideways shared key',removable,[
            ('Short removable T',short_world,b.AMBER,'key',(-25,0,0)),
            ('Existing 12.2 mm sideways keeper',keeper_world,b.BLUE,'key',(0,-20,0))])]:
        parts=[p for p in baseline['parts'] if p['name']!='Fixed jaw and clean L spine']
        carrier_meta=b.export('fixed_'+key,'Fixed jaw '+title,carrier,b.ORANGE,'fixed')
        parts.append(carrier_meta)
        detail=[dict(p,explode=[-13,0,0]) for p in parts if p['name'].startswith('Fixed C') or p['name']=='Fixed adaptable seats']
        local=carrier.intersect(b.box(-18,-7.3,-11,11,0,24))
        detail.append(b.export('fixed_'+key,'Detail jaw '+title,local,b.ORANGE,'fixed'))
        detail.append(b.export('fixed_'+key,'Stock neck context',neck.intersect(b.box(-8,8,-10,10,0,24)),'#a2adb4','neck'))
        for name,s,color,group,ex in extra:
            item=b.export('fixed_'+key,name,s,color,group,ex)
            parts.append(item);detail.append(item)
        checks={'jaw_valid':carrier.val().isValid(),'jaw_solids':len(carrier.solids().vals()),
                'jaw_neck_overlap_mm3':overlap(carrier,neck),'jaw_cuff_overlap_mm3':overlap(carrier,cuff),
                'common_cuff_unchanged':True,'fixed_cuff_width_mm':21.6,
                'earlier_root_cuff_interference_mm3':baseline_overlap,
                'root_refinement':'Upright trimmed to the X=-13.1 backing face above Z0; cuff untouched, continuous L retained.'}
        for name,s,*_ in extra:
            checks[name+'_neck_overlap_mm3']=overlap(s,neck)
            checks[name+'_jaw_overlap_mm3']=overlap(s,carrier)
            checks[name+'_cuff_overlap_mm3']=overlap(s,cuff)
            checks[name+'_neck_distance_mm']=round(s.val().distance(neck.val()),3)
        for name,s in solids.items():
            if name.startswith('Current') or name.startswith('Volume button'):
                checks[name+'_new_jaw_overlap_mm3']=overlap(s,carrier)
                for ename,es,*_ in extra:checks[name+' / '+ename+'_overlap_mm3']=overlap(s,es)
        assert checks['jaw_valid'] and checks['jaw_solids']==1
        assert all(v<1e-5 for n,v in checks.items() if n.endswith('_overlap_mm3')),checks
        if key=='stud':
            checks['rigid_cuff_pullout_after_1mm_obstruction_mm3']=overlap(cuff.translate((-1,0,0)),carrier)
            checks['head_width_mm']=9.2;checks['cuff_opening_width_mm']=6.8
            checks['required_behavior']='TPU must deform over the head; rigid PETG insertion is not possible without deformation. No strain or pull-off force simulation.'
            assert checks['rigid_cuff_pullout_after_1mm_obstruction_mm3']>0
            notes=['T-stud is part of the rigid jaw: zero loose fixed-retainer parts.',
                   'Cuff flexes over the tapered head; same cuff opening and recess as both sliding cuffs.',
                   'No rear stem. TPU insertion effort, peeling, creep and pull-off retention remain untested. Do not force PETG over the stud.']
        else:
            checks['short_T_keeper_overlap_mm3']=overlap(short_world,keeper_world)
            checks['locked_T_pullout_after_1mm_obstruction_mm3']=overlap(short_world.union(keeper_world).translate((-1,0,0)),carrier)
            checks['short_T_total_length_mm']=8.6
            checks['nominal_tip_ligament_mm']=1.1
            checks['nominal_front_channel_wall_mm']=1.1
            # Sample both continuous straight axes at 0.5 mm intervals.
            checks['keeper_service_path_max_overlap_mm3']=max(overlap(placed(keeper.translate((0,i*.5,0))),carrier.union(neck).union(cuff).union(short_world)) for i in range(45))
            checks['T_service_without_keeper_max_overlap_mm3']=max(overlap(placed(short.translate((i*.5,0,0))),carrier.union(neck).union(cuff)) for i in range(45))
            print('Short-T path checks',checks,flush=True)
            assert checks['short_T_keeper_overlap_mm3']<1e-5
            assert checks['locked_T_pullout_after_1mm_obstruction_mm3']>0
            assert checks['keeper_service_path_max_overlap_mm3']<1e-5
            assert checks['T_service_without_keeper_max_overlap_mm3']<1e-5
            notes=['New 8.6 mm short T; the sideways keeper is the exact existing 12.2 mm axle key, turned so its head does not point into the neck.',
                   'T tip stops 0.5 mm before the modeled neck. Nominal tip ligament and channel front wall are only 1.1 mm: marginal until printed/load-tested.',
                   'Remove phone, slide blue keeper out sideways, then withdraw amber T toward phone. Keeper drift, finger access and print tolerances remain unresolved.']
        options.append(dict(id=key,title=title,parts=parts,detail_parts=detail,checks=checks,notes=notes))
    result=dict(revision='fixed-retention-pair-v1',options=options,
                common='Same three 21.6 mm cuffs and unchanged two sliding crosslocks. Neither fixed option selected. Review only; no print or production promotion.',
                limitations=['Static nominal geometry and sampled local paths, not strength/TPU validation.',
                             'Current bare-near actuator only; full travel, all phones, camera view, collar fasteners and twine remain unqualified.',
                             'Exploded views illustrate separation, not a deforming TPU insertion simulation.'])
    (HERE/'fixed-retention.json').write_text(json.dumps(result,indent=2)+'\n')
    print(json.dumps({o['id']:o['checks'] for o in options},indent=2),flush=True)

if __name__=='__main__':build()
