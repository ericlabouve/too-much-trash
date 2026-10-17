const assert = require('node:assert/strict');
const {chromium} = require(process.env.PLAYWRIGHT_MODULE || 'playwright');
(async () => {
 const browser = await chromium.launch({headless:true, executablePath:process.env.CHROME_PATH, args:['--use-angle=swiftshader']});
 try {
  const page = await browser.newPage({viewport:{width:1450,height:1100}}), errors=[];
  page.on('pageerror', e=>errors.push(e.message));
  const job=process.env.CAD_SLICE_JOB || '2026-10-14-actuator';
  await page.goto((process.env.CAD_VIEWER_URL || 'http://127.0.0.1:8767')+'/versions/v3/print/jobs/'+job+'/');
  const canvas=page.locator('#view');await page.locator('#view[data-ready=true]').waitFor({timeout:120000});
  assert.equal(await page.locator('#parts tr').count(),7);
  assert.equal(await page.locator('#focus option').count(),8);
  const report=await page.evaluate(async()=>await (await fetch('review.json')).json());
  const summary=await page.locator('#summary').innerText();
  assert.ok(summary.includes(report.total_g.toFixed(2)+' g'));
  assert.ok(summary.includes(((report.deposited_g_by_role.support||0)+(report.deposited_g_by_role.interface||0)).toFixed(2)+' g'));
  if(job==='2026-10-14-actuator'){assert.match(summary,/14.15 g/);assert.match(summary,/0.81 g/)}
  if(job==='2026-10-14-actuator-bridge'){
   const comparison=await page.evaluate(async()=>await (await fetch('comparison.json')).json());
   assert.equal(comparison.geometry_placement_orientation_profiles_unchanged,true);
   assert.equal(comparison.bridge_paths_identical_to_supported_slice,true);
   assert.deepEqual(comparison.slot_roof_bridge_heights_mm,[18.56]);
   assert.equal(report.objects.pulley_axle.support_z_mm,null);
   for(const [name,part] of Object.entries(report.objects))if(name!=='actuator_bracket')assert.equal(part.support_z_mm,null,name);
   await page.locator('img[src="axle-bridge.png"]').scrollIntoViewIfNeeded();
   assert(await page.locator('img[src="axle-bridge.png"]').evaluate(e=>e.complete&&e.naturalWidth>0));
  }
  await page.locator('#focus').selectOption('actuator_bracket');
  await canvas.scrollIntoViewIfNeeded();await page.waitForTimeout(1000);
  await canvas.screenshot({path:'/private/tmp/tmt-actuator-support-3d.png'});
  await page.locator('#layer').evaluate(e=>{e.value=50;e.dispatchEvent(new Event('input',{bubbles:true}));});
  assert.equal(await canvas.getAttribute('data-layer'),'50');
  await page.locator('#single').check();await page.locator('#top').click();
  await page.waitForTimeout(300);await canvas.screenshot({path:'/private/tmp/tmt-actuator-support-layer.png'});
  await page.locator('#all').click();assert.equal(await page.locator('#single').isChecked(),false);
  await page.locator('#focus').selectOption('all');await page.locator('#iso').click();
  await page.locator('#model').uncheck();await page.locator('#model').check();
  assert.equal(await page.locator('#error').innerText(),'');
  assert.equal(await page.evaluate(()=>document.documentElement.scrollWidth>innerWidth),false);
  await page.screenshot({path:'/private/tmp/tmt-actuator-slice-report.png',fullPage:true});
  assert.deepEqual(errors,[]);console.log(JSON.stringify({passed:true,errors}));
 }finally{await browser.close()}
})().catch(e=>{console.error(e);process.exit(1)});
