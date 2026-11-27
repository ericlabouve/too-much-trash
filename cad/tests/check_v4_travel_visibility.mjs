// Regression test for the V4 pose branch: stroke must not override view/toggle visibility.
import assert from 'node:assert/strict';
import {readFileSync} from 'node:fs';
const source=readFileSync(new URL('../versions/v3/viewer.js',import.meta.url),'utf8');
const start=source.indexOf(" if(design==='v4'){",source.indexOf('function pose('));
const end=source.indexOf('\n const m=manifest.motion,axis=',start);
const branch=source.slice(start,end);
assert.ok(start>0&&end>start);
const names=['plunger_stop','plunger','twine_attachment','phone_envelope','camera_keepout','phone_volume_up','twine','twine_phone','twine_trigger','band_return','band_overtravel'];
for(const fraction of [0,.5,1])for(const visible of [true,false]){
 const meshes=new Map(names.map(name=>[name,{position:{x:0,set(x,y,z){this.x=x;this.y=y;this.z=z;}},visible}]));
 const ui=new Map(),$=id=>{if(!ui.has(id))ui.set(id,{});return ui.get(id);};
 const tubes=new Map(),replaceTube=(name,points)=>tubes.set(name,points);
 const frames=[0,12.6].map(d=>({string_points:[[20-d,2,3],[10,2,3],[0,2,3]],phone_points:[[20-d,2,3],[10,2,3]],attachment_points:[[20-d,0,0],[21-d,0,0]],return_points:[[20-d,0,0],[10,0,0]]}));
 const manifest={parameters:{twine_diameter:1},motion:{plunger_stop_moves_with_plunger:true,mechanical_travel_mm:12.6,v4_routes:frames}};
 const canvas={dataset:{}};
 Function('design','fraction','manifest','meshes','$','replaceTube','canvas','outline',branch)('v4',fraction,manifest,meshes,$,replaceTube,canvas,null);
 for(const mesh of meshes.values())assert.equal(mesh.visible,visible);
 assert.equal(meshes.get('plunger').position.x,-12.6*fraction);
 assert.equal(meshes.get('plunger_stop').position.x,-12.6*fraction);
 assert.equal(meshes.get('phone_envelope').position.x,0);
 assert.equal(tubes.get('twine')[0][0],20-12.6*fraction);
 assert.equal(tubes.get('twine')[1][0],10);
 assert.equal(tubes.get('band_return')[0][0],20-12.6*fraction);
 assert.equal(tubes.get('band_return')[1][0],10);
 assert.match(ui.get('#motion-info').textContent,/may pass phone contact/);
}
console.log('V4 travel: 0/50/100% preserve visible/hidden states; phone fixed, string endpoint and return band follow plunger.');
