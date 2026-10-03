import * as THREE from 'three';
import {STLLoader} from 'three/addons/loaders/STLLoader.js';
import {OrbitControls} from 'three/addons/controls/OrbitControls.js';
const $=x=>document.querySelector(x),canvas=$('#view');const side=new URLSearchParams(location.search).get('side')==='far'?'far':'near';$('#side').value=side;
$('#side').onchange=()=>location.search='?side='+$('#side').value;
const renderer=new THREE.WebGLRenderer({canvas,antialias:true});renderer.setPixelRatio(Math.min(devicePixelRatio,2));renderer.setClearColor(0xfaf9f5);
const scene=new THREE.Scene();scene.add(new THREE.HemisphereLight(0xffffff,0x8d9698,2.6));const lamp=new THREE.DirectionalLight(0xffffff,3);lamp.position.set(-150,250,180);scene.add(lamp);
const camera=new THREE.PerspectiveCamera(35,1,.1,4000),controls=new OrbitControls(camera,canvas);controls.enableDamping=true;
const root=new THREE.Group();root.rotation.x=-Math.PI/2;scene.add(root);const meshes=[],loader=new STLLoader();let report,viewCone;
function resize(){renderer.setSize(canvas.clientWidth,canvas.clientHeight,false);camera.aspect=canvas.clientWidth/canvas.clientHeight;camera.updateProjectionMatrix();}resize();window.addEventListener('resize',resize);
function frame(){root.updateWorldMatrix(true,true);const box=new THREE.Box3();for(const m of meshes)if(m.visible&&!m.userData.flex)box.expandByObject(m);const center=box.getCenter(new THREE.Vector3()),size=box.getSize(new THREE.Vector3());controls.target.copy(center);camera.position.copy(center).add(new THREE.Vector3(-.7,.85,1).normalize().multiplyScalar(size.length()*1.8));controls.update();}
function update(){const variant=$('#variant').value,angle=$('#angle').value,hits=report.view_envelope_intersections_mm3['wallet-'+side][variant][angle];for(const mesh of meshes){mesh.visible=mesh.userData.variant==='both'||mesh.userData.variant===variant;const name=mesh.userData.name;const color=name==='phone_envelope'?0xaebac0:name==='camera_keepout'?0x26967b:mesh.userData.flex?(name==='twine_phone'?0x997139:0x9469b7):hits[name]?0xbd4440:0xf58b3d;mesh.material.color.setHex(color);}
if(viewCone){root.remove(viewCone);viewCone.geometry.dispose();viewCone.material.dispose();}
const z=22,d=55,g=d*Math.tan(Number(angle)*Math.PI/180),lo=[[-94,33,z],[-56,33,z],[-56,73,z],[-94,73,z]],hi=[[-94-g,33-g,z+d],[-56+g,33-g,z+d],[-56+g,73+g,z+d],[-94-g,73+g,z+d]],points=[];
for(let i=0;i<4;i++)points.push(...lo[i],...lo[(i+1)%4],...hi[i],...hi[(i+1)%4],...lo[i],...hi[i]);const geom=new THREE.BufferGeometry();geom.setAttribute('position',new THREE.Float32BufferAttribute(points,3));viewCone=new THREE.LineSegments(geom,new THREE.LineBasicMaterial({color:0x26967b,transparent:true,opacity:.65}));viewCone.visible=$('#cone').checked;root.add(viewCone);
$('#title').textContent=variant==='current'?'Earlier raised rails':'Recessed — official V2';$('#result').textContent=variant==='current'?'Long rails reach 58 mm ahead of the assumed lens plane.':'Long rails end 6 mm behind the assumed lens plane. Other components still need attention.';
$('#hits').textContent=Object.keys(hits).join(', ').replaceAll('_',' ')||'No intersections in this assumed view envelope.';
canvas.dataset.variant=variant;canvas.dataset.ready='true';}
try{report=await(await fetch('report.json')).json();const rows=await(await fetch('wallet-'+side+'.json')).json();const refBase='../../archive/recessed-r3/review/'+(side==='far'?'wallet-far/':'');const manifest=await(await fetch(refBase+'manifest.json')).json();for(const e of manifest.assembly)if(e.name==='twine_phone'||['band_jaw_1','band_jaw_2','band_return','band_collar_1','band_collar_2'].includes(e.name))rows.push({name:e.name,file:refBase+e.file,variant:'both',flex:true});
await Promise.all(rows.filter(r=>!r.name.startsWith('guide_')).map(async row=>{const geometry=await loader.loadAsync(row.file);geometry.computeVertexNormals();const material=new THREE.MeshStandardMaterial({roughness:.7});if(row.name==='camera_keepout'){material.transparent=true;material.opacity=.5;}const mesh=new THREE.Mesh(geometry,material);mesh.userData=row;meshes.push(mesh);root.add(mesh);}));
$('#variant').onchange=()=>{update();frame();};$('#angle').onchange=update;$('#cone').onchange=update;$('#reset').onclick=frame;update();frame();$('#status').textContent='Drag to orbit · scroll to zoom. Recessed geometry now matches official V2; camera-view clearance remains unresolved.';
}catch(e){$('#status').textContent='Study load failed: '+e.message;console.error(e);}
function tick(){requestAnimationFrame(tick);controls.update();renderer.render(scene,camera);}tick();
