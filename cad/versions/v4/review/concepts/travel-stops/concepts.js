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
function reset(){camera.position.set(25,-5,105);camera.up.set(0,0,1);controls.update();}reset();
const meshes={},loader=new STLLoader();let pose='rest';
const descriptions={a:'A — A pin passes through a closed-ended slot in the triangular shaft. The slot end catches the pin after 6.0 mm of pull. This spreads the stop through the shaft but removes some shaft material. The pin is fitted from underneath after insertion, clear of the pulley.',b:'B — A small L-shaped gate catches the handle’s lower stem after approximately 3.2 mm of pull. The plunger stays unchanged. A shallow rectangular pocket in the guide wall locates the gate on the pulley side; the gate remains below the cord/band tie area.'};
const travel={a:6,b:3.2};
$('concept').value=new URLSearchParams(location.search).get('concept')==='b'?'b':'a';
try{
await Promise.all(['a-bracket','a-plunger','a-stop','b-bracket','b-plunger','b-stop','pulley','pulley_axle','pulley_key'].map(async name=>{const g=await loader.loadAsync('models/'+name+'.stl');const m=new T.Mesh(g,new T.MeshStandardMaterial({color:name.endsWith('stop')?0xa642c6:name.endsWith('plunger')||name==='pulley_key'?0x13adbd:0xf2a444,roughness:.55}));meshes[name]=m;scene.add(m);}));
installSurfacePen(stage,()=>cube.camera,controls,meshes);installFramePen(stage,{sourceCanvas:canvas,controls:[...document.querySelectorAll('header button,header input,header select')],filename:'v4-plunger-stop.png'});
window.addEventListener('frame-pen-state',e=>{stage.querySelector('.view-cube').inert=e.detail;});
function update(){const k=$('concept').value;for(const [n,m] of Object.entries(meshes)){m.visible=n.startsWith(k+'-')||(!n.includes('-')&&$('context').checked);m.position.set(0,0,0);if(n.endsWith('bracket')){m.material.transparent=$('ghost').checked;m.material.opacity=$('ghost').checked?.25:1;m.material.depthWrite=!$('ghost').checked;}}
meshes[k+'-plunger'].position.y=pose==='limit'?-travel[k]:pose==='insert'?-42:0;
meshes[k+'-stop'].position.z=['explode','insert'].includes(pose)?(k==='a'?-18:18):0;
$('description').textContent=descriptions[k];$('status').textContent=(window.sliceStatus||'Slice verification pending.')+' · '+(pose==='limit'?`Stopped at ${travel[k]} mm`:pose==='insert'?'Stop removed; plunger slides in from the foot end':pose==='explode'?'Remove stop before sliding out plunger':'At rest');}
for(const id of ['concept','context','ghost'])$(id).onchange=update;
for(const id of ['rest','limit','explode','insert'])$(id).onclick=()=>{pose=id;update();};
$('top').onclick=()=>{camera.position.set(-3,24,125);camera.up.set(0,1,0);controls.update();};$('reset').onclick=reset;
$('fullscreen').onclick=()=>{if(document.fullscreenElement)document.exitFullscreen();else stage.requestFullscreen?.();};
fetch('support-status.json').then(r=>r.ok?r.json():null).then(r=>{if(r){window.sliceStatus=r.summary;}else $('slice').hidden=true;update();}).catch(()=>{$('slice').hidden=true;update();});
$('loading').remove();update();
}catch(e){$('loading').textContent='Unable to load CAD: '+e.message;throw e;}
function resize(){const w=stage.clientWidth,h=stage.clientHeight;renderer.setSize(w,h,false);camera.aspect=w/h;camera.updateProjectionMatrix();}new ResizeObserver(resize).observe(stage);resize();
renderer.setAnimationLoop(()=>{if(window.annotationFrozen)return;controls.update();cube.tick();renderer.render(scene,cube.camera);});

fetch('slice-r3/viewer.json').then(r=>{if(!r.ok)$('slice').hidden=true;}).catch(()=>{$('slice').hidden=true;});
