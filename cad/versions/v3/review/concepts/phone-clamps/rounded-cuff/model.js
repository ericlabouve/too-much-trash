// Fit-development CAD viewer. No force simulation or active CAD promotion.
import * as T from 'three';
import {OrbitControls} from 'three/addons/controls/OrbitControls.js';
import {RoundedBoxGeometry} from 'three/addons/geometries/RoundedBoxGeometry.js';
import {STLLoader} from 'three/addons/loaders/STLLoader.js';
import {installViewCube} from '../../../../../../view_cube.js';
const sharedKeySource=await new STLLoader().loadAsync(new URL('./fit-key.stl',import.meta.url).href);
const axleSource=await new STLLoader().loadAsync(new URL('./actuator-axle-reference.stl',import.meta.url).href);
const sharedKeyCheck=await (await fetch(new URL('./shared-key-check.json',import.meta.url))).json();
const fitCheck=await (await fetch(new URL('./fit-attachment-check.json',import.meta.url))).json();
const fitGeometry={};
await Promise.all(['jaw','cuff-shell','cuff-seats'].map(async n=>fitGeometry[n]=await new STLLoader().loadAsync(new URL('./fit-'+n+'.stl',import.meta.url).href)));
const C={jaw:0xe88a30,tpu:0x008b99,rib:0x7cab36,keeper:0xd582a8,case:0xcbd3d7,screen:0x344b57,band:0x9867b7,ink:0x3e5860};
const mats=Object.fromEntries(Object.entries(C).map(([k,color])=>[k,new T.MeshStandardMaterial({color,roughness:.6})]));
const H=5.5, DEPTH=10, contacts=[[-1,-50],[-1,50],[1,0]], printed=[];
function mesh(g,geometry,material,p=[0,0,0]){const m=new T.Mesh(geometry,material);m.position.set(...p);g.add(m);return m;}
function box(g,s,p,mat=mats.jaw,r=.5){return mesh(g,new RoundedBoxGeometry(...s,4,Math.min(r,...s.map(v=>v*.22))),mat,p);}
function extrude(g,shape,depth,mat){const geo=new T.ExtrudeGeometry(shape,{depth,bevelEnabled:true,bevelSize:.1,bevelThickness:.1,bevelSegments:3,curveSegments:32});geo.rotateX(Math.PI/2);geo.translate(0,depth/2,0);return mesh(g,geo,mat);}
function roundedRect(x0,x1,y0,y1,r=.5){
 const s=new T.Shape();s.moveTo(x0+r,y0);s.lineTo(x1-r,y0);s.quadraticCurveTo(x1,y0,x1,y0+r);s.lineTo(x1,y1-r);s.quadraticCurveTo(x1,y1,x1-r,y1);s.lineTo(x0+r,y1);s.quadraticCurveTo(x0,y1,x0,y1-r);s.lineTo(x0,y0+r);s.quadraticCurveTo(x0,y0,x0+r,y0);return s;
}
function yzSolid(g,shape,x0,thickness,material){const geo=new T.ExtrudeGeometry(shape,{depth:thickness,bevelEnabled:false,curveSegments:32});geo.applyMatrix4(new T.Matrix4().set(0,0,1,0,1,0,0,0,0,1,0,0,0,0,0,1));return mesh(g,geo,material,[x0,0,0]);}
function clipPoints(points,value,above,axis='y'){const out=[];for(let i=0;i<points.length;i++){const a=points[i],b=points[(i+1)%points.length],ia=above?a[axis]>=value:a[axis]<=value,ib=above?b[axis]>=value:b[axis]<=value;if(ia)out.push(a);if(ia!==ib)out.push(a.clone().lerp(b,(value-a[axis])/(b[axis]-a[axis])));}return out;}
function profileStrip(g,points,y0,y1){const geo=new T.ExtrudeGeometry(new T.Shape(points),{depth:y1-y0,bevelEnabled:false});geo.rotateX(Math.PI/2);geo.translate(0,y1,0);return mesh(g,geo,mats.tpu);}
function innerX(z){z/=1.2;let lo=0,hi=1;for(let n=0;n<40;n++){const t=(lo+hi)/2,u=1-t,v=-3.5*u*u*u-3.9*u*u*t+3.9*u*t*t+3.5*t*t*t;if(v<z)lo=t;else hi=t;}const t=(lo+hi)/2;return 1.2*(-2.65-1.35*t*(1-t));}
function cProfile(){
 // x points inward from the case edge. One curved open shell, no closed tray.
 const s=new T.Shape();s.moveTo(1.7,H+1.55);
 s.bezierCurveTo(-.3,H+2.2,-4.8,H+1.7,-4.8,H-1.8);
 s.bezierCurveTo(-5.1,1.6,-5.1,-1.6,-4.8,-H+1.8);
 s.bezierCurveTo(-4.8,-H-1.7,-.3,-H-2.2,1.7,-H-1.55);
 s.quadraticCurveTo(2,-H-.65,1.7,-H-.1);
 s.bezierCurveTo(.3,-H-.05,-2.3,-H-.1,-2.65,-H+2);
 s.bezierCurveTo(-3.1,-1.3,-3.1,1.3,-2.65,H-2);
 s.bezierCurveTo(-2.3,H+.1,.3,H+.05,1.7,H+.1);
 s.quadraticCurveTo(2,H+.65,1.7,H+1.55);s.closePath();
 return s;
}
function cuff(g){
 mesh(g,fitGeometry['cuff-shell'].clone(),mats.tpu).name='Original C return';
 mesh(g,fitGeometry['cuff-seats'].clone(),mats.rib).name='Compliant angled seat';
 return g;
}
function backing(g){mesh(g,fitGeometry.jaw.clone(),mats.jaw).name='Jaw socket without friction ribs';}
function keeper(g){mesh(g,sharedKeySource.clone(),mats.jaw).name='Shared revised T-key';return g;}
function makeScene(id){
 const el=document.getElementById(id),renderer=new T.WebGLRenderer({antialias:true,preserveDrawingBuffer:true});renderer.localClippingEnabled=true;renderer.setClearColor(0xffffff);renderer.setPixelRatio(Math.min(devicePixelRatio,2));renderer.outputColorSpace=T.SRGBColorSpace;renderer.toneMapping=T.ACESFilmicToneMapping;el.appendChild(renderer.domElement);
 const scene=new T.Scene(),root=new T.Group();scene.add(root);scene.add(new T.HemisphereLight(0xffffff,0x7f8b95,2));for(const [p,i] of [[[80,-120,180],2.3],[[-100,40,60],1.1],[[20,70,-120],1.5]]){const l=new T.DirectionalLight(0xffffff,i);l.position.set(...p);scene.add(l);}
 const camera=new T.PerspectiveCamera(32,1,.1,1800);camera.up.set(0,1,0);const controls=new OrbitControls(camera,renderer.domElement);controls.enableDamping=false;
 const cube=installViewCube({canvas:renderer.domElement,camera,controls});
 let renderedState='';
 const state=()=>[...camera.position.toArray(),...camera.quaternion.toArray(),...camera.up.toArray(),...controls.target.toArray(),camera.zoom,cube.camera.isOrthographicCamera].join(',');
 const render=()=>{renderer.setSize(el.clientWidth,el.clientHeight,false);camera.aspect=el.clientWidth/el.clientHeight;camera.updateProjectionMatrix();cube.tick();renderer.render(scene,cube.camera);renderedState=state();};
 // The shared cube can change orientation/projection without an OrbitControls
 // event. Observe that state each frame; redraw only when it actually changes.
 const frame=()=>{if(state()!==renderedState)render();requestAnimationFrame(frame);};requestAnimationFrame(frame);
 controls.addEventListener('change',render);new ResizeObserver(render).observe(el);return {scene,root,camera,controls,renderer,render,cube};
}
function outline(g,points,color=0xc65d67){const geo=new T.BufferGeometry().setFromPoints(points.map(p=>new T.Vector3(...p)));const l=new T.Line(geo,new T.LineDashedMaterial({color,dashSize:2,gapSize:1}));l.computeLineDistances();g.add(l);return l;}
function label(g,text,p,size=2.6,color='#263c45'){
 const c=document.createElement('canvas'),x=c.getContext('2d');x.font='500 52px system-ui';c.width=Math.ceil(x.measureText(text).width)+32;c.height=80;x.font='500 52px system-ui';x.textAlign='center';x.textBaseline='middle';x.fillStyle='rgba(255,255,255,.95)';x.fillRect(0,0,c.width,80);x.fillStyle=color;x.fillText(text,c.width/2,40);const tex=new T.CanvasTexture(c);tex.colorSpace=T.SRGBColorSpace;const s=new T.Sprite(new T.SpriteMaterial({map:tex,depthTest:false,toneMapped:false}));s.position.set(...p);s.scale.set(size*c.width/80,size,1);g.add(s);return s;
}
function leader(g,p,q){return outline(g,[p,q],0x73888c);}
const main=makeScene('assembly'),detail=makeScene('detail'),phone=new T.Group(),keepouts=new T.Group(),hardware=new T.Group();main.root.add(phone,hardware);phone.add(keepouts);
box(phone,[76,154,11],[0,0,0],mats.case,1.2);box(phone,[70,146,.25],[0,0,H+.15],mats.screen,2);
const cameraMat=new T.MeshStandardMaterial({color:0x71878e});box(phone,[23,27,2],[-22,55,-H-1],cameraMat,2);
for(const [x,y] of [[-28,62],[-17,54],[-28,48]]){const m=mesh(phone,new T.CylinderGeometry(3,3,.65,32),mats.screen,[x,y,-H-2.3]);m.rotation.x=Math.PI/2;}
outline(keepouts,[[-35,-73,H+.5],[35,-73,H+.5],[35,73,H+.5],[-35,73,H+.5],[-35,-73,H+.5]]);
outline(keepouts,[[-35,36,-H-2.9],[-7,36,-H-2.9],[-7,74,-H-2.9],[-35,74,-H-2.9],[-35,36,-H-2.9]]);
// Same three-contact topology; modified local jaw pockets are schematic.
// Schematic rails connect below the new stem socket, leaving its outward
// key tip unobstructed. Active jaw manufacturing geometry is unchanged.
box(hardware,[5,108,6.5],[-44.6,0,-7.25]);box(hardware,[5,20,6.5],[44.6,0,-7.25]);
box(hardware,[90,7,2.8],[0,0,-H-5.5]);for(const y of [-5.1,5.1])box(hardware,[43,2.3,5.5],[24,y,-H-5.5]);
for(const [side,y] of contacts){const g=new T.Group();g.position.set(side*38,y,0);if(side===1)g.rotation.z=Math.PI;hardware.add(g);cuff(g);backing(g);keeper(g);}
hardware.traverse(o=>{if(o.isMesh)printed.push(o);});
for(const y of [-10,10]){const curve=new T.CatmullRomCurve3([new T.Vector3(-45.2,y,-H-4),new T.Vector3(-42,y,-H-8),new T.Vector3(42,y,-H-8),new T.Vector3(45.2,y,-H-4)]);mesh(hardware,new T.TubeGeometry(curve,60,.65,8,false),mats.band);}
let view='iso',mode='section';
function setMainView(v){view=v;main.cube.perspective();main.camera.up.set(0,1,0);main.camera.position.set(...(v==='front'?[0,0,330]:v==='back'?[0,0,-330]:[130,-170,205]));main.controls.target.set(0,0,0);main.controls.update();main.render();for(const b of document.querySelectorAll('[data-view]'))b.setAttribute('aria-pressed',String(b.dataset.view===v));document.getElementById('view-note').textContent=v==='back'?'Rear: no cuff crosses the camera-module boundary. This is not an optical field-of-view validation.':v==='front'?'Front: cyan returns overlap only the gray case rim. The dark usable display remains uncovered.':'Drag to orbit · scroll to zoom. Use the cube to snap views; drag its arrows to rotate smoothly.';}
function clear(g){while(g.children.length){const o=g.children[0];o.traverse(n=>{n.geometry?.dispose();if(n.userData.ownedMaterial)n.material.dispose();});g.remove(o);}}
function setDetail(v){
 mode=v;detail.cube.perspective();clear(detail.root);
 const isolated=v==='key'||v==='crosskey'||v==='socket';
 const insert=new T.Group(),jaw=new T.Group(),key=new T.Group();detail.root.add(insert,jaw,key);
 if(!isolated)cuff(insert);
 if(v!=='insert'&&v!=='socket')keeper(key);
 if((!isolated&&v!=='insert')||v==='socket')backing(jaw);
 if(v==='crosskey')mesh(detail.root,axleSource.clone(),mats.case).name='Unchanged production axle';
 if(v==='open')key.position.x=18;
 if(v==='exploded'){key.position.x=23;jaw.position.x=-13;}
 if(v==='pin'||v==='3d'||v==='section'){
  box(detail.root,[15,14,11],[7.5,0,0],mats.case,.5).name='Phone edge reference';
  box(detail.root,[12,13,.25],[9,0,H+.15],mats.screen,.1);
 }
 detail.camera.up.set(0,0,1);
 detail.camera.position.set(...(v==='socket'?[20,-20,18]:v==='retention'?[-45,-55,30]:v==='pin'?[-15,-80,26]:v==='locked'?[43,-58,30]:v==='section'?[3,-90,0]:v==='exploded'?[31,-100,56]:v==='open'?[35,-72,40]:v==='key'?[24,-48,22]:v==='crosskey'?[-36,-45,24]:[35,-55,31]));
 detail.controls.target.set(v==='socket'?-7.2:v==='exploded'?-2:v==='crosskey'?-9:v==='retention'?-8:-3,0,v==='crosskey'?6:0);
 if(v==='socket'){
  jaw.traverse(o=>{if(o.isMesh){o.material=o.material.clone();o.material.transparent=true;o.material.opacity=.22;o.material.depthWrite=false;o.userData.ownedMaterial=true;}});
  keeper(key);
  label(detail.root,'No friction ribs',[-7,-4,8],1.1);leader(detail.root,[-7,-3,7],[-7.2,-1.7,.9]);
  label(detail.root,'3.4 mm passage / 3 mm key',[-7,-4,-8],1.1);
 }else if(v==='pin'){
  detail.root.traverse(o=>{if(o.isMesh){o.material=o.material.clone();o.material.clippingPlanes=[new T.Plane(new T.Vector3(0,1,0),0)];o.material.side=T.DoubleSide;o.userData.ownedMaterial=true;}});
  label(detail.root,'One key through cuff + jaw',[-9,-7,15],1.8);leader(detail.root,[-9,-6,13],[-8,0,0]);
  label(detail.root,'C pocket stays open',[7,-7,-14],1.8);leader(detail.root,[6,-6,-12],[-1,0,0]);
 }else if(v==='retention'){
  label(detail.root,'No second pin',[-13,-5,14],1.8);leader(detail.root,[-13,-4,12],[-12,0,0]);
  label(detail.root,'Clearance test · no pull-out lock',[-12,-5,-15],1.7);
 }else if(v==='locked'){
  label(detail.root,'Recessed shared T-head',[-3,-3,14],1.7);leader(detail.root,[-3,-2,12],[-3.62,0,0]);
 }else if(v==='exploded'){
  label(detail.root,'Rigid jaw',[-22,-4,-11],1.7);label(detail.root,'Cuff: PETG trial / TPU later',[-3,-4,15],1.7);
  label(detail.root,'Shared T-key',[16,-4,-9],1.7);
  detail.root.add(new T.ArrowHelper(new T.Vector3(-1,0,0),new T.Vector3(16,-8,-12),11,C.jaw,2,1));
 }else if(v==='open'){
  label(detail.root,'Key withdraws toward phone',[5,-4,14],1.7);
  detail.root.add(new T.ArrowHelper(new T.Vector3(1,0,0),new T.Vector3(-8,-7,-10),12,C.jaw,2,1));
 }else if(v==='crosskey'){
  label(detail.root,'Same candidate in existing axle',[-9,-5,25],1.7);
  label(detail.root,'Thinner head · unchanged stem',[-9,-5,-8],1.7);
 }
 detail.controls.update();detail.render();
 const notes={
  locked:'Three pieces: rigid jaw, ONE cyan/green cuff (PETG trial, TPU later), and the shared rigid T-key. Its 7 × 3 mm head is recessed in the C back wall between the green seats. No pink TPU T and no transverse locking pin.',
  retention:'PETG clearance-fit test: friction ribs removed. The 3.4 mm passage gives 0.2 mm nominal clearance per side around the unchanged 3 mm key. No designed friction grip or positive latch; the key can slide out. This is not a phone-retention test.',
  socket:'X-ray socket view. No friction ribs: 3.4 mm square passage around the 3 mm key, with 0.2 mm nominal clearance per side. Printed fit remains untested; do not force a jammed key. Cuff and seats are enlarged 20%; the openings and key sizes are unchanged.',
  pin:'Cutaway: thin shared T-head seats in the cuff back wall; the 3 × 3 mm stem passes directly into the jaw. The enlarged C pocket remains open. The recessed head does not project toward the phone, but is rigid and not a soft pad.',
  open:'The single key withdraws toward the open C pocket. No friction ribs or pull-out latch remain in this PETG fit test; do not suspend a phone from it.',
  exploded:'Only THREE pieces: rigid jaw, cyan/green cuff (PETG trial, TPU later), and one revised key design shared with the actuator. The stem enters the cuff and jaw directly. No custom TPU T and no second cross-key.',
  key:'Shared candidate: 12.2 mm long, 7 mm head width, 3 × 3 mm stem. Head depth along insertion reduced from 3 to 1.2 mm; print-plane thickness stays 3 mm. This is the candidate for BOTH uses, not a separate cuff-only part.',
  crosskey:'The identical candidate shown in the unchanged actuator axle. CAD checks cover slot insertion, bracket clearance and axial axle obstruction. Thinner-head strength and keeper-band fit are untested. Approved production actuator geometry remains unchanged.',
  insert:'ONE cuff including both green seating ribs; PETG for the first assembly trial, ELEGOO TPU 95A for later grip tests. Width is now 12 mm along the phone edge, with a 1.7 mm flat-backed head shoulder. A recessed 7.4 × 3.4 mm head seat surrounds a 3.4 mm square stem passage in the central back wall.',
  '3d':'The C pocket and green seating ribs remain open around the illustrative phone edge. The shared rigid head is recessed in the back wall. No deformation, contact forces or pull-out retention are simulated.',
  section:'End-on view of the 20% enlarged C profile with a recessed shared head. Curved returns reach only the illustrative case rim. Secure key retention and actual phone fit remain unqualified.'
 };
 document.getElementById('detail-note').textContent=notes[v]||notes.locked;
}
function audit(){
 main.root.updateMatrixWorld(true);const screen=new T.Box3(new T.Vector3(-35,-73,H+.02),new T.Vector3(35,73,40));
 const camera=new T.Box3(new T.Vector3(-35,36,-40),new T.Vector3(-7,74,-H+.01));if(document.getElementById('reverse').checked){camera.min.set(7,-74,-40);camera.max.set(35,-36,-H+.01);}
 const hits={screen:[],camera:[]},margins=[];for(const o of printed){const b=new T.Box3().setFromObject(o);for(const [k,zone]of Object.entries({screen,camera}))if(b.intersectsBox(zone))hits[k].push(o.name||'rigid jaw');if(b.max.z>=H+.02)margins.push(Math.max(-35-b.max.x,b.min.x-35,-73-b.max.y,b.min.y-73));}
 return {method:'Conservative world-axis bounding-box intersections, printed components only',illustrative_case_mm:[76,154,11],screen_mm:[70,146],rim_mm:3,screen_margin_measured_mm:Math.min(...margins),camera_module_keepout_mm:[28,38],contacts_y_mm:[-50,50,0],end_for_end:document.getElementById('reverse').checked,hits,limits:['Not a lens field-of-view test','Not active 18/20 mm phone envelopes','No TPU deformation, grip force or peel strength simulation']};
}
function keyAudit(){
 const group=new T.Group();keeper(group);group.updateMatrixWorld(true);
 const clip=(poly,x,above)=>{const out=[];for(let i=0;i<poly.length;i++){const a=poly[i],b=poly[(i+1)%poly.length],ia=above?a.x>=x:a.x<=x,ib=above?b.x>=x:b.x<=x;if(ia)out.push(a);if(ia!==ib)out.push(a.clone().lerp(b,(x-a.x)/(b.x-a.x)));}return out;};
 let clearance=Infinity,violations=0;
 for(const child of group.children){
  const geo=child.geometry,attr=geo.getAttribute('position'),index=geo.index,point=i=>new T.Vector3().fromBufferAttribute(attr,index?index.getX(i):i).applyMatrix4(child.matrixWorld),count=index?index.count:attr.count;
  for(let sample=0;sample<=80;sample++)for(let i=0;i<count;i+=3){
   const tri=[point(i),point(i+1),point(i+2)].map(p=>p.add(new T.Vector3(sample*.25,0,0)));
   // Jaw bore, rear cuff stem throat, and recessed head seat respectively.
   for(const [lo,hi,w]of [[-10.8,-6.8,1.7],[-6.72,-5.02,1.7],[-5.02,-3.18,3.7]])for(const p of clip(clip(tri,lo,true),hi,false)){const c=Math.min(p.y+w,w-p.y,p.z+1.7,1.7-p.z);clearance=Math.min(clearance,c);if(c<-.00001)violations++;}
  }
 }
 const bounds=new T.Box3().setFromObject(group),size=bounds.getSize(new T.Vector3());
 const probe=new T.Group();cuff(probe);keeper(probe);probe.updateMatrixWorld(true);
 const ray=new T.Raycaster(),surfaces=probe.children.filter(o=>o.name!=='Compliant angled seat');let maxEncroachment=-Infinity,raySamples=0,seamGaps=0;
 // Ray-test the displayed central cavity against the scaled cubic wall.
 for(const y of [-4.8,-4,-2.5,0,2.5,4,4.8])for(let n=0;n<=100;n++){const z=-2.5+n*.05;raySamples++;ray.set(new T.Vector3(20,y,z),new T.Vector3(-1,0,0));const hit=ray.intersectObjects(surfaces,false)[0];if(!hit){if(Math.abs(y)<=1.7&&Math.abs(z)>=1.49&&Math.abs(z)<=1.71){seamGaps++;continue;}throw Error(`Missing C cavity surface at Y${y} Z${z}`);}maxEncroachment=Math.max(maxEncroachment,hit.point.x-innerX(z));}
 for(const g of [group,probe])g.traverse(o=>o.geometry?.dispose());
 return {method:'81 key positions through rib-free clear passage; 707 cavity rays against 1.2x C wall',source:'fit-key.stl, same shared candidate with fine watertight tessellation',material:'PETG trial; intended cuff ELEGOO TPU 95A',samples:81,violations,minimum_slot_clearance_mm:clearance,key_thickness_mm:size.z,key_length_mm:size.x,key_head_width_mm:size.y,head_axial_depth_mm:1.2,key_phone_gap_mm:-bounds.max.x,stem_width_mm:3,cuff_width_mm:12,cavity_ray_samples:raySamples,open_tolerance_seam_rays:seamGaps,max_cavity_encroachment_mm:Math.max(0,maxEncroachment),side_keeper:false,second_key:false,limits:['No jaw ribs or designed pull-out retention; clearance-fit PETG test','No TPU deformation or loaded strength validation','Approved actuator and active jaws unchanged']};
}
function retentionAudit(){return {...sharedKeyCheck,cuff_positive_pullout_lock:false,second_key:false};}
function fitAudit(){return fitCheck;}
document.querySelectorAll('[data-view]').forEach(b=>b.onclick=()=>setMainView(b.dataset.view));document.getElementById('detail-mode').onchange=e=>setDetail(e.target.value);
document.getElementById('reverse').onchange=e=>{phone.rotation.z=e.target.checked?Math.PI:0;main.render();window.cuffAudit=audit();};
document.getElementById('keepouts').onchange=e=>{keepouts.visible=e.target.checked;main.render();};document.getElementById('phone').onchange=e=>{phone.visible=e.target.checked;main.render();};
setMainView('iso');const initial=new URLSearchParams(location.search).get('detail')||'exploded';document.getElementById('detail-mode').value=initial;setDetail(initial);window.cuffReview={setMainView,setDetail,audit,keyAudit,retentionAudit,fitAudit,render:()=>{main.render();detail.render();}};window.cuffAudit=audit();window.reviewReady=true;
window.addEventListener('error',e=>{document.getElementById('error').textContent=e.message;});
