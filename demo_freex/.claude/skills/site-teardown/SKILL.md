---
name: site-teardown
description: Method for reverse-engineering a reference website (structure, grid, typography, interactions, countdown mechanics) without copying code or assets. Used by research.
---

# site teardown

For each site → `research/sites/0N-name.md`:
1. **Why it's here** (1 line) + URL + date visited.
2. **Screens**: `node tools/render.mjs <url> research/sites/img/0N-desktop.png 1440 900` and `… 0N-mobile.png 390 844`.
3. **Structure**: sections in order, navigation model, one page vs pages, states (before/after launch?).
4. **Grid & spacing**: columns, margins, rhythm, alignment (left? centered?).
5. **Typography**: families (from computed styles via Playwright), sizes, case, tracking, mono usage.
6. **Interactions**: countdown logic/format, hover, cursor, scroll behaviour, motion timing, reduced-motion handling.
7. **Tech**: framework hints, weight (KB), performance feel.
8. **Take / avoid** for DEMO_FREEX v1 — mapped to our sections (/intro, /free.artists, /free.pieces, /free.session_01, /apply, footer).

Never copy code, text, images or fonts. Describe, measure, adapt.
`research/sites/summary.md`: the 3 sites in one table + 5 concrete decisions proposed for our site.
