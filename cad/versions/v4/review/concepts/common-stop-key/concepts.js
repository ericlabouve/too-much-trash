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
const camera=new T.PerspectiveCamera(35,1,.1,1000);camera.up.set(0,0,1);const controls=new OrbitControls(camera,canvas);
const cube=installViewCube({canvas,camera,controls,clickStepDegrees:90});
function reset(){controls.target.set(-2,24,6);camera.position.set(45,0,80);camera.up.set(0,0,1);controls.update();}reset();
const meshes={},loader=new STLLoader();let pose='rest';
try{
await Promise.all(['bracket','plunger','top-key','fork','reverse-bracket','reverse-plunger','reverse-key','pulley','pulley_axle','pulley_key'].map(async name=>{const g=await loader.loadAsync('models/'+name+'.stl');const m=new T.Mesh(g,new T.MeshStandardMaterial({color:name==='fork'?0xd83232:name.includes('plunger')||name.includes('key')?0x13adbd:0xf2a444,roughness:.55}));meshes[name]=m;scene.add(m);}));
installSurfacePen(stage,()=>cube.camera,controls,meshes);installFramePen(stage,{sourceCanvas:canvas,controls:[...document.querySelectorAll('header button,header input,header select')],filename:'v4-common-key.png'});
window.addEventListener('frame-pen-state',e=>{stage.querySelector('.view-cube').inert=e.detail;});
function update(){const a=$('option').value==='reverse';for(const[n,m]of Object.entries(meshes)){m.position.set(0,0,0);m.visible=(a?['reverse-bracket','reverse-plunger','reverse-key']:['bracket','plunger','top-key','fork']).includes(n)||($('context').checked&&['pulley','pulley_axle','pulley_key'].includes(n));if(n.includes('bracket')){m.material.transparent=$('ghost').checked;m.material.opacity=$('ghost').checked?.22:1;m.material.depthWrite=!$('ghost').checked;}}
if(pose==='pull'){meshes[a?'reverse-plunger':'plunger'].position.y=-12.6;if(a)meshes['reverse-key'].position.y=-12.6;}
if(pose==='explode'){meshes[a?'reverse-key':'top-key'].position.z=18;meshes[a?'reverse-plunger':'plunger'].position.z=9;}
$('status').textContent=a?'A · Reverse the slot ownership — key and plunger move together':'B · Stationary top fork — rejected as shown';
$('detail').textContent=a?'Push the unchanged key downward through a small hole in a raised seat on the plunger. Its V opens across the slot below the fixed plate, catching 0.8 mm on each side. The long closed slot moves to the plate, so the key slides along it with the plunger. The 9.2 mm seat-to-underside stack matches the original key. Remove the key before end-on plunger insertion. This avoids a second key design and any extra loose adapter.':'Two stationary posts support the T-head above the moving plunger. Although the original key spans the stack, those posts occupy the plunger slot and block end-on insertion even after removing the key. This is why simply adding a tall fixed seat is not a complete solution.';
}
$('option').onchange=()=>{pose='rest';update();};for(const id of['ghost','context'])$(id).onchange=update;for(const id of['rest','pull','explode'])$(id).onclick=()=>{pose=id;update();};$('reset').onclick=reset;$('under').onclick=()=>{controls.target.set(0,25,1);camera.position.set(25,10,-65);camera.up.set(0,1,0);controls.update();};$('loading').remove();update();
}catch(e){$('loading').textContent='Unable to load CAD: '+e.message;throw e;}
function resize(){renderer.setSize(stage.clientWidth,stage.clientHeight,false);camera.aspect=stage.clientWidth/stage.clientHeight;camera.updateProjectionMatrix();}new ResizeObserver(resize).observe(stage);resize();renderer.setAnimationLoop(()=>{if(window.annotationFrozen)return;controls.update();cube.tick();renderer.render(scene,cube.camera);});
