const {chromium}=require(process.env.PLAYWRIGHT_MODULE||'playwright');
const assert=require('node:assert/strict'),fs=require('node:fs'),path=require('node:path');
(async()=>{
 const browser=await chromium.launch({headless:true,executablePath:'/Applications/Google Chrome.app/Contents/MacOS/Google Chrome',args:['--use-angle=swiftshader']});
 try{
  const page=await browser.newPage({viewport:{width:1500,height:1250}}),errors=[];
  page.on('pageerror',e=>errors.push(e.message));
  await page.goto('http://127.0.0.1:8767/versions/v3/review/concepts/phone-clamps/centered-wide-cuff/fixed-retention.html');
  await page.waitForFunction(()=>window.reviewReady,null,{timeout:120000});
  const results=[];
  for(const mode of ['assembled','exploded','section']){
   await page.selectOption('#mode',mode);await page.waitForFunction(()=>window.reviewReady);await page.waitForTimeout(180);
   assert.equal(await page.locator('body').getAttribute('data-mode'),mode);
   const counts=await page.evaluate(()=>window.retentionReview.counts());assert.equal(counts.stud,4);assert.equal(counts.short,6);
   await page.locator('#capture').screenshot({path:path.join(__dirname,`fixed-retention-${mode}.png`)});results.push(mode);
  }
  await page.locator('#whole').check();await page.waitForFunction(()=>window.reviewReady);await page.waitForTimeout(180);
  assert(await page.locator('#mode').isDisabled());await page.locator('#capture').screenshot({path:path.join(__dirname,'fixed-retention-assemblies.png')});
  await page.locator('#whole').uncheck();await page.waitForFunction(()=>window.reviewReady);
  for(const control of ['neck','cuff']){await page.locator('#'+control).uncheck();await page.waitForFunction(()=>window.reviewReady);await page.locator('#'+control).check();await page.waitForFunction(()=>window.reviewReady);}
  await page.evaluate(()=>window.retentionReview.show());await page.waitForTimeout(180);
  for(const id of ['stud','short']){
   const cube=page.locator(`#${id} .view-cube canvas`);assert.equal(await cube.count(),1);await cube.press('Home');await page.waitForTimeout(180);assert.equal(await cube.getAttribute('data-projection'),'orthographic',id);
  }
  for(const width of [390,320]){await page.setViewportSize({width,height:950});assert(await page.evaluate(()=>document.documentElement.scrollWidth<=innerWidth));}
  assert.deepEqual(errors,[]);const result={passed:true,revision:'fixed-retention-pair-v1',modes:results,full_assembly:true,cubes:2,mobile_widths:[390,320],browser_errors:errors};
  fs.writeFileSync(path.join(__dirname,'fixed-retention-viewer-check.json'),JSON.stringify(result,null,2)+'\n');console.log(JSON.stringify(result));
 }finally{await browser.close();}
})().catch(e=>{console.error(e);process.exit(1)});
