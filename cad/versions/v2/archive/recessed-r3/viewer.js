import * as THREE from 'three';
import {cycleStroke} from './stroke_animation.js';
import {STLLoader} from 'three/addons/loaders/STLLoader.js';
import {OrbitControls} from 'three/addons/controls/OrbitControls.js';

const $=s=>document.querySelector(s);
const canvas=$('#view'),status=$('#status');
const renderer=new THREE.WebGLRenderer({canvas,antialias:true});
renderer.setPixelRatio(Math.min(devicePixelRatio,2));renderer.setClearColor(0xf8f7f3);
const scene=new THREE.Scene();scene.add(new THREE.HemisphereLight(0xffffff,0x8d9698,2.6));
const light=new THREE.DirectionalLight(0xffffff,3);light.position.set(-150,250,180);scene.add(light);
const camera=new THREE.PerspectiveCamera(35,1,.1,4000),controls=new OrbitControls(camera,canvas);controls.enableDamping=true;
const root=new THREE.Group();root.rotation.x=-Math.PI/2;scene.add(root);
const assembly=new THREE.Group(),inventory=new THREE.Group();root.add(assembly,inventory);
const meshes=new Map(),bomMeshes=new Map();let manifest,mode='phone',selected=null,outline,flipped=false,selectionTargets=[];
let playing=false,elapsedMs=0,lastFrame=null,lastPoseTime=0,strokeFraction=0,stopFraction=.05;
let previewRenderer,previewScene,previewCamera,previewRoot;const previewMeshes=new Map();
const loader=new STLLoader(),raycaster=new THREE.Raycaster();let pointerStart;
const details={
 phone:['RECESSED RAILS','Bands close the clamp.','Two rear rubber bands pull the sliding jaw toward the fixed jaw. Both jaws have a recessed actuator rail, moved toward the handle. Camera-view clearance is still in progress. Width range 66–86 mm is a geometric envelope, not a qualified phone compatibility list.'],
 full:['ONE CONTINUOUS LINE','Keep the twine captive.','A closed eye at the actuator and three repeated shaft guides retain the twine. The lower end ties to an overtravel band around the moving trigger. Fixed guides are the first hypothesis; no pulleys or gears yet.'],
 actuator:['TWO ELASTIC FUNCTIONS','Return, then release.','One band returns the rocker. A separate band at the trigger absorbs continued squeeze after the printed stop engages. Hook positions and end knots allow preload adjustment; forces are not simulated. Move the bracket along either rail, adjust its depth, then turn the contact screw to set the button gap.'],
 bom:['EIGHT PRINTED DESIGNS','Thirteen pieces. No metal hardware.','Two jaws, reversible bracket, rocker, pivot, three screws, two nuts and three guides. One continuous twine length and nine rubber bands are the starting assembly.']
};
function setDetail(label,title,text){$('#detail-label').textContent=label;$('#detail-title').textContent=title;$('#detail-text').textContent=text;}
function material(rgb){return new THREE.MeshStandardMaterial({color:new THREE.Color(...rgb),roughness:.7});}
function allowed(name){
 if(name==='actuator_context')return mode==='actuator';
 if(name==='stock_neck_context')return mode==='phone';
 if(name==='twine_phone')return mode==='phone'||mode==='actuator';
 if(mode==='full')return true;
 if(mode==='actuator')return ['rocker','pivot_key','contact_screw','rail_screw_1','rail_screw_2','rail_nut_1','rail_nut_2','band_return','phone_volume_up'].includes(name);
 if(name==='guide_1'||name==='band_guide_1')return true;
 return !name.startsWith('stock_')&&!name.startsWith('guide_')&&!name.startsWith('band_guide_')&&!['twine','band_overtravel'].includes(name);
}
function clearSelection(){
 for(const m of [...meshes.values(),...bomMeshes.values()])m.material.emissive?.setHex(0);
 if(outline){scene.remove(outline);outline.geometry.dispose();outline.material.dispose();outline=null;}
 selected=null;selectionTargets=[];document.querySelectorAll('tr[data-id]').forEach(el=>el.classList.remove('selected'));
}
function visibleMeshes(){return mode==='bom'?[...bomMeshes.values()]:[...meshes.values()].filter(m=>m.visible);}
function frameObjects(objects,view=mode){
 root.updateWorldMatrix(true,true);const box=new THREE.Box3();for(const m of objects)box.expandByObject(m);
 if(box.isEmpty())return;
 const size=box.getSize(new THREE.Vector3()),center=box.getCenter(new THREE.Vector3());
 const direction=view==='bom'?new THREE.Vector3(0,1,.08):view==='actuator'?new THREE.Vector3(.65,flipped?-.7:.7,1):new THREE.Vector3(-.7,flipped?-.85:.85,1);
 const fov=Math.min(THREE.MathUtils.degToRad(camera.fov),2*Math.atan(Math.tan(THREE.MathUtils.degToRad(camera.fov/2))*camera.aspect));
 const distance=view==='bom'
  ?Math.max((size.x+100)/camera.aspect,size.z+95+size.y*.08)/(2*Math.tan(THREE.MathUtils.degToRad(camera.fov/2)))*1.08+size.y/2
  :Math.max(size.length()/2,14)/Math.sin(fov/2)*1.13;
 camera.up.set(0,view==='bom'?0:1,view==='bom'?-1:0);controls.target.copy(center);camera.position.copy(center).add(direction.normalize().multiplyScalar(distance));controls.update();
}
function label(text,x,y,z){
 const c=document.createElement('canvas');c.width=700;c.height=64;const ctx=c.getContext('2d');ctx.fillStyle='#243138';ctx.font='46px system-ui';ctx.textAlign='center';ctx.fillText(text,350,42);
 const sprite=new THREE.Sprite(new THREE.SpriteMaterial({map:new THREE.CanvasTexture(c),depthTest:false}));sprite.position.set(x,y,z);sprite.scale.set(190,20,1);inventory.add(sprite);
}
function focus(id,object){
 clearSelection();selected=id;const row=manifest.bom.find(r=>r.id===id);if(!row)return;
 let objects=object?[object]:mode==='bom'?[bomMeshes.get(id)].filter(Boolean):[...meshes.values()].filter(m=>m.userData.bomId===id&&m.visible);
 if(!objects.length){setMode('full');selected=id;objects=[...meshes.values()].filter(m=>m.userData.bomId===id);}
 selectionTargets=objects;
 for(const m of objects)m.material.emissive.setHex(0x554400);
 const box=new THREE.Box3();root.updateWorldMatrix(true,true);for(const m of objects)box.expandByObject(m);
 outline=new THREE.Box3Helper(box,0xd49225);outline.material.depthTest=false;scene.add(outline);
 frameObjects(objects);setDetail(`${row.material.toUpperCase()} · ×${row.quantity}`,row.name,row.note);
 document.querySelectorAll('tr[data-id]').forEach(el=>el.classList.toggle('selected',el.dataset.id===id));
}
function setMode(next){
 if(next==='bom')setPlaying(false);
 clearSelection();mode=next;inventory.visible=mode==='bom';assembly.visible=!inventory.visible;
 document.body.classList.toggle('bom',inventory.visible);$('#inventory').hidden=!inventory.visible;
 for(const b of document.querySelectorAll('[data-view]'))b.setAttribute('aria-pressed',String(b.dataset.view===mode));
 for(const [name,m] of meshes){
  m.visible=allowed(name)&&($('#phone').checked||!name.startsWith('phone_')&&name!=='camera_keepout');
  const transparent=(name==='carrier'&&$('#transparent').checked)||name==='actuator_context';
  m.material.transparent=transparent;m.material.opacity=transparent?.2:1;m.material.depthWrite=!transparent;
 }
 $('#stroke-panel').hidden=inventory.visible;$('#animate').disabled=inventory.visible;$('#release').disabled=inventory.visible;
 $('#flip').disabled=inventory.visible;$('#stroke').disabled=inventory.visible;$('#phone').disabled=inventory.visible;$('#transparent').disabled=inventory.visible;
 setDetail(...details[mode]);resize();
 // Crop actuator framing to the mechanism while retaining the integral carrier for context.
 const fit=mode==='actuator'?['rocker','pivot_key','band_return','actuator_context'].map(n=>meshes.get(n)):visibleMeshes();
 frameObjects(fit);pose(strokeFraction);status.textContent=mode==='bom'?'Click a row or model to inspect. Right-click a model for assembly views. Review meshes, not print files.':'Drag to orbit · scroll to zoom · click a component to inspect. Prescribed motion, not a force simulation.';
}
function tube(points,diameter){
 const path=new THREE.CurvePath();for(let i=1;i<points.length;i++)path.add(new THREE.LineCurve3(new THREE.Vector3(...points[i-1]),new THREE.Vector3(...points[i])));
 return new THREE.TubeGeometry(path,Math.max(64,points.length*8),diameter/2,8,false);
}
function bandPoints(a,b,width=4){
 const direction=b.clone().sub(a).normalize();let side=direction.clone().cross(new THREE.Vector3(1,0,0));if(side.length()<.01)side=direction.clone().cross(new THREE.Vector3(0,1,0));side.normalize();
 const center=a.clone().add(b).multiplyScalar(.5),radius=a.distanceTo(b)/2;
 return Array.from({length:49},(_,i)=>{const t=2*Math.PI*i/48;return center.clone().addScaledVector(direction,radius*Math.cos(t)).addScaledVector(side,width*Math.sin(t)).toArray();});
}
function replaceTube(name,points,diameter){const mesh=meshes.get(name);mesh.geometry.dispose();mesh.geometry=tube(points,diameter);}
function pose(fraction){
 const previous=strokeFraction;strokeFraction=Math.max(0,Math.min(1,fraction));fraction=strokeFraction;
 $('#stroke').value=String(fraction*100);$('#stroke-value').value=`${Math.round(fraction*100)}%`;
 const m=manifest.motion,axis=new THREE.Vector3(0,1,0),pivot=new THREE.Vector3(...m.pivot),tp=new THREE.Vector3(...m.trigger_pivot),restAttach=new THREE.Vector3(...m.trigger_attach);
 const angle=m.trigger_angle*fraction;
 const attach=restAttach.clone().sub(tp).applyAxisAngle(axis,angle).add(tp),last=new THREE.Vector3(...m.string_points.at(-2));
 const takeup=attach.distanceTo(last)-restAttach.distanceTo(last);
 const rockerAngle=m.angle*Math.min(1,Math.max(0,takeup)/m.twine_to_stop);
 // Transform around the CAD pivot without changing the source mesh.
 for(const name of ['rocker','contact_screw']){const rocker=meshes.get(name);rocker.rotation.y=rockerAngle;rocker.position.copy(pivot).sub(pivot.clone().applyAxisAngle(axis,rockerAngle));}
 const trigger=meshes.get('stock_black_trigger');trigger.rotation.y=angle;trigger.position.copy(tp).sub(tp.clone().applyAxisAngle(axis,angle));
 const eye=new THREE.Vector3(...m.string_eye).sub(pivot).applyAxisAngle(axis,rockerAngle).add(pivot);
 const first=new THREE.Vector3(...m.string_points[1]);
 const shortening=new THREE.Vector3(...m.string_eye).distanceTo(first)-eye.distanceTo(first);
 // Constant modeled twine length: shortening at the rocker adds to the tail.
 const tail=m.tail_length+shortening;
 const knot=last.clone().addScaledVector(attach.clone().sub(last).normalize(),tail);
 const points=[eye.toArray(),...m.string_points.slice(1,-1),knot.toArray()];
 replaceTube('twine',points,manifest.parameters.twine_diameter);
 replaceTube('twine_phone',points.slice(0,4),manifest.parameters.twine_diameter);
 replaceTube('band_overtravel',bandPoints(knot,attach,5),1.4);
 const returnEye=new THREE.Vector3(...m.return_moving).sub(pivot).applyAxisAngle(axis,rockerAngle).add(pivot);
 replaceTube('band_return',bandPoints(returnEye,new THREE.Vector3(...m.return_fixed),2),1.4);
 const extension=knot.distanceTo(attach)-m.series_span_rest;
 const p=manifest.parameters,dx=m.contact[0]-m.pivot[0],dz=m.contact[2]-m.pivot[2];
 const advance=m.side_sign*(dx*(1-Math.cos(rockerAngle))-dz*Math.sin(rockerAngle));
 const buttonTravel=Math.min(p.button_stroke,Math.max(0,advance-p.rest_gap));
 const button=meshes.get('phone_volume_up');button.position.x=-m.side_sign*buttonTravel;
 button.material.emissive.setHex(buttonTravel>1e-5?0x227744:0);
 const releasing=fraction<previous-1e-6;
 const phase=fraction<1e-5?'Released · button free':Math.abs(rockerAngle)>=Math.abs(m.angle)-1e-6
  ?(releasing?'Releasing handle · button still held':'Button held at stop · trigger band takes up extra travel')
  :releasing?'Return band releases the rocker':buttonTravel>1e-5?'Rocker presses volume up':'Twine pulls the rocker toward the button';
 if($('#stroke-phase').textContent!==phase)$('#stroke-phase').textContent=phase;
 canvas.dataset.buttonTravel=String(buttonTravel);canvas.dataset.stroke=String(fraction);
 $('#motion-info').textContent=`Illustrated band extension: ${Math.max(0,extension).toFixed(1)} mm. Rocker: ${(rockerAngle*180/Math.PI).toFixed(1)}°. The 20–40 mm field stroke and band force still need verification.`;
 // Exposed read-only diagnostics for regression checks, not a force calculation.
 canvas.dataset.twineLength=String(points.slice(1).reduce((sum,p,i)=>sum+new THREE.Vector3(...p).distanceTo(new THREE.Vector3(...points[i])),0));
 canvas.dataset.bandExtension=String(extension);canvas.dataset.rockerAngle=String(rockerAngle);
 if(outline){root.updateWorldMatrix(true,true);outline.box.makeEmpty();for(const mesh of selectionTargets)outline.box.expandByObject(mesh);}
}
function setPlaying(value){
 playing=value;$('#animate').textContent=value?'Ⅱ Pause animation':'▶ Animate squeeze';$('#animate').setAttribute('aria-pressed',String(value));
 lastFrame=null;lastPoseTime=0;
}
function findStopFraction(){
 const m=manifest.motion,pivot=new THREE.Vector3(...m.trigger_pivot),attach=new THREE.Vector3(...m.trigger_attach),last=new THREE.Vector3(...m.string_points.at(-2));
 const rest=attach.distanceTo(last),axis=new THREE.Vector3(0,1,0);let lo=0,hi=1;
 for(let i=0;i<40;i++){const mid=(lo+hi)/2;const point=attach.clone().sub(pivot).applyAxisAngle(axis,m.trigger_angle*mid).add(pivot);if(point.distanceTo(last)-rest<m.twine_to_stop)lo=mid;else hi=mid;}
 return (lo+hi)/2;
}
function setupPreview(){
 previewRenderer=new THREE.WebGLRenderer({canvas:$('#actuator-preview'),antialias:true});previewRenderer.setPixelRatio(Math.min(devicePixelRatio,2));previewRenderer.setClearColor(0xf8f7f3);
 previewScene=new THREE.Scene();previewScene.add(new THREE.HemisphereLight(0xffffff,0x8d9698,2.6));
 const light=new THREE.DirectionalLight(0xffffff,3);light.position.set(-30,60,100);previewScene.add(light);
 previewRoot=new THREE.Group();previewRoot.rotation.copy(root.rotation);previewScene.add(previewRoot);
 for(const name of ['actuator_context','rocker','contact_screw','pivot_key','twine_phone','band_return','phone_volume_up']){
  const original=meshes.get(name);const clone=new THREE.Mesh(original.geometry,original.material.clone());previewRoot.add(clone);previewMeshes.set(name,clone);
 }
 const ghost=new THREE.LineSegments(new THREE.EdgesGeometry(meshes.get('rocker').geometry),new THREE.LineBasicMaterial({color:0x77868b,transparent:true,opacity:.6,depthTest:false}));ghost.renderOrder=2;previewRoot.add(ghost);
 previewCamera=new THREE.PerspectiveCamera(35,1,.1,500);
 const target=new THREE.Vector3(...manifest.motion.pivot).applyAxisAngle(new THREE.Vector3(1,0,0),-Math.PI/2);target.y-=10;
 previewCamera.position.copy(target).add(new THREE.Vector3(5,3,82));previewCamera.lookAt(target);
}
function renderPreview(){
 if(!previewRenderer||mode==='bom')return;
 const c=$('#actuator-preview');
 if(previewRenderer.domElement.width!==Math.round(c.clientWidth*previewRenderer.getPixelRatio())||previewRenderer.domElement.height!==Math.round(c.clientHeight*previewRenderer.getPixelRatio())){
  previewRenderer.setSize(c.clientWidth,c.clientHeight,false);previewCamera.aspect=c.clientWidth/c.clientHeight;previewCamera.updateProjectionMatrix();
 }
 for(const [name,clone] of previewMeshes){
  const source=meshes.get(name);clone.geometry=source.geometry;clone.position.copy(source.position);clone.quaternion.copy(source.quaternion);
  if(name==='actuator_context'){clone.material.transparent=true;clone.material.opacity=.15;clone.material.depthWrite=false;}
  if(name==='phone_volume_up')clone.material.emissive.copy(source.material.emissive);
 }
 previewRenderer.render(previewScene,previewCamera);
}
function pick(e){const r=canvas.getBoundingClientRect();raycaster.setFromCamera(new THREE.Vector2((e.clientX-r.left)/r.width*2-1,-(e.clientY-r.top)/r.height*2+1),camera);return raycaster.intersectObjects(visibleMeshes(),false).find(h=>h.object.userData.bomId)?.object;}
function menu(id,e){
 const el=$('#context');el.replaceChildren();
 for(const [view,title] of [['phone','Phone assembly'],['full','Full tool'],['actuator','Actuator']]){
  const b=document.createElement('button');b.textContent=`View in ${title}`;b.role='menuitem';
  b.onclick=()=>{el.hidden=true;setMode(view);focus(id);};el.append(b);
 }
 el.hidden=false;el.style.left=`${Math.max(8,Math.min(e.clientX,innerWidth-el.offsetWidth-8))}px`;el.style.top=`${Math.max(8,Math.min(e.clientY,innerHeight-el.offsetHeight-8))}px`;
}
try{
 const params=new URLSearchParams(location.search);const sample=params.get('sample')||'wallet',side=params.get('side')||'near';const base=sample==='wallet'&&side==='near'?'review/':`review/${sample}-${side}/`;
 $('#sample').value=sample;$('#side').value=side;
 for(const id of ['sample','side'])$('#'+id).onchange=()=>{location.search=new URLSearchParams({sample:$('#sample').value,side:$('#side').value});};
 const response=await fetch(base+'manifest.json');if(!response.ok)throw new Error(`Manifest HTTP ${response.status}`);manifest=await response.json();
 await Promise.all(manifest.assembly.map(async entry=>{
  const geometry=await loader.loadAsync(base+entry.file);geometry.computeVertexNormals();
  const mesh=new THREE.Mesh(geometry,material(entry.color));mesh.name=entry.name;mesh.userData.bomId=entry.bom_id;meshes.set(entry.name,mesh);assembly.add(mesh);
 }));
 $('#pieces').textContent=manifest.printed_pieces;
 for(const [i,row] of manifest.bom.entries()){
  const tr=document.createElement('tr');tr.dataset.id=row.id;tr.tabIndex=0;
  for(const value of [row.name,row.quantity,row.material,row.note]){const td=document.createElement('td');td.textContent=value;tr.append(td);}
  tr.onclick=()=>{focus(row.id);canvas.scrollIntoView({block:'center',behavior:'smooth'});};tr.onkeydown=e=>{if(e.key==='Enter'||e.key===' '){e.preventDefault();tr.click();}};
  tr.oncontextmenu=e=>{e.preventDefault();menu(row.id,e);};$('#bom-rows').append(tr);
  let geometry;
  const part=manifest.parts.find(p=>p.name===row.id);
  if(part)geometry=await loader.loadAsync(base+part.file);
  else if(row.id==='twine')geometry=tube([[0,0,0],[20,20,0],[40,0,0],[60,20,0],[80,0,0]],2);
  else geometry=tube(bandPoints(new THREE.Vector3(0,0,0),new THREE.Vector3(0,50,0),12),1.4);
  geometry.computeVertexNormals();geometry.computeBoundingBox();const center=geometry.boundingBox.getCenter(new THREE.Vector3()),extent=geometry.boundingBox.getSize(new THREE.Vector3());geometry.translate(-center.x,-center.y,-center.z);geometry.scale(...Array(3).fill(105/Math.max(extent.x,extent.y,extent.z)));
  const rgb=row.id==='twine'?[.62,.42,.19]:row.id==='rubber_bands'?[.57,.29,.68]:[.96,.36,.08];
  const mesh=new THREE.Mesh(geometry,material(rgb));mesh.position.set((i%3)*155,-Math.floor(i/3)*170,0);mesh.userData.bomId=row.id;inventory.add(mesh);bomMeshes.set(row.id,mesh);
  const titles={carrier:'Fixed jaw',sliding_jaw:'Sliding jaw',actuator_bracket:'Actuator bracket',rocker:'Rocker',pivot_key:'Printed pivot',thumb_screw:'Thumb screw',thumb_nut:'Printed nut',string_guide:'Captive guide',twine:'Continuous twine',rubber_bands:'Rubber bands'};
  label(`${titles[row.id]} ×${row.quantity}`,mesh.position.x,mesh.position.y-65,0);
 }
 document.querySelectorAll('[data-view]').forEach(b=>b.onclick=()=>setMode(b.dataset.view));
 $('#flip').onclick=()=>{flipped=!flipped;frameObjects(visibleMeshes());};
 $('#reset').onclick=()=>setMode(mode);$('#phone').onchange=()=>setMode(mode);$('#transparent').onchange=()=>setMode(mode);$('#stroke').oninput=e=>{setPlaying(false);elapsedMs=0;pose(Number(e.target.value)/100);};
 $('#animate').onclick=()=>{if(!playing&&mode==='phone')setMode('full');setPlaying(!playing);};
 $('#release').onclick=()=>{setPlaying(false);elapsedMs=0;pose(0);};
 document.addEventListener('visibilitychange',()=>{if(document.hidden)setPlaying(false);});
 canvas.addEventListener('pointerdown',e=>{pointerStart=[e.clientX,e.clientY];});
 canvas.addEventListener('click',e=>{if(!pointerStart||Math.hypot(e.clientX-pointerStart[0],e.clientY-pointerStart[1])>5)return;const m=pick(e);if(m)focus(m.userData.bomId,m);});
 canvas.addEventListener('contextmenu',e=>{e.preventDefault();const m=pick(e);if(m)menu(m.userData.bomId,e);});
 document.addEventListener('pointerdown',e=>{if(!$('#context').contains(e.target))$('#context').hidden=true;});document.addEventListener('keydown',e=>{if(e.key==='Escape')$('#context').hidden=true;});
 stopFraction=findStopFraction();setupPreview();pose(0);setMode('phone');canvas.dataset.ready='true';
}catch(error){status.textContent=`Load failed: ${error.message}`;console.error(error);}
function resize(){renderer.setSize(canvas.clientWidth,canvas.clientHeight,false);camera.aspect=canvas.clientWidth/canvas.clientHeight;camera.updateProjectionMatrix();}
window.addEventListener('resize',resize);resize();
function frame(now){
 requestAnimationFrame(frame);
 if(playing&&manifest){
  if(lastFrame!==null)elapsedMs+=Math.min(100,now-lastFrame);
  lastFrame=now;
  if(now-lastPoseTime>=1000/30){pose(cycleStroke(elapsedMs,stopFraction));lastPoseTime=now;}
 }
 controls.update();renderer.render(scene,camera);renderPreview();
}requestAnimationFrame(frame);
