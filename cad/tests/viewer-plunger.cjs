// V3 integration smoke test against the checkout served on CAD_VIEWER_URL.
const assert=require('node:assert/strict');
const {chromium}=require(process.env.PLAYWRIGHT_MODULE || 'playwright');
(async()=>{
 const browser=await chromium.launch({headless:true,executablePath:process.env.CHROME_PATH,args:['--use-angle=swiftshader']});
 try {
  const page=await browser.newPage({viewport:{width:1500,height:1100}}),errors=[];
  page.on('pageerror',e=>errors.push(e.message));
  const base=process.env.CAD_VIEWER_URL||'http://127.0.0.1:8767';
  await page.goto(base+'/versions/v3/viewer.html?revision=deep-groove-pulley-v3');
  const canvas=page.locator('#view');await page.locator('#view[data-ready=true]').waitFor({timeout:120000});
  const manifest=await page.evaluate(async()=>await (await fetch('review/manifest.json')).json());
  assert.equal(manifest.motion.kind,'plunger');assert.equal(manifest.printed_pieces,22);assert.equal(manifest.printed_designs,12);
  assert.equal(manifest.revision,'deep-groove-pulley-v3');
  for(const id of ['collar_screw','thumb_nut']){
   const row=manifest.bom.find(r=>r.id===id);
   assert.equal(row.quantity,5);assert.equal(row.material,'ELEGOO TPU 95A');
   assert.equal(manifest.assembly.filter(r=>r.bom_id===id).length,5);
  }
  assert(!manifest.parts.some(r=>r.name==='thumb_screw'));
  assert.equal(manifest.bom.find(r=>r.id==='clip_string_guide').quantity,1);
  assert.equal(manifest.bom.find(r=>r.id==='clip_string_guide').material,'ELEGOO TPU 95A');
  assert.equal(manifest.bom.find(r=>r.id==='rubber_bands').quantity,5);
  assert.equal(manifest.assembly.filter(r=>r.name.startsWith('guide_')).length,1);
  assert(!manifest.assembly.some(r=>r.name.startsWith('band_guide')));
  assert(!manifest.parts.some(r=>['string_guide','dual_string_guide'].includes(r.name)));
  const mount=await page.evaluate(async()=>await (await fetch('review/fixed-mount.json')).json());
  assert.equal(mount.revision,manifest.revision);
  assert.equal(mount.bracket_mount_seats.locating_lugs,false);
  assert(mount.bracket_mount_seats.former_lug_region_remaining_mm3<1e-6);
  assert.equal(manifest.assembly.filter(x=>x.name.startsWith('rail_screw_')).length,1);
  assert.equal(manifest.assembly.filter(x=>x.name.startsWith('rail_nut_')).length,1);
  assert.equal(manifest.motion.string_points.length,manifest.motion.head_point_count+2);
  const names=manifest.assembly.map(p=>p.name);
  for(const n of ['plunger','pulley','pulley_axle','pulley_key','cuff_fixed','cuff_sliding_1','cuff_sliding_2'])assert(names.includes(n));
  assert.equal(manifest.bom.find(r=>r.id==='phone_cuff').quantity,3);
  assert.equal(manifest.bom.find(r=>r.id==='pulley_key').quantity,1);
  assert.equal(manifest.assembly.filter(r=>r.bom_id==='phone_cuff').length,3);
  assert.equal(manifest.assembly.filter(r=>r.bom_id==='pulley_key').length,1);
  for(const n of ['rocker','pivot_key','pulley_nut'])assert(!names.includes(n));
  await page.locator('[data-view=actuator]').click();
  await page.locator('#stroke').evaluate(e=>{e.value='100';e.dispatchEvent(new Event('input',{bubbles:true}));});
  assert(Math.abs(Number(await canvas.getAttribute('data-plunger-travel'))-.65)<1e-5);
  await page.locator('#release').click();
  await page.waitForTimeout(1500);
  await page.screenshot({path:'/private/tmp/v3-integrated-plunger.png'});
  await page.locator('[data-view=bom]').click();
  // Actual rendered geometry extents must match source mm, not a per-part
  // normalization that makes a small key as large as a jaw.
  const bomSizes=await page.evaluate(async()=>{
   const {STLLoader}=await import('three/addons/loaders/STLLoader.js');
   const {Vector3}=await import('three');const loader=new STLLoader();
   const m=await (await fetch('review/manifest.json')).json(),results=[];
   for(const part of m.parts){
    const geometry=await loader.loadAsync('review/'+part.file);geometry.computeBoundingBox();
    const row=document.querySelector(`tr[data-id="${part.name}"]`);
    results.push({name:part.name,scale:Number(row.dataset.displayScale),shown:JSON.parse(row.dataset.modelSizeMm),source:geometry.boundingBox.getSize(new Vector3()).toArray()});
   }
   return results;
  });
  for(const p of bomSizes){assert.equal(p.scale,1,p.name);p.source.forEach((v,i)=>assert(Math.abs(v-p.shown[i])<.001,p.name));}
  assert(Math.abs(bomSizes.find(p=>p.name==='pulley_axle').source[1]-20.6)<.001);
  assert(Math.abs(bomSizes.find(p=>p.name==='pulley_key').source[1]-3)<.001);
  const labels=page.getByRole('checkbox',{name:'Floating labels'});
  assert(await labels.isVisible());assert(await labels.isChecked());
  await labels.uncheck();assert.equal(await canvas.getAttribute('data-bom-labels'),'false');
  await page.locator('tr[data-id=actuator_bracket]').click();
  await canvas.scrollIntoViewIfNeeded();await page.waitForTimeout(700);
  await canvas.screenshot({path:'/private/tmp/v3-reinforced-bracket.png'});
  await page.locator('#reset').click();assert.equal(await labels.isChecked(),false);
  await page.locator('[data-view=phone]').click();assert.equal(await labels.isVisible(),false);
  await page.locator('[data-view=bom]').click();assert.equal(await labels.isChecked(),false);
  await page.locator('tr[data-id=shaft_cap]').click();
  await canvas.scrollIntoViewIfNeeded();
  await page.locator('#stage .view-cube canvas').press('End');
  await page.waitForTimeout(700);
  await canvas.screenshot({path:'/private/tmp/v3-flush-t-cap.png'});
  await page.locator('tr[data-id=plunger]').click();
  assert.equal(await canvas.getAttribute('data-bom-labels'),'false');
  await canvas.scrollIntoViewIfNeeded();await page.waitForTimeout(700);
  await canvas.screenshot({path:'/private/tmp/v3-bom-labels-off.png'});
  await labels.check();assert.equal(await canvas.getAttribute('data-bom-labels'),'true');
  await canvas.screenshot({path:'/private/tmp/v3-bom-labels-on.png'});
  assert(await page.locator('tr[data-id=pulley]').count());
  assert.equal(await page.evaluate(()=>document.documentElement.scrollWidth>innerWidth),false);
  await page.locator('[data-view=phone]').click();await page.locator('#assembly-toggle').click();
  assert.equal(await page.locator('#assembly-step option').count(),32);
  await page.locator('#assembly-exit').click();
  await page.goto(base+'/versions/v3/viewer.html?sample=large&side=far&revision=deep-groove-pulley-v3');
  await page.locator('#view[data-ready=true]').waitFor({timeout:120000});
  await page.locator('[data-view=actuator]').click();
  await page.locator('#stroke').evaluate(e=>{e.value='100';e.dispatchEvent(new Event('input',{bubbles:true}));});
  assert(Math.abs(Number(await canvas.getAttribute('data-plunger-travel'))-.65)<1e-5);
  await page.goto(base+'/versions/v3/viewer.html?sample=bare&side=near&revision=deep-groove-pulley-v3&focus=cuffs');
  await page.locator('#view[data-ready=true]').waitFor({timeout:120000});
  await page.locator('#phone').uncheck();await page.waitForTimeout(700);
  await page.screenshot({path:require('node:path').resolve(__dirname,'../versions/v3/review/cuffs-integrated.png')});
  await page.locator('#phone').check();await page.waitForTimeout(700);
  await page.screenshot({path:require('node:path').resolve(__dirname,'../versions/v3/review/cuffs-with-phone.png')});
  assert.deepEqual(errors,[]);console.log(JSON.stringify({passed:true,printedPieces:manifest.printed_pieces,errors,screenshot:'/private/tmp/v3-integrated-plunger.png'}));
 } finally {await browser.close();}
})().catch(e=>{console.error(e);process.exit(1)});
