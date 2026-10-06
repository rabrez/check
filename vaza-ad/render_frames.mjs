import { chromium } from '/opt/node22/lib/node_modules/playwright/index.mjs';
import fs from 'fs';
const [,, htmlPath, outDir, fpsArg, durArg, ripplesJson, previewTimes] = process.argv;
const fps = +fpsArg, dur = +durArg;
fs.mkdirSync(outDir, { recursive: true });
const browser = await chromium.launch();
const page = await browser.newPage({ viewport: { width: 1080, height: 1920 }, deviceScaleFactor: 1 });
await page.goto('file://' + htmlPath);
await page.evaluate(() => document.fonts.ready);
if (ripplesJson) await page.evaluate(r => window.setRipples(r), JSON.parse(ripplesJson));
if (previewTimes) {
  for (const t of previewTimes.split(',').map(Number)) {
    await page.evaluate(t => window.render(t), t);
    await page.screenshot({ path: `${outDir}/preview_${t.toFixed(2)}.png`, omitBackground: true });
  }
} else {
  const n = Math.round(fps * dur);
  for (let i = 0; i < n; i++) {
    await page.evaluate(t => window.render(t), i / fps);
    await page.screenshot({ path: `${outDir}/f_${String(i).padStart(4,'0')}.png`, omitBackground: true });
  }
}
await browser.close();
