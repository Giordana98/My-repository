// Render an HTML file or URL to PNG with Playwright.
//   node tools/render.mjs <file.html|url> <out.png> [width=1080] [height=1350]
// Post 1080×1350 · story 1080×1920 · site checks 390×844 and 1440×900.
import { createRequire } from 'node:module';
import { pathToFileURL } from 'node:url';
import { resolve } from 'node:path';

const require = createRequire(import.meta.url);
const { chromium } = require('playwright');

const [src, out, w = '1080', h = '1350'] = process.argv.slice(2);
if (!src || !out) {
  console.error('usage: node tools/render.mjs <file.html|url> <out.png> [width] [height]');
  process.exit(1);
}
const url = /^https?:\/\//.test(src) ? src : pathToFileURL(resolve(src)).href;

const browser = await chromium.launch();
const page = await browser.newPage({ viewport: { width: +w, height: +h } });
await page.goto(url, { waitUntil: 'networkidle' });
await page.evaluate(() => document.fonts.ready);
await page.screenshot({ path: out });
await browser.close();
console.log(out);
