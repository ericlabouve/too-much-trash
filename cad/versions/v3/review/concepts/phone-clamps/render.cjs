// Render the real Three.js scenes, and smoke-test the selector and controls.
// PLAYWRIGHT_MODULE and CHROME_PATH may override machine-local dependencies.
const {chromium}=require(process.env.PLAYWRIGHT_MODULE||'playwright');
const path=require('node:path');
const assert=require('node:assert/strict');
(async()=>{
 const browser=await chromium.launch({headless:true,executablePath:process.env.CHROME_PATH||'/Applications/Google Chrome.app/Contents/MacOS/Google Chrome',args:['--use-angle=swiftshader']});
 try {
  const page=await browser.newPage({viewport:{width:1440,height:1120},deviceScaleFactor:1});const errors=[];page.on('pageerror',e=>errors.push(e.message));
  await page.goto((process.env.CAD_VIEWER_URL||'http://127.0.0.1:8767')+'/versions/v3/review/concepts/phone-clamps/');await page.waitForFunction(()=>window.reviewReady==='A',{timeout:120000});
  for(const key of ['A','B','C','D','E']){
   await page.locator(`[data-concept=${key}]`).click();await page.waitForFunction(k=>window.reviewReady===k,key);await page.evaluate(()=>window.conceptReview.render());await page.waitForTimeout(200);
   await page.locator('#capture').screenshot({path:path.join(__dirname,`concept-${key.toLowerCase()}-3d.png`)});
   assert.equal(await page.locator(`[data-concept=${key}]`).getAttribute('aria-pressed'),'true');
  }
  await page.locator('#phone').uncheck();await page.locator('#phone').check();await page.locator('#front').click();await page.locator('#back').click();
  await page.setViewportSize({width:390,height:850});await page.locator('[data-concept=A]').click();assert(await page.evaluate(()=>document.documentElement.scrollWidth<=innerWidth));
  assert.deepEqual(errors,[]);console.log(JSON.stringify({concepts:5,images:5,js_errors:errors,mobile_overflow:false,controls:'passed'},null,2));
 } finally {await browser.close();}
})().catch(e=>{console.error(e);process.exit(1);});
