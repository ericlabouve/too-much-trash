const {chromium}=require(process.env.PLAYWRIGHT_MODULE||'playwright');
const fs=require('node:fs'),path=require('node:path'),assert=require('node:assert/strict');
(async()=>{
 const browser=await chromium.launch({headless:true,executablePath:process.env.CHROME_PATH||'/Applications/Google Chrome.app/Contents/MacOS/Google Chrome',args:['--use-angle=swiftshader']});
 try{
  const page=await browser.newPage({viewport:{width:1500,height:1150},deviceScaleFactor:1}),errors=[];page.on('pageerror',e=>errors.push(e.message));
  await page.goto((process.env.CAD_VIEWER_URL||'http://127.0.0.1:8767')+'/versions/v3/review/concepts/phone-clamps/rounded-cuff/');
  await page.waitForFunction(()=>window.reviewReady,{timeout:120000});
  const audits=[];
  for(const reverse of [false,true]){
   await page.locator('#reverse').setChecked(reverse);
   const a=await page.evaluate(()=>window.cuffReview.audit());assert.deepEqual(a.hits,{screen:[],camera:[]});assert(a.screen_margin_measured_mm>=.75);audits.push(a);
  }
  await page.locator('#reverse').uncheck();
  const keyAudit=await page.evaluate(()=>window.cuffReview.keyAudit());assert.equal(keyAudit.violations,0);assert(keyAudit.minimum_slot_clearance_mm>.19);assert(Math.abs(keyAudit.key_thickness_mm-3)<.001);assert(Math.abs(keyAudit.key_head_width_mm-7)<.001);
  assert(keyAudit.max_cavity_encroachment_mm<.001);assert.equal(keyAudit.cavity_ray_samples,707);assert.equal(keyAudit.side_keeper,false);assert(keyAudit.key_phone_gap_mm>2.9);
  const retentionAudit=await page.evaluate(()=>window.cuffReview.retentionAudit());
  assert(retentionAudit.valid_single_solid);assert.equal(retentionAudit.max_axle_overlap_mm3,0);assert.equal(retentionAudit.bracket_overlap_mm3,0);assert(retentionAudit.axle_withdrawal_obstruction_at_0_5mm_mm3>0);
  assert.equal(retentionAudit.second_key,false);assert.equal(retentionAudit.cuff_positive_pullout_lock,false);assert.equal(retentionAudit.key_mm.head_axial_depth,1.2);
  const fitAudit=await page.evaluate(()=>window.cuffReview.fitAudit());
  assert.equal(fitAudit.second_key,false);assert.equal(fitAudit.key_geometry_changed_from_shared_candidate,false);
  assert.equal(fitAudit.socket.rib_count,0);assert.equal(fitAudit.socket.clear_passage_mm,3.4);assert.equal(fitAudit.socket.positive_axial_latch,false);
  assert.equal(fitAudit.socket.nominal_clearance_per_side_mm,.2);
  assert.equal(fitAudit.cuff_scale,1.2);assert.equal(fitAudit.back_wall_behind_head_mm,1.7);
  assert.equal(keyAudit.cuff_width_mm,12);assert(Math.abs(keyAudit.key_length_mm-12.2)<.001);
  assert.equal(fitAudit.seated_intentional_rib_overlap_mm3,0);
  assert.equal(fitAudit.non_rib_insertion_overlap_mm3,0);assert.equal(fitAudit.key_cuff_overlap_mm3,0);
  for(const p of Object.values(fitAudit.parts))assert(p.valid_single_solid);
  for(const view of ['iso','front','back']){
   await page.locator(`[data-view=${view}]`).click();await page.waitForTimeout(150);
   await page.locator('#capture').screenshot({path:path.join(__dirname,view+'.png')});
  }
  await page.locator('#detail-mode').selectOption('3d');await page.locator('#detail').screenshot({path:path.join(__dirname,'contact-3d.png')});
  await page.locator('#detail-mode').selectOption('insert');await page.locator('#detail').screenshot({path:path.join(__dirname,'insert-3d.png')});
  for(const view of ['locked','retention','pin','open','exploded','key','crosskey','section','socket']){
   await page.locator('#detail-mode').selectOption(view);await page.waitForTimeout(120);
   await page.locator('#detail').screenshot({path:path.join(__dirname,'keeper-'+view+'.png')});
   assert((await page.locator('#detail-note').innerText()).length>30);
  }
  const cubeChecks=[];
  for(const id of ['assembly','detail']){
   const cube=page.locator(`#${id} .view-cube canvas`),other=page.locator(`#${id==='assembly'?'detail':'assembly'} .view-cube canvas`);
   assert.equal(await cube.count(),1);const untouched=await other.getAttribute('data-direction');
   const direction=()=>cube.getAttribute('data-direction');
   const snap=async key=>{await cube.focus();await cube.press(key);await page.waitForTimeout(80);};
   await snap('Home');assert.equal(await cube.getAttribute('data-projection'),'orthographic');
   const front=await direction();await cube.hover();await page.waitForTimeout(120);assert.equal(await direction(),front);
   await cube.click({position:{x:56,y:56}});assert.equal(await direction(),front);
   await cube.click({position:{x:79,y:56}});await page.waitForTimeout(80);let d=(await direction()).split(',').map(Number);assert(d[0]>.6&&d[2]>.6&&Math.abs(d[1])<.01,'edge snap');
   await snap('Home');await cube.click({position:{x:79,y:33}});await page.waitForTimeout(80);d=(await direction()).split(',').map(Number);assert(d.every(v=>v>.5),'corner snap');
   const arrow=page.locator(`#${id} .view-cube button[aria-label="Rotate right"]`),before=await direction();
   await arrow.hover();await page.waitForTimeout(100);await arrow.click();assert.equal(await direction(),before,'arrow hover/click must not rotate');
   let b=await arrow.boundingBox();await page.mouse.move(b.x+b.width/2,b.y+b.height/2);await page.mouse.down();await page.mouse.move(b.x+b.width/2+25,b.y+b.height/2,{steps:8});await page.mouse.up();await page.waitForTimeout(80);assert.notEqual(await direction(),before,'arrow drag rotates');
   const afterArrow=await direction();b=await cube.boundingBox();await page.mouse.move(b.x+56,b.y+56);await page.mouse.down();await page.mouse.move(b.x+72,b.y+67,{steps:8});await page.mouse.up();await page.waitForTimeout(80);assert.notEqual(await direction(),afterArrow,'cube drag rotates');
   await page.locator(`#${id} .view-cube button`).filter({hasText:'Orthographic'}).click();
   await page.waitForFunction(pane=>document.querySelector(`#${pane} .view-cube canvas`).dataset.projection==='perspective',id,{timeout:10000});
   assert.equal(await cube.getAttribute('data-projection'),'perspective');
   assert.equal(await other.getAttribute('data-direction'),untouched,'cube affects only its own pane');
   cubeChecks.push({pane:id,passed:true,checks:['face/edge/corner snap','keyboard snap','hover inert','arrow click inert','arrow drag','cube drag','projection toggle','independent panes']});
  }
  await page.locator('#phone').uncheck();await page.locator('#phone').check();await page.locator('#keepouts').uncheck();await page.locator('#keepouts').check();
  for(const width of [390,320]){await page.setViewportSize({width,height:950});assert(await page.evaluate(()=>document.documentElement.scrollWidth<=innerWidth));for(const id of ['assembly','detail']){const b=await page.locator(`#${id} .view-cube`).boundingBox();assert(b.x>=0&&b.x+b.width<=width);}}
  assert.deepEqual(errors,[]);
  fs.writeFileSync(path.join(__dirname,'review.json'),JSON.stringify({date:'2026-10-16',revision:'enlarged-cuff-v1',passed:true,audits,keyAudit,retentionAudit,fitAudit,cubeChecks,browser_errors:errors,views_tested:['iso','front','back','section','3d','insert','locked','retention','pin','open','exploded','key','crosskey','socket'],mobile_widths:[390,320],scope:'Viewer, illustrative keepouts, C profile, direct key insertion and actuator slot/obstruction; friction ribs removed for clearance fit, NOT a pull-out lock; NOT TPU strength, key drift, manufacturing or optical validation'},null,2)+'\n');
  console.log(JSON.stringify({passed:true,keyAudit,retentionAudit,cubeChecks,errors}));
 }finally{await browser.close();}
})().catch(e=>{console.error(e);process.exit(1)});
