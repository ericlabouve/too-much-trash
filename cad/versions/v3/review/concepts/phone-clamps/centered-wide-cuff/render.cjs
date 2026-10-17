const {chromium}=require(process.env.PLAYWRIGHT_MODULE||'playwright');
const assert=require('node:assert/strict'),path=require('node:path'),fs=require('node:fs');
(async()=>{
 const browser=await chromium.launch({headless:true,executablePath:process.env.CHROME_PATH||'/Applications/Google Chrome.app/Contents/MacOS/Google Chrome',args:['--use-angle=swiftshader']});
 try{
  const page=await browser.newPage({viewport:{width:1540,height:1250}}),errors=[];
  page.on('pageerror',e=>errors.push(e.message));
  await page.goto((process.env.CAD_VIEWER_URL||'http://127.0.0.1:8767')+'/versions/v3/review/concepts/phone-clamps/centered-wide-cuff/');
  await page.waitForFunction(()=>window.reviewReady,null,{timeout:120000});
  const manifests=await page.evaluate(()=>window.conceptReview.manifest.concepts);
  for(const c of manifests)assert.equal(new Set(c.parts.map(p=>p.file)).size,c.parts.length,`${c.id}: distinct placed parts must not overwrite one mesh path`);
  const views=[];
  for(const id of ['A','B','C']){
   await page.evaluate(id=>window.conceptReview.show(id),id);
   assert.equal(await page.locator('body').getAttribute('data-concept'),id);
   const counts=await page.evaluate(()=>window.conceptReview.counts());assert(counts.main>8);assert(counts.detail>3);
   for(const mode of ['assembled','exploded','section']){
    await page.evaluate(mode=>window.conceptReview.setDetail(mode),mode);await page.waitForTimeout(180);
    assert.equal(await page.locator('body').getAttribute('data-detail'),mode);
    await page.locator('#capture').screenshot({path:path.join(__dirname,`${id.toLowerCase()}-${mode}.png`)});views.push([id,mode]);
   }
   await page.locator('#phone').check();await page.waitForTimeout(120);
   await page.locator('#assembly').screenshot({path:path.join(__dirname,`${id.toLowerCase()}-phone.png`)});
   await page.locator('#phone').uncheck();await page.locator('#cap').uncheck();await page.locator('#cap').check();
  }
  const c=manifests.find(c=>c.id==='C');
  assert.equal(c.dimensions.fixed_cuff_width_mm,21.6); assert.equal(c.dimensions.sliding_cuff_width_mm,21.6);
  assert.equal(c.parts.filter(p=>p.group==='key'&&p.name.startsWith('Fixed')).length,0);
  assert.equal(c.parts.filter(p=>p.group==='key'&&p.name.startsWith('Sliding')).length,4);
  await page.evaluate(()=>window.conceptReview.setTarget('sliding'));
  for(const mode of ['assembled','exploded','section']){
   await page.evaluate(mode=>window.conceptReview.setDetail(mode),mode);await page.waitForTimeout(180);
   assert.equal((await page.evaluate(()=>window.conceptReview.counts())).detail,5);
   await page.locator('#capture').screenshot({path:path.join(__dirname,`c-sliding-${mode}.png`)});
  }
  await page.locator('#actuator').uncheck();await page.locator('#actuator').check();
  for(const id of ['assembly','detail']){
   const cube=page.locator(`#${id} .view-cube canvas`);assert.equal(await cube.count(),1);await cube.press('Home');await page.waitForTimeout(100);assert.equal(await cube.getAttribute('data-projection'),'orthographic');
   const initial=await cube.getAttribute('data-direction');const button=page.locator(`#${id} button[aria-label="Rotate right"]`);await button.click();await page.waitForTimeout(100);assert.equal(await cube.getAttribute('data-direction'),initial);
   const b=await button.boundingBox();await page.mouse.move(b.x+b.width/2,b.y+b.height/2);await page.mouse.down();await page.mouse.move(b.x+b.width/2+24,b.y+b.height/2,{steps:6});await page.mouse.up();await page.waitForTimeout(100);assert.notEqual(await cube.getAttribute('data-direction'),initial);
  }
  for(const width of [390,320]){await page.setViewportSize({width,height:950});assert(await page.evaluate(()=>document.documentElement.scrollWidth<=innerWidth));}
  assert.deepEqual(errors,[]);
  const result={passed:true,revision:'common-cuff-21p6-v3',views,sliding_detail_modes:['assembled','exploded','section'],browser_errors:errors,cubes:['assembly','detail'],mobile_widths:[390,320],scope:'Display and controls only; no physical fit or load validation'};
  fs.writeFileSync(path.join(__dirname,'viewer-check.json'),JSON.stringify(result,null,2)+'\n');console.log(JSON.stringify(result));
 }finally{await browser.close();}
})().catch(e=>{console.error(e);process.exit(1)});
