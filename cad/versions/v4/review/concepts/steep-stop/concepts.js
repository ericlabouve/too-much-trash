import * as T from 'three';
import {OrbitControls} from 'three/addons/controls/OrbitControls.js';
import {STLLoader} from 'three/addons/loaders/STLLoader.js';
import {installViewCube} from '../../../../../view_cube.js';
import {installFramePen} from '/versions/v3/review/concepts/braced-tail-b/frame-pen.js';
import {installSurfacePen} from '/versions/v3/review/concepts/braced-tail-b/surface-pen.js';
const $=id=>document.getElementById(id),stage=$('stage'),canvas=$('scene');
const scene=new T.Scene();scene.background=new T.Color('#f7f7f2');
const renderer=new T.WebGLRenderer({canvas,antialias:true,preserveDrawingBuffer:true});renderer.setPixelRatio(Math.min(devicePixelRatio,2));
scene.add(new T.HemisphereLight(0xffffff,0x657075,2.3));const light=new T.DirectionalLight(0xffffff,3);light.position.set(30,-20,80);scene.add(light);
const camera=new T.PerspectiveCamera(35,1,.1,1000);camera.up.set(0,0,1);const controls=new OrbitControls(camera,canvas);controls.target.set(-3,24,7);
const cube=installViewCube({canvas,camera,controls,clickStepDegrees:90});
function reset(){controls.target.set(-3,24,7);camera.position.set(25,-5,105);camera.up.set(0,0,1);controls.update();}reset();
const meshes={},loader=new STLLoader();let pose='rest';
try{
await Promise.all(['bracket','plunger','previous-plunger','stop','pulley','pulley_axle','pulley_key'].map(async name=>{const g=await loader.loadAsync('models/'+name+'.stl?revision=slot-to-handle-1');const m=new T.Mesh(g,new T.MeshStandardMaterial({color:name==='previous-plunger'?0xa642c6:name.endsWith('plunger')||name==='pulley_key'||name==='stop'?0x13adbd:0xf2a444,roughness:.55}));meshes[name]=m;scene.add(m);}));
installSurfacePen(stage,()=>cube.camera,controls,meshes);installFramePen(stage,{sourceCanvas:canvas,controls:[...document.querySelectorAll('header button,header input,header select')],filename:'v4-tail-handle.png'});
window.addEventListener('frame-pen-state',e=>{stage.querySelector('.view-cube').inert=e.detail;});
function update(){for(const [n,m] of Object.entries(meshes)){m.position.set(0,0,0);m.visible=['bracket','plunger','stop'].includes(n)||(n==='previous-plunger'?$('previous').checked:$('context').checked);if(n==='bracket'){m.material.transparent=$('ghost').checked;m.material.opacity=$('ghost').checked?.25:1;m.material.depthWrite=!$('ghost').checked;}if(n==='previous-plunger'){m.material.transparent=true;m.material.opacity=.22;m.material.depthWrite=false;}}
meshes.stop.visible=pose!=='insert';
meshes.plunger.position.y=pose==='limit'?-12.5:pose==='insert'?-53:0;
$('status').textContent=(window.sliceStatus||'Slice verification pending.')+' · '+(pose==='limit'?'Pulled 12.5 mm — illustrative motion':pose==='insert'?'Unobstructed insertion passage':'Handle at tail · key seated from underneath');}
for(const id of ['context','ghost','previous'])$(id).onchange=update;
for(const id of ['rest','limit','insert'])$(id).onclick=()=>{pose=id;update();};
$('junction').onclick=()=>{controls.target.set(0,12,6);camera.position.set(18,-8,32);camera.up.set(0,0,1);controls.update();};
$('top').onclick=()=>{camera.position.set(-3,24,125);camera.up.set(0,1,0);controls.update();};$('reset').onclick=reset;
$('under').onclick=()=>{camera.position.set(-3,24,-100);camera.up.set(0,1,0);controls.update();};
$('fullscreen').onclick=()=>{if(document.fullscreenElement)document.exitFullscreen();else stage.requestFullscreen?.();};
fetch('support-status.json?revision=slot-to-handle-1').then(r=>r.ok?r.json():null).then(r=>{if(r){window.sliceStatus=r.summary;}else $('slice').hidden=true;update();}).catch(()=>{$('slice').hidden=true;update();});
$('loading').remove();update();
}catch(e){$('loading').textContent='Unable to load CAD: '+e.message;throw e;}
function resize(){const w=stage.clientWidth,h=stage.clientHeight;renderer.setSize(w,h,false);camera.aspect=w/h;camera.updateProjectionMatrix();}new ResizeObserver(resize).observe(stage);resize();
renderer.setAnimationLoop(()=>{if(window.annotationFrozen)return;controls.update();cube.tick();renderer.render(scene,cube.camera);});

fetch('slice/viewer.json').then(r=>{if(!r.ok)$('slice').hidden=true;}).catch(()=>{$('slice').hidden=true;});
