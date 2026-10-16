const assert=require('node:assert/strict');
const {chromium}=require(process.env.PLAYWRIGHT_MODULE||'playwright');
(async()=>{
 const browser=await chromium.launch({headless:true,executablePath:process.env.CHROME_PATH,args:['--use-angle=swiftshader']});
 try{
  const page=await browser.newPage({viewport:{width:1450,height:1000}}),errors=[];
  page.on('pageerror',e=>errors.push(e.message));
  await page.goto(process.env.CAD_SLICE_REVIEW_URL||'http://127.0.0.1:8767/versions/v3/review/slice-viewer-example/');
  const canvas=page.locator('#view');await page.locator('#view[data-ready=true]').waitFor({timeout:120000});
  const data=await page.evaluate(async()=>await(await fetch('paths.json')).json());
  const names=Object.keys(data.objects);
  assert.equal(await page.locator('#parts tr').count(),names.length);
  assert.equal(await page.locator('#focus option').count(),names.length+1);
  await page.locator('#focus').selectOption(names[0]);assert.equal(await canvas.getAttribute('data-focus'),names[0]);
  const layer=Math.min(50,data.heights.length-1);
  await page.locator('#layer').evaluate((e,v)=>{e.value=v;e.dispatchEvent(new Event('input',{bubbles:true}))},layer);
  assert.equal(await canvas.getAttribute('data-layer'),String(layer));
  await page.locator('#single').check();assert.equal(await canvas.getAttribute('data-single'),'true');
  await page.locator('#top').click();assert.equal(await canvas.getAttribute('data-direction'),'top');
  await page.locator('#model').uncheck();assert.equal(await canvas.getAttribute('data-model'),'false');
  await page.locator('#support').uncheck();assert.equal(await canvas.getAttribute('data-support'),'false');
  await page.locator('#support').check();await page.locator('#model').check();await page.locator('#all').click();await page.locator('#iso').click();
  assert.equal(await page.locator('#single').isChecked(),false);
  await canvas.screenshot({path:'/private/tmp/tmt-shared-slice-viewer.png'});
  for(const width of [1450,390,320]){await page.setViewportSize({width,height:900});await page.waitForTimeout(100);assert.equal(await page.evaluate(()=>document.documentElement.scrollWidth>innerWidth),false,`Overflow at ${width}`)}
  assert.equal(await page.locator('#error').innerText(),'');assert.deepEqual(errors,[]);
  console.log(JSON.stringify({passed:true,pieces:names.length,layers:data.heights.length,errors}));
 }finally{await browser.close()}
})().catch(e=>{console.error(e);process.exit(1)});
