"""Review-only centered wide cuffs: three retention architectures, not print files."""
from pathlib import Path
import sys, json
import cadquery as cq
HERE=Path(__file__).resolve().parent
SOURCE=HERE.parents[3]/'source'
sys.path.insert(0,str(SOURCE))
from shared_key_design import box,key_blank

OUT=HERE/'assets'
ORANGE='#efaa50'; CYAN='#13a6b3'; GREEN='#96bc41'; BLUE='#4389d6'; AMBER='#dc792b'
EDGE=-23.; LEFT=EDGE-76; CZ=11.28

def soften(s,r=.35):
    try:return s.edges().fillet(r)
    except Exception:return s

def c_section(width):
    p=(cq.Workplane('XZ').moveTo(1.7,7.05)
      .bezier([(-.3,7.7),(-5.6,7.2),(-5.6,3.7)],includeCurrent=True)
      .lineTo(-5.6,-3.7)
      .bezier([(-5.6,-7.2),(-.3,-7.7),(1.7,-7.05)],includeCurrent=True)
      .bezier([(2,-6.15),(1.7,-5.6)],includeCurrent=True)
      .bezier([(.3,-5.55),(-2.3,-5.6),(-2.65,-3.5)],includeCurrent=True)
      .bezier([(-3.1,-1.3),(-3.1,1.3),(-2.65,3.5)],includeCurrent=True)
      .bezier([(-2.3,5.6),(.3,5.55),(1.7,5.6)],includeCurrent=True)
      .bezier([(2,6.15),(1.7,7.05)],includeCurrent=True).close())
    shell=cq.Workplane(obj=p.extrude(width/2/1.2,both=True).val().scale(1.2))
    r=(cq.Workplane('XZ').moveTo(-3,2.7)
      .bezier([(-1.7,3),(-.7,4.05)],includeCurrent=True)
      .lineTo(.25,5).bezier([(.45,5.2),(.2,5.42)],includeCurrent=True)
      .bezier([(-.4,5.8),(-2.3,5.3),(-3,4.2)],includeCurrent=True)
      .close().extrude((width-.48)/2/1.2,both=True))
    seats=cq.Workplane(obj=r.union(r.mirror('XY')).val().scale(1.2))
    return shell,seats

def place(s,x,y,fixed=False):
    if fixed:s=s.rotate((0,0,0),(0,0,1),180)
    return s.translate((x,y,CZ))

def small_key(axis='Y'):
    s=key_blank().translate((-13.1,-8,-.3))
    return s.rotate((0,0,0),(0,0,1),90) if axis=='Y' else s.rotate((0,0,0),(0,1,0),-90)

def large_t(y=0,tip=-14.,axis='Y',width=8,headwidth=14):
    stem=soften(box(tip,-4.8,y-width/2,y+width/2,-3.2,3.2),.3)
    head=soften(box(-5.42,-3.9,y-headwidth/2,y+headwidth/2,-3.2,3.2),.3)
    t=stem.union(head)
    if axis=='Y':hole=box(-12.8,-9.4,y-width,y+width,-1.7,1.7)
    else:hole=box(-13.1,-9.7,y-1.7,y+1.7,-6,6)
    return t.cut(hole)

def retention(which,width,fixed):
    shell,seats=c_section(width)
    parts=[]
    # All sockets present a single backing plane, without old stepped ledges.
    backing=box(-9.2,-6.9,-width/2,width/2,-5.8,5.8)
    if which=='c' and fixed:
        # Same cuff as the sliding positions; the fixed jaw's retainer is TBD.
        shell=shell.cut(box(-20,3,-3.4,3.4,-3.4,3.4))
        shell=shell.cut(box(-5.42,3,-4.8,4.8,-3.4,3.4))
    if which=='a':
        shell=shell.cut(box(-15,3,-4.2,4.2,-3.4,3.4)).cut(box(-5.42,3,-7.2,7.2,-3.4,3.4))
        backing=backing.cut(box(-15,-6,-4.2,4.2,-3.4,3.4))
        # Crossbar bears on the back of the plate at its two projecting ends.
        # The broad key head gets an access recess instead of colliding with it.
        backing=backing.cut(box(-14,-6.8,4.8,6.4,-3.8,3.8))
        parts=[('Broad pierced T',large_t(),AMBER,'key',[32,0,0]),
               ('Existing axle key',small_key().translate((-11.1,0,0)),BLUE,'key',[0,15,0])]
    elif which=='b':
        # Continuous trapezoid tongue on the cuff's external back. Slides along Y.
        rail=(cq.Workplane('XZ').polyline([(-6.6,-2.3),(-9.8,-3.6),(-9.8,3.6),(-6.6,2.3)])
              .close().extrude(width/2-1,both=True))
        shell=shell.union(rail)
        groove=(cq.Workplane('XZ').polyline([(-6.3,-2.6),(-10.1,-4),(-10.1,4),(-6.3,2.6)])
                .close().extrude(width+2,both=True))
        backing=box(-12.2,-6.9,-width/2-2,width/2+4,-5.8,5.8).cut(groove)
        # Closed -Y end, cross-key +Y stop physically crossing the tongue end.
        backing=backing.union(box(-12.2,-6.9,-width/2-2,-width/2,-5.8,5.8))
        stop_y=width/2+.8
        bearing=box(-12.2,-6.9,width/2+.1,stop_y+2,-5.8,5.8)
        bearing=bearing.cut(box(-10.6,-7.2,stop_y-1.7,stop_y+1.7,-8,8))
        backing=backing.union(bearing)
        backing=backing.cut(box(-10.6,-7.2,stop_y-1.7,stop_y+1.7,-8,8))
        backing=backing.cut(box(-10.6,-7.2,stop_y-3.7,stop_y+3.7,4.8,8))
        # Exact key runs through Z; stem crosses the mouth in front of the tongue.
        parts=[('Existing axle end-stop key',small_key('Z').translate((-8.9,stop_y,0)),BLUE,'key',[0,0,15])]
    else:
        # Current C deliberately leaves fixed-cuff retention unresolved.
        stations=() if fixed else (0,)
        for yy in stations:
            shell=shell.cut(box(-20,3,yy-3.4,yy+3.4,-3.4,3.4))
            shell=shell.cut(box(-5.42,3,yy-4.8,yy+4.8,-3.4,3.4))
            backing=backing.cut(box(-20,-6,yy-3.4,yy+3.4,-3.4,3.4))
            # Deep side pockets clear the stock neck because Y is outside ±9.5.
            for zz in (-4.2,4.2):
                ear=box(-14,-8.8,yy-4.6,yy+4.6,zz-.6,zz+.6)
                ear=ear.cut(box(-13.1,-9.7,yy-1.7,yy+1.7,-9,9))
                backing=backing.union(ear)
            t=large_t(yy,tip=-15.5,axis='Z',width=6.4,headwidth=9.2)
            parts.extend([(f'Pierced T {yy:+g}',t,AMBER,'key',[32,0,0]),
              (f'Existing axle key {yy:+g}',small_key('Z').translate((-11.4,yy,0)),BLUE,'key',[0,0,15])])
    return shell,seats,backing,parts

def export(concept,name,shape,color,group,explode=(0,0,0)):
    signed_name=name.lower().replace('+','plus_').replace('-','minus_')
    slug=''.join(c if c.isalnum() else '_' for c in signed_name).strip('_')
    file=f'assets/{concept}_{slug}.stl'
    assert shape.val().isValid(),name
    cq.exporters.export(shape,str(HERE/file),tolerance=.04,angularTolerance=.18)
    return dict(name=name,file=file,color=color,group=group,explode=list(explode),
                solids=len(shape.solids().vals()),volume_mm3=round(sum(v.Volume() for v in shape.solids().vals()),3))

def make(which,title,solid_output=None):
    parts=[]; detail=[]; solids={}
    edge=-20. if which=='c' else EDGE
    left=edge-76
    fixed_width=21.6 if which=='c' else 40
    sliding_width=21.6 if which=='c' else 18
    def add(name,s,color,group,explode=(0,0,0),local=False):
        d=export(which,name,s,color,group,explode);parts.append(d);solids[name]=s
        if local:detail.append(d)
    # Schematic split collar: real 14 × 19 stock envelope, clearance included.
    neck=box(-7,7,-9.5,9.5,-72,45)
    cavity=box(-7.35,7.35,-9.85,9.85,-74,48)
    fixed_collar=box(-12,-.7,-14,14,-55,8).cut(cavity)
    # The open carrier flank at contact height is intentional in A.
    # A single rectangular L connects the neck-side post to the phone rear spine.
    root=box(-16.1,-10.8 if which=='c' else -11.5,-fixed_width/2,fixed_width/2,-4.7,6.0)
    spine=box(-106,-11.5,-9,9,-4.7,0)
    receiver=box(-87,-24,-9,9,-4.7,1.5).cut(box(-89,-23,-6.3,6.3,-2,2))
    fixed=fixed_collar.union(root).union(spine).union(receiver)
    cap=box(.7,12,-14,14,-55,16).cut(cavity)
    rail=box(7.4,12,-60,60,16,36)
    for y0,y1 in ((-54,-18.5),(18.5,54)):
        cut=box(6,14,y0,y1,21.6,30.4)
        for y in (y0,y1):
            cut=cut.union(cq.Workplane('YZ').center(y,26).circle(4.4).extrude(14,both=True))
        rail=rail.cut(cut)
    cap=cap.union(rail)
    sliding=box(left-11,left-6.9,-60,60,0,7)
    sliding=sliding.union(box(left-9,left+47,-5.8,5.8,-1.5,1.1))
    for x,y,isfixed,label,width in ((edge,0,True,'Fixed',fixed_width),(left,-50,False,'Sliding lower',sliding_width),(left,50,False,'Sliding upper',sliding_width)):
        shell,seats,backing,keys=retention(which,width,isfixed)
        backing=place(backing,x,y,isfixed)
        if isfixed:
            # Simple straight foot meets backing at one clean right angle.
            backing=backing.union(box(edge+6.9,edge+9.2,-width/2,width/2,0,CZ-5.7))
            fixed=fixed.union(backing)
        else:
            backing=backing.union(box(left-9.2,left-6.9,y-width/2,y+width/2,0,CZ-5.7))
            sliding=sliding.union(backing)
        if which=='b':
            through=place(box(-10.6,-7.2,width/2+.8-1.7,width/2+.8+1.7,-12,8),x,y,isfixed)
            if isfixed:fixed=fixed.cut(through)
            else:sliding=sliding.cut(through)
        if which=='c':
            for station in (() if isfixed else (0,)):
                through=place(box(-13.1,-9.7,station-1.7,station+1.7,-12,4.8),x,y,isfixed)
                if isfixed:fixed=fixed.cut(through)
                else:sliding=sliding.cut(through)
        cuff_explode=(0,-width-8 if isfixed else width+8,0) if which=='b' else (-12 if isfixed else 12,0,0)
        add(label+' C cuff',place(shell,x,y,isfixed),CYAN,'cuff',cuff_explode,isfixed)
        add(label+' adaptable seats',place(seats,x,y,isfixed),GREEN,'cuff',cuff_explode,isfixed)
        for name,s,color,group,ex in keys:
            if isfixed:ex=(-ex[0],-ex[1],ex[2])
            add(label+' '+name,place(s,x,y,isfixed),color,group,ex,isfixed)
    # Recess root locally instead of placing hidden solid through retention.
    if which=='a':
        fixed=fixed.cut(box(-15,-8,-5,5,CZ-3.4,CZ+3.4))
    fixed=fixed.cut(box(-107,-23,-6.3,6.3,-2,1.7))
    add('Fixed jaw and clean L spine',fixed,ORANGE,'fixed',(0,0,-15))
    add('Sliding jaw and interlocking tongue',sliding,ORANGE,'sliding',(-18,0,0))
    add('Removable shaft cap and 120 mm rail',cap,'#d79748','cap',(18,0,0))
    add('Stock neck',neck,'#a2adb4','neck')
    phone=soften(box(left,edge,-76,76,10 if which=='c' else CZ-4,18 if which=='c' else CZ+4),2.4)
    add('Phone envelope 76 × 152 × 8 mm',phone,'#35404a','phone',(0,0,25))
    # A local section of the real carrier makes lock geometry readable in detail.
    local=fixed.intersect(box(-18,-7.5,-25,25,0,24))
    detail.append(export(which,'Detail fixed receiver',local,ORANGE,'fixed',(0,0,-13)))
    detail.append(export(which,'Detail neck context',neck.intersect(box(-8,8,-10,10,0,24)),'#a2adb4','neck'))
    checks={'fixed_sliding_overlap_mm3':round(fixed.intersect(sliding).val().Volume(),6),
            'cap_neck_overlap_mm3':round(cap.intersect(neck).val().Volume(),6),
            'fixed_neck_overlap_mm3':round(fixed.intersect(neck).val().Volume(),6)}
    sliding_detail=[p for p in parts if p['name'].startswith('Sliding upper')]
    sliding_detail.append(export(which,'Detail sliding receiver',sliding.intersect(box(left-20,left,-62,62,0,24)).intersect(box(-120,0,39,61,0,24)),ORANGE,'sliding',(-18,0,0)))
    if which=='c':
        from model import Parameters,placed,stock,plunger_cassette
        p=Parameters(phone_thickness=8,button_from_screen=4)
        actuator=plunger_cassette()
        for name,shape in actuator.items():
            add('Current '+name,placed(shape,p),ORANGE,'actuator')
        button=stock(p)['phone_volume_up']
        add('Volume button · bare near example',button,'#dc4545','button')
        fixed_cuff=solids['Fixed C cuff'].union(solids['Fixed adaptable seats'])
        checks['fixed_cuff_button_overlap_mm3']=round(fixed_cuff.intersect(button).val().Volume(),6)
        checks['fixed_cuff_button_distance_mm']=round(fixed_cuff.val().distance(button.val()),3)
        checks['fixed_cuff_attachment']='UNRESOLVED — no retainer modeled'
        checks['actuator_scope']='Unmodified current bare-near cassette, phone edge X=-20; no all-phone clearance claim'
        for name,shape in actuator.items():
            shape=placed(shape,p)
            checks[name+'_fixed_cuff_overlap_mm3']=round(shape.intersect(fixed_cuff).val().Volume(),6)
            checks[name+'_fixed_jaw_overlap_mm3']=round(shape.intersect(fixed).val().Volume(),6)
        checks['fixed_cuff_phone_overlap_mm3']=round(fixed_cuff.intersect(phone).val().Volume(),6)
    for n,s in solids.items():
        if not n.startswith('Current') and ('key' in n.lower() or 'pierced' in n.lower() or 'broad' in n.lower()):
            checks[n+'_neck_overlap_mm3']=round(s.intersect(neck).val().Volume(),6)
            checks[n+'_assembled_jaw_overlap_mm3']=round(s.intersect(fixed if n.startswith('Fixed') else sliding).val().Volume(),6)
    notes={
      'a':['One broad T through the cuff, positively blocked by the existing transverse axle key.',
           'Requires the shallow open receiver shown; 2 mm nominal key-tip-to-stock clearance.',
           '1.2 mm T tip ligament and cross-key drift retention require print/load testing.'],
      'b':['Slide the cuff along the phone edge onto a broad external dovetail.',
           'One closed end plus the existing axle key blocks endwise escape; no new large T.',
           'TPU dovetail wear/peel and axle-key drift require testing.'],
      'c':['Fixed cuff limited to the current 21.6 mm green-face footprint; centered, not offset.',
           'All three cuffs are identical 21.6 mm parts including the T socket. Two sliding cross-locks retained.',
           'Fixed cuff attachment remains unresolved: plain backing shown, no hidden fastener or glue implied.',
           'Current bare-near actuator/button included at original phone datum. TPU compression and other phones remain unvalidated.']}[which]
    assert len({p['file'] for p in parts})==len(parts),f'Duplicate part filenames: {which}'
    if solid_output is not None:solid_output.update(solids)
    return dict(id=which,title=title,parts=parts,detail_parts=detail,sliding_detail_parts=sliding_detail,notes=notes,
      dimensions=dict(fixed_cuff_width_mm=fixed_width,sliding_cuff_width_mm=sliding_width,sliding_contact_spacing_mm=100,
                      rail_length_mm=120,rail_screw_z_mm=26,rail_z_range_mm=[16,36],fixed_cuff_y_mm=0,phone_edge_standoff_change_mm=0 if which=='c' else 3,
                      phone_proxy_mm=[76,152,8],existing_key_length_mm=12.2),checks=checks)

if __name__=='__main__':
    OUT.mkdir(parents=True,exist_ok=True)
    concepts=[]
    for id,title in [('a','A · Earlier wide T study'),('b','B · Earlier wide track study'),('c','C · Narrow fixed cuff / cross-locked sliding cuffs')]:
        print('Building',title,flush=True);concepts.append(make(id,title))
    report=dict(revision='common-cuff-21p6-v3',units='mm',concepts=concepts,
        limitations=['Concept review only: no production geometry or print files changed.',
          'Current C restores original X=-20 phone edge; A/B retain their earlier 3 mm standoff.',
          'C uses three identical 21.6 mm cuffs. A/B retain earlier 40/18 mm widths for comparison. All new interfaces unprinted.',
          'Green and cyan are regions of one TPU part, not separate materials.',
          'Current C includes original bare-near actuator and button for context, not all-phone clearance validation.',
          'Rail length, slot centers and Z26 mount datum retained; 4.6 mm rail section and collar are schematic.',
          'Collar/rail fasteners, rubber bands and detailed jaw locking clearances are schematic or omitted.',
          'No guarantee of screen/camera clearance, universal fit, strength, supports or loaded retention.'])
    (HERE/'manifest.json').write_text(json.dumps(report,indent=2)+'\n')
    checks={}
    for id in ('a','b','c'):
        for width,fixed in ((21.6 if id=='c' else 40,True),(21.6 if id=='c' else 18,False)):
            shell,seats,backing,keys=retention(id,width,fixed)
            joined=shell.union(seats)
            vals={'cuff_valid':joined.val().isValid(),'cuff_solid_count':len(joined.solids().vals())}
            for name,s,*rest in keys:
                vals[name+'_receiver_overlap_mm3']=round(s.intersect(backing).val().Volume(),6)
                vals[name+'_cuff_overlap_mm3']=round(s.intersect(joined).val().Volume(),6)
            for i,(name,s,*rest) in enumerate(keys):
                for n2,s2,*unused in keys[i+1:]:
                    vals[name+' / '+n2+'_overlap_mm3']=round(s.intersect(s2).val().Volume(),6)
            if id=='b':
                vals['end_escape_with_key_after_1mm_overlap_mm3']=round(shell.translate((0,1,0)).intersect(keys[0][1]).val().Volume(),6)
                vals['closed_end_escape_after_2mm_overlap_mm3']=round(shell.translate((0,-2,0)).intersect(backing).val().Volume(),6)
            elif keys:
                moving=keys[0][1]
                for key in keys[1:]:moving=moving.union(key[1])
                vals['locked_T_pullout_after_1mm_overlap_mm3']=round(moving.translate((1,0,0)).intersect(backing).val().Volume(),6)
            checks[id+('_fixed' if fixed else '_sliding')]=vals
    fixed_shape,fixed_seats,*_=retention('c',21.6,True)
    sliding_shape,sliding_seats,*_=retention('c',21.6,False)
    a=fixed_shape.union(fixed_seats);b=sliding_shape.union(sliding_seats)
    difference=a.cut(b).val().Volume()+b.cut(a).val().Volume()
    assert abs(difference)<1e-6, 'Cuffs must be the exact same part, not only the same width'
    cq.exporters.export(a,str(OUT/'c_common_cuff.stl'),tolerance=.04,angularTolerance=.18)
    cq.exporters.export(a,str(OUT/'c_common_cuff.step'))
    checks['c_common_cuff']={'width_mm':21.6,'quantity':3,'symmetric_difference_mm3':round(difference,9),'valid':a.val().isValid(),'solid_count':len(a.solids().vals()),'scope':'Review geometry, not bed-oriented or sliced'}
    (HERE/'checks.json').write_text(json.dumps(checks,indent=2)+'\n')
    print('Wrote',HERE/'manifest.json',flush=True)
