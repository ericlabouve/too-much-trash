import * as THREE from 'three';
import {OrbitControls} from 'three/addons/controls/OrbitControls.js';
const $=s=>document.querySelector(s);
const label=n=>n.replaceAll('_',' ');
const load=async url=>{const r=await fetch(url);if(!r.ok)throw Error(`${url}: ${r.status}`);return r.json()};
function metric(value,caption){const el=document.createElement('div');el.className='metric';el.textContent=value;const small=document.createElement('small');small.textContent=caption;el.append(small);$('#summary').append(el)}
try{
 const [report,data,config]=await Promise.all(['review.json','paths.json','viewer.json'].map(load));
 document.title=config.title;$('#title').textContent=config.title;$('#subtitle').textContent=config.subtitle;
 const grams=(report.deposited_g_by_role?.support||0)+(report.deposited_g_by_role?.interface||0);
 const minutes=Number.isFinite(report.total_minutes)?Math.round(report.total_minutes):null;
 metric(minutes===null?'Unknown':`${Math.floor(minutes/60)} h ${minutes%60} min`,'slicer estimate');
 metric(Number.isFinite(report.total_g)?`${report.total_g.toFixed(2)} g`:'Unknown','total filament estimate');
 metric(report.deposited_g_by_role?`${grams.toFixed(2)} g`:'Unknown','support + interface paths');
 metric(String(report.pieces??Object.keys(data.objects).length),'pieces on this plate');
 metric(report.warning?'Review warning':report.warning===''?'No warnings':'Unknown','slicer result');
 for(const [name,box] of Object.entries(data.objects)){
  const option=document.createElement('option');option.value=name;option.textContent=label(name);$('#focus').append(option);
  const row=document.createElement('tr'),r=report.objects?.[name];
  const mass=(r?.deposited_g_by_role?.support||0)+(r?.deposited_g_by_role?.interface||0);
  for(const text of [label(name),r?`${mass.toFixed(3)} g`:'Unknown',r?(r.support_z_mm?r.support_z_mm.map(v=>v.toFixed(2)).join('–')+' mm':'None generated'):'Unknown']){const cell=document.createElement('td');cell.textContent=text;row.append(cell)}$('#parts').append(row);
 }
 for(const [key,value] of Object.entries(report.effective_settings||{})){if(value==null)continue;const dt=document.createElement('dt'),dd=document.createElement('dd');dt.textContent=label(key);dd.textContent=Array.isArray(value)?value.join(', '):String(value);$('#settings').append(dt,dd)}
 if(report.effective_object_settings?.length){const details=document.createElement('details'),summary=document.createElement('summary'),dl=document.createElement('dl');summary.textContent='Per-object recipe overrides';details.append(summary,dl);for(const row of report.effective_object_settings){const dt=document.createElement('dt'),dd=document.createElement('dd');dt.textContent=label(row.name||row.id||'Object');dd.textContent=Object.entries(row).filter(([k])=>!['name','id'].includes(k)).map(([k,v])=>`${label(k)}: ${v}`).join(' · ');dl.append(dt,dd)}$('#settings').after(details)}
 for(const text of [...(config.notes||[]),...(report.warning?[`Slicer warning: ${report.warning}`]:[]),...(report.limits||[]).map(s=>`Audit-time note (not live status): ${s}`)]){const li=document.createElement('li');li.textContent=text;$('#notes').append(li)}
 for(const item of [{label:'Detailed slice report',href:'review.json'},{label:'Toolpath metadata',href:'paths.json'},...(config.links||[])]){const url=new URL(item.href,location.href);if(url.origin!==location.origin||!['http:','https:'].includes(url.protocol))continue;const li=document.createElement('li'),a=document.createElement('a');a.textContent=item.label;a.href=url.href;li.append(a);$('#links').append(li)}
 $('#hashes').textContent=JSON.stringify({gcode_md5:report.gcode_md5,hashes:report.hashes},null,2);
 const canvas=$('#view'),renderer=new THREE.WebGLRenderer({canvas,antialias:true});renderer.setPixelRatio(Math.min(devicePixelRatio,2));renderer.setClearColor('#fcfcfa');
 const scene=new THREE.Scene(),camera=new THREE.PerspectiveCamera(40,1,.1,10000);camera.up.set(0,0,1);
 const controls=new OrbitControls(camera,canvas);controls.enableDamping=true;
 const bed=data.bed_polygon_mm;if(!Array.isArray(bed)||bed.length<3)throw Error('Missing bed polygon');
 const bedGeometry=new THREE.BufferGeometry().setFromPoints(bed.map(p=>new THREE.Vector3(...p,-.3)));scene.add(new THREE.LineLoop(bedGeometry,new THREE.LineBasicMaterial({color:0x98aaaa})));
 const bedBox=new THREE.Box3().setFromPoints(bed.map(p=>new THREE.Vector3(...p,0)));
 const lines={};
 await Promise.all(Object.entries(data.paths).map(async([kind,p])=>{
  const response=await fetch(p.file);if(!response.ok)throw Error(p.file);const buffer=await response.arrayBuffer();
  if(buffer.byteLength%24)throw Error('Invalid toolpath binary');const positions=new Float32Array(buffer);
  if(p.ends.length!==data.heights.length||p.ends.at(-1)!==positions.length/3)throw Error('Layer counts do not match toolpath buffer');
  const geometry=new THREE.BufferGeometry();geometry.setAttribute('position',new THREE.BufferAttribute(positions,3));
  const material=new THREE.LineBasicMaterial({color:p.color,transparent:kind==='model',opacity:kind==='model'?.20:1,depthWrite:kind!=='model'});
  const line=new THREE.LineSegments(geometry,material);line.renderOrder=kind==='model'?0:1;scene.add(line);lines[kind]=line;
 }));
 $('#layer').max=data.heights.length-1;$('#layer').value=data.heights.length-1;
 function range(){const i=Number($('#layer').value);$('#height').textContent=`${data.heights[i].toFixed(2)} mm`;for(const[k,p]of Object.entries(data.paths)){const start=$('#single').checked&&i?p.ends[i-1]:0;lines[k].geometry.setDrawRange(start,p.ends[i]-start);lines[k].visible=k==='model'?$('#model').checked:k==='adhesion'?$('#adhesion').checked:$('#support').checked}canvas.dataset.layer=String(i);canvas.dataset.single=String($('#single').checked);canvas.dataset.model=String($('#model').checked);canvas.dataset.support=String($('#support').checked)}
 let direction='iso';
 function frame(){const b=data.objects[$('#focus').value];const box=b?new THREE.Box3(new THREE.Vector3(b.x,b.y,b.z||0),new THREE.Vector3(b.x+b.width,b.y+b.depth,(b.z||0)+b.height)):bedBox.clone();if(!b)box.max.z=Math.max(...data.heights);const target=box.getCenter(new THREE.Vector3()),size=box.getSize(new THREE.Vector3());const span=Math.max(size.x,size.y,size.z,1)*1.6/Math.min(1,camera.aspect);const offset=direction==='top'?new THREE.Vector3(0,-.001,1):direction==='front'?new THREE.Vector3(0,-1,.02):new THREE.Vector3(.45,-.9,.85).normalize();camera.position.copy(target).addScaledVector(offset,span);controls.target.copy(target);controls.update();canvas.dataset.focus=$('#focus').value;canvas.dataset.direction=direction}
 for(const id of ['iso','top','front'])$('#'+id).onclick=()=>{direction=id;frame()};$('#focus').onchange=frame;
 for(const id of ['layer','single','model','support','adhesion'])$('#'+id).oninput=range;
 $('#all').onclick=()=>{$('#layer').value=data.heights.length-1;$('#single').checked=false;range()};
 function resize(){const r=canvas.parentElement.getBoundingClientRect();renderer.setSize(r.width,r.height,false);camera.aspect=r.width/r.height;camera.updateProjectionMatrix()}
 new ResizeObserver(resize).observe(canvas.parentElement);resize();frame();range();
 renderer.setAnimationLoop(()=>{controls.update();renderer.render(scene,camera)});
 $('#status').textContent='Actual sliced toolpaths · drag to orbit · scroll to zoom';canvas.dataset.ready='true';
}catch(e){$('#error').textContent='Preview could not load: '+e.message;$('#status').textContent='Open the sliced project in Bambu Studio; this preview is unavailable.';console.error(e)}
