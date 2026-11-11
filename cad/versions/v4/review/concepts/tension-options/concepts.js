import * as T from 'three';
import {OrbitControls} from 'three/addons/controls/OrbitControls.js';
import {STLLoader} from 'three/addons/loaders/STLLoader.js';
import {installViewCube} from '/view_cube.js';
import {installFramePen} from '/versions/v3/review/concepts/braced-tail-b/frame-pen.js';
import {installSurfacePen} from '/versions/v3/review/concepts/braced-tail-b/surface-pen.js';
const $=id=>document.getElementById(id),stage=$('stage'),canvas=$('scene');
const scene=new T.Scene();scene.background=new T.Color('#f7f7f2');const renderer=new T.WebGLRenderer({canvas,antialias:true,preserveDrawingBuffer:true});renderer.setPixelRatio(Math.min(devicePixelRatio,2));
scene.add(new T.HemisphereLight(0xffffff,0x657075,2.3));const light=new T.DirectionalLight(0xffffff,3);light.position.set(30,-20,80);scene.add(light);
const camera=new T.PerspectiveCamera(36,1,.1,2000);camera.up.set(0,1,0);const controls=new OrbitControls(camera,canvas);const cube=installViewCube({canvas,camera,controls,clickStepDegrees:90});
const meshes={},parts={},cords=[],labels=[];let serial=0,mode='close';
function mesh(g,color,parent){const m=new T.Mesh(g,new T.MeshStandardMaterial({color,roughness:.6}));parent.add(m);meshes['m'+serial++]=m;return m;}
function box(w,h,d,x,y,z,color,parent){const m=mesh(new T.BoxGeometry(w,h,d),color,parent);m.position.set(x,y,z);return m;}
function label(text,x,y,z,parent){const c=document.createElement('canvas');c.width=1024;c.height=128;const ctx=c.getContext('2d');ctx.font='46px system-ui';ctx.textAlign='center';ctx.fillStyle='#243b40';ctx.fillText(text,512,70);const m=new T.Sprite(new T.SpriteMaterial({map:new T.CanvasTexture(c),depthTest:false}));m.scale.set(64,8,1);m.position.set(x,y,z);parent.add(m);labels.push(m);}
function shape(points,holes=[]){const s=new T.Shape();points.forEach(([x,y],i)=>i?s.lineTo(x,y):s.moveTo(x,y));s.closePath();for(const [x,y,w,h]of holes){const p=new T.Path();p.moveTo(x-w/2,y-h/2);p.lineTo(x-w/2,y+h/2);p.lineTo(x+w/2,y+h/2);p.lineTo(x+w/2,y-h/2);p.closePath();s.holes.push(p);}return s;}
function plate(points,holes,color,parent){return mesh(new T.ExtrudeGeometry(shape(points,holes),{depth:3,bevelEnabled:false,curveSegments:12}),color,parent);}
function cord(points,parent,color=0xb58a51,r=.5){const curve=new T.CatmullRomCurve3(points.map(p=>new T.Vector3(...p)));const m=mesh(new T.TubeGeometry(curve,100,r,8,false),color,parent);cords.push(m);return m;}
const orange=0xf2a444,cyan=0x15adbd;
for(const id of ['A','B','C']){parts[id]=new T.Group();scene.add(parts[id]);}
// A: single flat dog-bone cleat, through eye at each end; string wraps neck.
plate([[-10,-18],[10,-18],[10,-10],[5,-7],[5,7],[10,10],[10,18],[-10,18],[-10,10],[-5,7],[-5,-7],[-10,-10]],[[0,-13,5,3],[0,13,5,3]],orange,parts.A);
cord([[0,28,4],[0,13,4],[0,10,4],[-6,6,4],[6,-5,4],[-6,-6,4],[6,5,4],[0,9,4],[11,13,4],[16,7,4]],parts.A);
cord([[0,-13,4],[0,-24,4]],parts.A);label('A · Wrap cleat',0,-31,2,parts.A);label('Pull tail, then lock wraps',0,34,2,parts.A);
// B: flat ladder with selectable closed slots; no moving fasteners.
plate([[-8,-24],[8,-24],[8,24],[-8,24]],[-18,-9,0,9,18].map(y=>[0,y,8,4]),orange,parts.B);
cord([[0,34,4],[0,5,4],[-3,2,4],[-3,-2,4],[3,-2,4],[3,2,4],[0,5,4]],parts.B);
cord([[0,-18,4],[0,-28,4]],parts.B);label('B · Loop ladder',0,-35,2,parts.B);label('Move loop to change length',0,34,2,parts.B);
// C: connected, planar serpentine beam. Enlarged ends carry tie eyes.
plate([[-8,-26],[8,-26],[8,-18],[-8,-18]],[[0,-22,5,3]],cyan,parts.C);
plate([[-8,18],[8,18],[8,26],[-8,26]],[[0,22,5,3]],cyan,parts.C);
for(const y of [-18,-6,6,18])box(16,2.2,3,0,y,1.5,cyan,parts.C);
for(const [x,y] of [[6.9,-12],[-6.9,0],[6.9,12]])box(2.2,12,3,x,y,1.5,cyan,parts.C);
cord([[0,34,4],[0,22,4]],parts.C);cord([[0,-22,4],[0,-32,4]],parts.C);label('C · TPU flexure link',0,-38,2,parts.C);label('Bends to absorb extra pull',0,34,2,parts.C);
const tool=new T.Group();scene.add(tool);tool.visible=false;
box(9,165,8,-23,-10,-8,0xb9c3c8,tool);box(37,12,12,-17,-93,-5,0x406680,tool);box(28,7,7,-7,-78,0,0x323b40,tool);
label('Stock trigger attachment',-7,-110,0,tool);label('Cap passage → pulley → plunger',5,116,0,tool);label('Shaft shortened for clarity',-52,-5,0,tool);
// Actual accepted actuator meshes as context. Its return band remains local.
const loader=new STLLoader();await Promise.all(['bracket','plunger','pulley'].map(async n=>{try{const g=await loader.loadAsync('/versions/v4/review/concepts/steep-stop/models/'+n+'.stl');const m=mesh(g,n==='plunger'?cyan:orange,tool);m.position.set(0,58,0);}catch(e){console.warn('Actuator context unavailable',e);}}));
cord([[0,42,4],[0,58,4],[12,68,10],[22,79,10],[22,93,10],[10,101,10],[0,96,10]],tool);cord([[0,-34,4],[0,-78,4]],tool);
// All routes illustrative, not inherited old V3 inline-band geometry.
const descriptions={A:'A — Set length with a single PETG wrap cleat beside the trigger. Tie the lower eye to the existing trigger attachment; pull the upper cord through, then secure with locking wraps. Continuous adjustment. No elastic element is added; avoid button preload and excessive trigger travel.',B:'B — Tie the actuator cord loop through a selected closed slot. Move the loop up/down for repeatable length changes; tie the lower eye to the trigger attachment. Simple positive attachment, but adjustment is stepped. No elastic element is added.',C:'C — Tie a flat TPU serpentine link between trigger and actuator cord. Adjust coarse length at the knots; the bends provide compliance without a separate rubber band. This is an experiment, not a calibrated spring. It may creep or absorb too much travel; force/travel testing is essential.',all:'A/B solve length adjustment without an inline band. C addresses excess pull using a printed TPU link instead. None automatically corrects a slipping harness. Prefer A for the first adjustment study; assess full trigger travel before removing all compliance.'};
function framing(){const overview=mode==='route',all=$('option').value==='all';controls.target.set(0,overview?0:0,0);camera.up.set(0,1,0);camera.position.set(mode==='plate'?0:overview?110:all?90:40,mode==='plate'?0:overview?-90:-60,overview?300:all?230:125);controls.update();}
function update(){let id=$('option').value;if(mode==='route'&&id==='all'){id='A';$('option').value=id;}tool.visible=mode==='route';Object.entries(parts).forEach(([n,g],i)=>{g.visible=id==='all'||n===id;g.position.set(id==='all'?(i-1)*62:0,0,0);});cords.forEach(m=>m.visible=$('cord').checked&&mode!=='plate');labels.forEach(m=>m.visible=mode!=='plate');$('description').textContent=descriptions[id];$('status').textContent=mode==='route'?'Placement concept near trigger · continuous string, no inline rubber band':mode==='plate'?'Print broad face down · flat 3 mm extrusions · slice verification pending':'Three 3D alternatives · drag to orbit, scroll to zoom';framing();}
$('option').onchange=update;for(const id of ['close','route','plate'])$(id).onclick=()=>{mode=id;update();};$('cord').onchange=()=>cords.forEach(m=>m.visible=$('cord').checked&&mode!=='plate');$('reset').onclick=framing;
installSurfacePen(stage,()=>cube.camera,controls,meshes);installFramePen(stage,{sourceCanvas:canvas,controls:[...document.querySelectorAll('header button,header input,header select')],filename:'v4-tension-options.png'});window.addEventListener('frame-pen-state',e=>{stage.querySelector('.view-cube').inert=e.detail;});
function resize(){renderer.setSize(stage.clientWidth,stage.clientHeight,false);camera.aspect=stage.clientWidth/stage.clientHeight;camera.updateProjectionMatrix();}new ResizeObserver(resize).observe(stage);resize();update();renderer.setAnimationLoop(()=>{if(window.annotationFrozen)return;controls.update();cube.tick();renderer.render(scene,cube.camera);});
