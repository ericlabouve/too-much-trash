import {installViewCube} from '../../view_cube.js';
import {assemblySteps} from './assembly_steps.js';
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
const viewCube=installViewCube({canvas,camera,controls});
let marking=false,featureOverlay=null,featureHit=null,stepIndex=-1,painting=false,paintLast=null;const featureOverlays=[];let shapeStart=null,shapePreview=null;let paintTime=0;const steps=assemblySteps();
const featureLabel=document.createElement('div');featureLabel.className='feature-label';featureLabel.hidden=true;$('#stage').append(featureLabel);
const root=new THREE.Group();root.rotation.x=-Math.PI/2;scene.add(root);
const assembly=new THREE.Group(),inventory=new THREE.Group();root.add(assembly,inventory);
const meshes=new Map(),bomMeshes=new Map();let manifest,mode='phone',selected=null,outline,flipped=false,selectionTargets=[];
let playing=false,elapsedMs=0,lastFrame=null,lastPoseTime=0,strokeFraction=0,stopFraction=.05;
let previewRenderer,previewScene,previewCamera,previewRoot,previewControls,previewCube;const previewMeshes=new Map();
const assetLoad=Date.now();
const freshAsset=path=>{const url=new URL(path,location.href);url.searchParams.set('load',assetLoad);return url.href;};
const loader=new STLLoader(),raycaster=new THREE.Raycaster();let pointerStart;
const details={
 phone:['COMPACT SHAFT-SIDE RAILS','Two positions. One actuator.','The paired rail is integral with the removable shaft cap, with a broad central web. Both clamp halves install sideways. Centered bands close the jaws and the twine runs directly from one integrated actuator guide to a selectable dual-eye guide and two centered shaft guides. For originally far-side buttons, turn the phone 180° in its screen plane and move the same actuator to the other end of the rail. The outer jaw has no long rail. The 120 mm rail fits within the A1 mini build envelope; the large example phone slides 21 mm along the jaws. Four collar fasteners form pairs 52 mm apart. Camera framing and loaded retention remain unvalidated.'],
 full:['ONE CONTINUOUS LINE','Keep the twine captive.','Supported D-shaped guides have 8 mm holes with 11 mm flared entrances. The line passes through the inset actuator guide, the selected eye of the dual guide, then the two original centered guides. The lower end ties to an overtravel band around the moving trigger. Fixed guides are the first hypothesis; no pulleys or gears yet.'],
 actuator:['STRING ATTACHMENT','Tie to the moving rocker.','The string loops through the 8 mm rocker eye and around its front edge, then ties back to itself. The loop grips the printed eye directly. Tie it before mounting the actuator. The visible loop is schematic; actual knot security is untested. The two small bracket tabs are functional press and return travel stops. One band returns the rocker. A separate band at the trigger absorbs continued squeeze after the printed stop engages. Band selection and end knots allow preload adjustment; forces are not simulated. Move the bracket along either rail, seat its two round mounting holes, check the integral broad shoe against the target button. Threefold free travel is not a validated button stroke.'],
 bom:['TEN PRINTED DESIGNS','Twenty-one pieces. No metal hardware.','Two jaws, rigid shaft cap, windowed bracket, rocker, pivot, six screws, six nuts and three guides. One continuous twine length and seven rubber bands are the starting assembly. Loaded retention remains unvalidated.']
};
function setDetail(label,title,text){$('#detail-label').textContent=label;$('#detail-title').textContent=title;$('#detail-text').textContent=text;}
function material(rgb){return new THREE.MeshStandardMaterial({color:new THREE.Color(...rgb),roughness:.7});}
function allowed(name){
 if(name==='actuator_context')return mode==='actuator';
 if(name==='stock_neck_context')return mode==='phone';
 if(name==='twine_phone')return mode==='phone'||mode==='actuator';
 if(mode==='full')return true;
 if(mode==='actuator')return ['twine_attachment','rocker','pivot_key','rail_screw_1','rail_screw_2','rail_nut_1','rail_nut_2','band_return','phone_volume_up'].includes(name);
 if(name==='guide_1'||name==='band_guide_1')return true;
 return !name.startsWith('stock_')&&!name.startsWith('guide_')&&!name.startsWith('band_guide_')&&!['twine','band_overtravel'].includes(name);
}
function clearSelection(){
 clearFeature();
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
 if(stepIndex>=0)exitSteps(false);viewCube.perspective();
 $('#assembly-toggle').hidden=next!=='phone';
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
 for(const name of ['rocker','twine_attachment']){const rocker=meshes.get(name);rocker.rotation.y=rockerAngle;rocker.position.copy(pivot).sub(pivot.clone().applyAxisAngle(axis,rockerAngle));}
 const trigger=meshes.get('stock_black_trigger');trigger.rotation.y=angle;trigger.position.copy(tp).sub(tp.clone().applyAxisAngle(axis,angle));
 const eye=new THREE.Vector3(...m.string_eye).sub(pivot).applyAxisAngle(axis,rockerAngle).add(pivot);
 const first=new THREE.Vector3(...m.string_points[1]);
 const shortening=new THREE.Vector3(...m.string_eye).distanceTo(first)-eye.distanceTo(first);
 // Constant modeled twine length: shortening at the rocker adds to the tail.
 const tail=m.tail_length+shortening;
 const knot=last.clone().addScaledVector(attach.clone().sub(last).normalize(),tail);
 const points=[eye.toArray(),...m.string_points.slice(1,-1),knot.toArray()];
 replaceTube('twine',points,manifest.parameters.twine_diameter);
 replaceTube('twine_phone',points.slice(0,manifest.motion.phone_point_count||4),manifest.parameters.twine_diameter);
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
  ?(releasing?'Releasing handle · button still held':'Free-travel stop · verify button overtravel physically')
  :releasing?'Return band releases the rocker':buttonTravel>1e-5?'Rocker presses volume up':'Twine pulls the rocker toward the button';
 if($('#stroke-phase').textContent!==phase)$('#stroke-phase').textContent=phase;
 canvas.dataset.buttonTravel=String(buttonTravel);canvas.dataset.stroke=String(fraction);
 $('#motion-info').textContent=`Illustrated band extension: ${Math.max(0,extension).toFixed(1)} mm. Rocker: ${(rockerAngle*180/Math.PI).toFixed(1)}°. Free travel only; shoe overtravel and button force need physical verification.`;
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
 for(const name of ['actuator_context','twine_attachment','rocker','pivot_key','twine_phone','band_return','phone_volume_up']){
  const original=meshes.get(name);const clone=new THREE.Mesh(original.geometry,original.material.clone());previewRoot.add(clone);previewMeshes.set(name,clone);
 }
 const ghost=new THREE.LineSegments(new THREE.EdgesGeometry(meshes.get('rocker').geometry),new THREE.LineBasicMaterial({color:0x77868b,transparent:true,opacity:.6,depthTest:false}));ghost.renderOrder=2;previewRoot.add(ghost);
 previewCamera=new THREE.PerspectiveCamera(35,1,.1,500);
 const target=new THREE.Vector3(...manifest.motion.pivot).applyAxisAngle(new THREE.Vector3(1,0,0),-Math.PI/2);target.y-=10;
 previewCamera.position.copy(target).add(new THREE.Vector3(5,3,82));previewCamera.lookAt(target);
 previewControls=new OrbitControls(previewCamera,$('#actuator-preview'));previewControls.target.copy(target);previewControls.enableDamping=true;previewControls.update();previewCube=installViewCube({canvas:$('#actuator-preview'),camera:previewCamera,controls:previewControls});
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
 previewControls.update();previewCube.tick();previewRenderer.render(previewScene,previewCube.camera);
}
function pick(e){const r=canvas.getBoundingClientRect();raycaster.setFromCamera(new THREE.Vector2((e.clientX-r.left)/r.width*2-1,-(e.clientY-r.top)/r.height*2+1),viewCube.camera);return raycaster.intersectObjects(visibleMeshes(),false).find(h=>h.object.userData.bomId);}

function clearFeature(){for(const overlay of featureOverlays){overlay.removeFromParent();overlay.geometry.dispose();overlay.material.dispose();}featureOverlays.length=0;featureOverlay=null;featureHit=null;featureLabel.hidden=true;delete canvas.dataset.feature;delete canvas.dataset.paintCount;}
function highlightFeature(hit,append=false){
 if(!append)clearSelection();setPlaying(false);featureHit=hit;
 const mesh=hit.object,point=mesh.worldToLocal(hit.point.clone()),radiusMm=Number($('#feature-radius').value),radius=radiusMm*(mesh.userData.displayScale||1);
 const g=mesh.geometry,p=g.attributes.position,idx=g.index,verts=[],triangle=new THREE.Triangle(),nearest=new THREE.Vector3();
 // Select actual surface triangles within the brush radius, not the entire STL.
 for(let i=0;i<(idx?idx.count:p.count);i+=3){const ids=[0,1,2].map(j=>idx?idx.getX(i+j):i+j);triangle.set(...ids.map(j=>new THREE.Vector3().fromBufferAttribute(p,j)));triangle.closestPointToPoint(point,nearest);if(nearest.distanceTo(point)<=radius)for(const j of ids)verts.push(p.getX(j),p.getY(j),p.getZ(j));}
 const geometry=new THREE.BufferGeometry();geometry.setAttribute('position',new THREE.Float32BufferAttribute(verts,3));geometry.computeVertexNormals();
 featureOverlay=new THREE.Mesh(geometry,new THREE.MeshStandardMaterial({roughness:.7,color:$('#feature-color').value,side:THREE.DoubleSide,transparent:true,opacity:.85,polygonOffset:true,polygonOffsetFactor:-2,polygonOffsetUnits:-2}));featureOverlay.material.onBeforeCompile=shader=>{shader.uniforms.featurePoint={value:point};shader.uniforms.featureRadius={value:radius};shader.vertexShader='varying vec3 featurePosition;\n'+shader.vertexShader.replace('#include <begin_vertex>','#include <begin_vertex>\nfeaturePosition=position;');shader.fragmentShader='varying vec3 featurePosition; uniform vec3 featurePoint; uniform float featureRadius;\n'+shader.fragmentShader.replace('#include <clipping_planes_fragment>','#include <clipping_planes_fragment>\nif(distance(featurePosition,featurePoint)>featureRadius) discard;');};featureOverlay.renderOrder=3;mesh.add(featureOverlay);featureOverlays.push(featureOverlay);canvas.dataset.paintCount=String(featureOverlays.length);
 const row=manifest.bom.find(r=>r.id===mesh.userData.bomId),name=row?.name||mesh.name;
 featureLabel.textContent=`${name} · ${mesh.name||mesh.userData.bomId} · point (${point.toArray().map(n=>n.toFixed(1)).join(', ')}) · radius ${radiusMm} mm`;featureLabel.hidden=false;featureLabel.style.top=`${canvas.offsetTop+canvas.clientHeight-60}px`;canvas.dataset.feature=mesh.name||mesh.userData.bomId;
 status.textContent='Drag to paint more surface. Alt + drag or use the cube to orbit. Clear highlight starts over.';
}
// Shapes are projected onto the selected part in its local coordinates, so they
// remain attached when the assembly is orbited. Drag sets the bounds/direction.
function drawFeatureShape(e){
 if(!shapeStart)return;
 if(shapePreview){shapePreview.removeFromParent();shapePreview.geometry.dispose();shapePreview.material.dispose();featureOverlays.splice(featureOverlays.indexOf(shapePreview),1);}
 const {hit,x,y,matrix}=shapeStart,mesh=hit.object,r=canvas.getBoundingClientRect();
 const end=new THREE.Vector2((e.clientX-r.left)/r.width*2-1,1-(e.clientY-r.top)/r.height*2);
 const start=new THREE.Vector2(x,y),kind=$('#feature-shape').value;
 const geometry=mesh.geometry.clone();geometry.computeVertexNormals();
 const mat=new THREE.MeshStandardMaterial({color:$('#feature-color').value,roughness:.7,side:THREE.DoubleSide,polygonOffset:true,polygonOffsetFactor:-2,polygonOffsetUnits:-2});
 mat.onBeforeCompile=shader=>{
  Object.assign(shader.uniforms,{markMatrix:{value:matrix},markStart:{value:start},markEnd:{value:end},markKind:{value:{rectangle:0,ellipse:1,arrow:2}[kind]},markAspect:{value:r.width/r.height}});
  shader.vertexShader='uniform mat4 markMatrix; varying vec4 markClip;\n'+shader.vertexShader.replace('#include <begin_vertex>','#include <begin_vertex>\nmarkClip=markMatrix*vec4(position,1.0);');
  shader.fragmentShader='varying vec4 markClip; uniform vec2 markStart,markEnd; uniform float markKind,markAspect;\n'+shader.fragmentShader.replace('#include <clipping_planes_fragment>',`#include <clipping_planes_fragment>
   vec2 q=markClip.xy/markClip.w;
   vec2 mid=(markStart+markEnd)*.5, halfSize=max(abs(markEnd-markStart)*.5,vec2(.003));
   vec2 uv=(q-mid)/halfSize;
   bool inside=all(lessThanEqual(abs(uv),vec2(1.0)));
   if(markKind>.5 && markKind<1.5) inside=dot(uv,uv)<=1.0;
   if(markKind>1.5){
    vec2 scale=vec2(markAspect,1.0),d=(markEnd-markStart)*scale,v=(q-markStart)*scale;
    float len=max(length(d),.001),along=dot(v,d/len),across=abs(dot(v,vec2(-d.y,d.x)/len));
    float head=min(.08,len*.4),width=.012;
    inside=along>=0.0 && along<=len && across<=((along<len-head)?width:max(width,(len-along)*.65));
   }
   if(!inside) discard;
  `);
 };
 shapePreview=new THREE.Mesh(geometry,mat);shapePreview.renderOrder=3;mesh.add(shapePreview);featureOverlays.push(shapePreview);
 canvas.dataset.feature=mesh.name||mesh.userData.bomId;canvas.dataset.paintCount=String(featureOverlays.length);
 featureLabel.hidden=false;featureLabel.textContent=`${kind} · ${mesh.name||mesh.userData.bomId}`;
}
function exitSteps(reset=true){
 stepIndex=-1;$('#assembly-walkthrough').hidden=true;$('#assembly-toggle').setAttribute('aria-pressed','false');delete canvas.dataset.assemblyStep;
 for(const mesh of meshes.values()){mesh.position.set(0,0,0);mesh.rotation.set(0,0,0);mesh.material.emissive.setHex(0);mesh.material.color.copy(mesh.userData.baseColor);}
 if(reset)setMode('phone');
}
function showStep(index){
 if(stepIndex<0){setMode('phone');setPlaying(false);pose(0);}
 clearSelection();stepIndex=Math.max(0,Math.min(steps.length-1,index));const step=steps[stepIndex];
 $('#assembly-walkthrough').hidden=false;$('#assembly-toggle').setAttribute('aria-pressed','true');$('#assembly-step').value=String(stepIndex);
 $('#step-title').textContent=`${stepIndex+1} / ${steps.length} · ${step.title}`;$('#step-text').textContent=step.text;
 $('#step-back').disabled=stepIndex===0;$('#step-next').disabled=stepIndex===steps.length-1;
 for(const [name,mesh] of meshes){mesh.visible=step.visible.includes(name);if(name==='stock_neck_context'&&step.visible.includes('stock_neck'))mesh.visible=false;mesh.material.color.copy(mesh.userData.baseColor);if(step.added.includes(name))mesh.material.color.setHex(0x008b99);mesh.material.emissive.setHex(0);}
 // Separate bench assemblies are shown without any stock neck or other assembly.
 $('#stroke-panel').hidden=true;for(const id of ['animate','release','stroke','phone','transparent'])$('#'+id).disabled=true;
 frameObjects(visibleMeshes());status.textContent=step.bench?'Work surface · assemble these parts off the grabber.':'On the grabber · teal identifies the current step.';
 canvas.dataset.assemblyStep=String(stepIndex);
}

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
 const response=await fetch(base+'manifest.json',{cache:'no-store'});if(!response.ok)throw new Error(`Manifest HTTP ${response.status}`);manifest=await response.json();
 $('#orientation').textContent=(side==='far'?'Phone rotated 180° · camera at opposite end · framing unresolved':'Phone in standard orientation')+(manifest.phone_center_y_mm?` · phone shifted ${Math.abs(manifest.phone_center_y_mm)} mm along jaws`:'');
 await Promise.all(manifest.assembly.map(async entry=>{
  const geometry=await loader.loadAsync(freshAsset(base+entry.file));geometry.computeVertexNormals();
  const mesh=new THREE.Mesh(geometry,material(entry.color));mesh.name=entry.name;mesh.userData.bomId=entry.bom_id;mesh.userData.baseColor=mesh.material.color.clone();meshes.set(entry.name,mesh);assembly.add(mesh);
 }));
 $('#pieces').textContent=manifest.printed_pieces;
 for(const [i,row] of manifest.bom.entries()){
  const tr=document.createElement('tr');tr.dataset.id=row.id;tr.tabIndex=0;
  for(const value of [row.name,row.quantity,row.material,row.note]){const td=document.createElement('td');td.textContent=value;tr.append(td);}
  tr.onclick=()=>{focus(row.id);canvas.scrollIntoView({block:'center',behavior:'smooth'});};tr.onkeydown=e=>{if(e.key==='Enter'||e.key===' '){e.preventDefault();tr.click();}};
  tr.oncontextmenu=e=>{e.preventDefault();menu(row.id,e);};$('#bom-rows').append(tr);
  let geometry;
  const part=manifest.parts.find(p=>p.name===row.id);
  if(part)geometry=await loader.loadAsync(freshAsset(base+part.file));
  else if(row.id==='twine')geometry=tube([[0,0,0],[20,20,0],[40,0,0],[60,20,0],[80,0,0]],2);
  else geometry=tube(bandPoints(new THREE.Vector3(0,0,0),new THREE.Vector3(0,50,0),12),1.4);
  geometry.computeVertexNormals();geometry.computeBoundingBox();const center=geometry.boundingBox.getCenter(new THREE.Vector3()),extent=geometry.boundingBox.getSize(new THREE.Vector3());geometry.translate(-center.x,-center.y,-center.z);geometry.scale(...Array(3).fill(105/Math.max(extent.x,extent.y,extent.z)));
  const rgb=row.id==='twine'?[.62,.42,.19]:row.id==='rubber_bands'?[.57,.29,.68]:[.96,.36,.08];
  const mesh=new THREE.Mesh(geometry,material(rgb));mesh.position.set((i%3)*155,-Math.floor(i/3)*170,0);mesh.userData.bomId=row.id;mesh.userData.displayScale=105/Math.max(extent.x,extent.y,extent.z);inventory.add(mesh);bomMeshes.set(row.id,mesh);
  const titles={shaft_cap:'Shaft cap',carrier:'Fixed jaw',sliding_jaw:'Sliding jaw',actuator_bracket:'Actuator bracket',rocker:'Rocker',pivot_key:'Printed pivot',thumb_screw:'Thumb screw',thumb_nut:'Printed nut',string_guide:'Captive guide',dual_string_guide:'Duel captive guide',twine:'Continuous twine',rubber_bands:'Rubber bands'};
  label(`${titles[row.id]||row.name||row.id} ×${row.quantity}`,mesh.position.x,mesh.position.y-65,0);
 }
 for(const [i,step] of steps.entries()){const option=document.createElement('option');option.value=i;option.textContent=`${i+1}. ${step.title}`;$('#assembly-step').append(option);}
 $('#assembly-toggle').onclick=()=>stepIndex<0?showStep(0):exitSteps();$('#assembly-exit').onclick=()=>exitSteps();$('#step-back').onclick=()=>showStep(stepIndex-1);$('#step-next').onclick=()=>showStep(stepIndex+1);$('#assembly-step').onchange=e=>showStep(Number(e.target.value));
 $('#mark-feature').onclick=()=>{marking=!marking;setPlaying(false);$('#mark-feature').setAttribute('aria-pressed',String(marking));status.textContent=marking?'Choose a color and tool; drag on a part to paint or draw a shape. Alt + drag or use the cube to orbit.':'Click a component to inspect.';};$('#clear-feature').onclick=()=>clearFeature();$('#feature-radius').oninput=()=>{status.textContent=`Brush radius: ${$('#feature-radius').value} mm. Drag to extend the highlight.`;};
 document.querySelectorAll('[data-view]').forEach(b=>b.onclick=()=>setMode(b.dataset.view));
 $('#string-attachment').disabled=false;$('#string-attachment').onclick=()=>{setPlaying(false);pose(0);setMode('actuator');focus('rocker',meshes.get('rocker'));setDetail('STRING ENDS HERE','Loop around the rocker eye','Pass the free end through the 8 mm eye, around its front edge, and tie it back to the standing string. The brown loop shows the attachment path. Tie before mounting the actuator; check the knot with your actual twine. No stopper knot is needed.');};
 $('#flip').onclick=()=>{flipped=!flipped;frameObjects(visibleMeshes());};
 $('#reset').onclick=()=>setMode(mode);$('#phone').onchange=()=>setMode(mode);$('#transparent').onchange=()=>setMode(mode);$('#stroke').oninput=e=>{setPlaying(false);elapsedMs=0;pose(Number(e.target.value)/100);};
 $('#animate').onclick=()=>{if(!playing&&mode==='phone')setMode('full');setPlaying(!playing);};
 $('#release').onclick=()=>{setPlaying(false);elapsedMs=0;pose(0);};
 document.addEventListener('visibilitychange',()=>{if(document.hidden)setPlaying(false);});
 // Capture paint gestures before OrbitControls sees them; Alt/right drag keep navigation.
 canvas.addEventListener('pointerdown',e=>{if(!marking||e.button!==0||e.altKey)return;e.stopImmediatePropagation();e.preventDefault();painting=true;paintLast=[e.clientX,e.clientY];paintTime=0;controls.enabled=false;canvas.setPointerCapture(e.pointerId);const hit=pick(e);shapeStart=null;shapePreview=null;if(hit){if($('#feature-shape').value==='brush')highlightFeature(hit,featureOverlays.length>0);else{setPlaying(false);const r=canvas.getBoundingClientRect();hit.object.updateWorldMatrix(true,false);const c=viewCube.camera;c.updateMatrixWorld();shapeStart={hit,x:(e.clientX-r.left)/r.width*2-1,y:1-(e.clientY-r.top)/r.height*2,matrix:new THREE.Matrix4().multiplyMatrices(c.projectionMatrix,c.matrixWorldInverse).multiply(hit.object.matrixWorld)};drawFeatureShape(e);}}},true);
 canvas.addEventListener('pointermove',e=>{if(!painting)return;e.stopImmediatePropagation();if(shapeStart){drawFeatureShape(e);return;}if(performance.now()-paintTime<45||Math.hypot(e.clientX-paintLast[0],e.clientY-paintLast[1])<3)return;paintLast=[e.clientX,e.clientY];paintTime=performance.now();const hit=pick(e);if(hit)highlightFeature(hit,true);},true);
 const endPaint=e=>{if(!painting)return;e.stopImmediatePropagation();painting=false;shapeStart=null;shapePreview=null;controls.enabled=true;pointerStart=null;};
 canvas.addEventListener('pointerup',endPaint,true);canvas.addEventListener('pointercancel',endPaint,true);
 canvas.addEventListener('pointerdown',e=>{pointerStart=[e.clientX,e.clientY];});
 canvas.addEventListener('click',e=>{if(!pointerStart||Math.hypot(e.clientX-pointerStart[0],e.clientY-pointerStart[1])>5)return;const m=pick(e);if(m){if(marking)return;else focus(m.object.userData.bomId,m.object);}});
 canvas.addEventListener('contextmenu',e=>{e.preventDefault();const m=pick(e);if(m)menu(m.object.userData.bomId,e);});
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
 controls.update();viewCube.tick();renderer.render(scene,viewCube.camera);renderPreview();
}requestAnimationFrame(frame);
