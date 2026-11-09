import * as T from 'three';
import {OrbitControls} from 'three/addons/controls/OrbitControls.js';
import {STLLoader} from 'three/addons/loaders/STLLoader.js';
import {installViewCube} from '../../../../../view_cube.js';
import {installFramePen} from '/versions/v3/review/concepts/braced-tail-b/frame-pen.js';
import {installSurfacePen} from '/versions/v3/review/concepts/braced-tail-b/surface-pen.js';
const el=document.querySelector('#stage'),canvas=document.querySelector('#canvas');
const scene=new T.Scene();scene.background=new T.Color('#f5f5f0');
const camera=new T.PerspectiveCamera(35,1,.1,1000);camera.up.set(0,1,0);
const renderer=new T.WebGLRenderer({canvas,antialias:true,preserveDrawingBuffer:true});renderer.setPixelRatio(Math.min(devicePixelRatio,2));
const controls=new OrbitControls(camera,canvas),loader=new STLLoader();
scene.add(new T.HemisphereLight(0xffffff,0x737373,2));const light=new T.DirectionalLight(0xffffff,2);light.position.set(20,80,40);scene.add(light);
const meshes={},context={};let choice='a';
const details={original:'Current: Ø18 mm with two sloped flanges. No inward retaining lip.',a:'A · Raise only the guide-facing flange to Ø21 mm. A larger barrier without an inward hook; easiest threading and lowest support risk, but a sharp sideways pull can still climb over it.',b:'B · Ø20 mm flange with a sloping lip reaching inward over the groove. More direct protection against sideways escape; less threading space and greater rubbing/overhang risk.',c:'C · Ø20 mm flange with a rounded retaining bead. A softer contact edge than B; modest inward capture, but still requires support and wear checks.'};
try{
 for(const n of ['original','a','b','c'])for(const suffix of (n==='original'?['','-section']:['','-section','-addition','-section-addition'])){
 const key=n+suffix;const geometry=await loader.loadAsync(key+'.stl');
 const m=new T.Mesh(geometry,new T.MeshStandardMaterial({color:suffix.includes('addition')?0x9963b3:0xe99b43,roughness:.65,polygonOffset:suffix.includes('addition'),polygonOffsetFactor:-1,polygonOffsetUnits:-1}));meshes[key]=m;scene.add(m);
 }
 const rows=await fetch('../../../preview/context.json').then(r=>r.json());
 for(const row of rows.filter(r=>r.name!=='pulley')){
 const m=new T.Mesh(await loader.loadAsync('../../../preview/'+row.name+'.stl'),new T.MeshStandardMaterial({color:row.color}));context[row.name]=m;scene.add(m);
 }
 for(const n of ['cap','jaw','cap-liner','jaw-liner','shaft']){
 const m=new T.Mesh(await loader.loadAsync('../../../preview/'+n+'.stl'),new T.MeshStandardMaterial({color:n.includes('liner')?0x16aebd:n==='shaft'?0xa4b3bb:0xe68b37}));context[n]=m;scene.add(m);
 }
 const cube=installViewCube({canvas,camera,controls,clickStepDegrees:90});
 installSurfacePen(el,()=>cube.camera,controls,{...meshes,...context});
 installFramePen(el,{sourceCanvas:canvas,controls:[...document.querySelectorAll('header button,header input')]});
 window.addEventListener('frame-pen-state',e=>{el.querySelector('.view-cube').inert=e.detail});
 function pose(){const section=document.querySelector('#section').checked,assembly=document.querySelector('#assembly').checked;
 for(const[n,m]of Object.entries(meshes))m.visible=n===choice+(section?'-section':'');
 // Overlay the existing envelope so additions are clear in purple.
 if(choice!=='original')meshes[choice+(section?'-section':'')+'-addition'].visible=true;
 Object.values(context).forEach(m=>m.visible=assembly);
 document.querySelector('#note').textContent=details[choice];}
 function frame(){cube.perspective();camera.up.set(0,1,0);controls.target.set(6.45,21.75,-2.475);camera.position.set(30,43,-28);controls.update();}
 for(const b of document.querySelectorAll('[data-choice]'))b.onclick=()=>{choice=b.dataset.choice;pose()};
 document.querySelector('#section').onchange=pose;document.querySelector('#assembly').onchange=pose;document.querySelector('#reset').onclick=frame;
 new ResizeObserver(()=>{if(window.annotationFrozen)return;renderer.setSize(canvas.clientWidth,canvas.clientHeight,false);camera.aspect=canvas.clientWidth/canvas.clientHeight;camera.updateProjectionMatrix()}).observe(canvas);
 renderer.setAnimationLoop(()=>{if(window.annotationFrozen)return;cube.tick();renderer.render(scene,cube.camera)});pose();frame();
}catch(e){document.querySelector('#error').textContent=String(e);}
