# DEMO_FREEX — components

Three levels, never mixed: **name** (P02 logo) · **information** (Space Mono) · **status** (eyelet row). Ink drawing = "inside", never on the same level as the logo.

## logo (name level)
- Files: `marta/logo/SVG/` (use SVG digitally, PNG fallback). `_B` on light, `_W` on dark. Never recolour, stretch, outline or rebuild.
- Variants: `Line` (horizontal), `Stacked`, `Monogram` ("df"), `+Type` (with text block).
- Clear space and minimum size: **not defined by Marta** → `[ASK: Marta]`. Until then: clear space ≥ height of one eyelet of the logo.
- The name DEMO_FREEX is set **only** with the logo; in running text write `DEMO_FREEX` in Space Mono.

## information (Space Mono)
- Lowercase by default for social; poster blocks follow the approved poster copy verbatim.
- Left aligned. Separator `——`. Sizes from `tokens.css`.

## status indicator
- 11 eyelets = 11 tracks. `○○●○○○○○○○○` = track 3 of 11. Set in Space Mono.
- Used for: site sections (each section a track), playlist position, post series numbering.

## ink drawing (inside level)
- Source: `disegni/illustrazione_china_scan.pdf` (low-res in this light folder — originals with Giordana; ≥600 dpi needed for print).
- Use as full-bleed texture of a frame, or as a crop (crop saved in `design/crops/`, added to inventory as `proposed`). Never redrawn, never vectorised by us, never combined with the logo at the same visual weight.

## formats
| format | size px | use |
|---|---|---|
| post | 1080×1350 (3:4) | feed |
| story | 1080×1920 (9:16) | stories |
| poster digital | 1080×1350 / 1080×1920 | save the date, info poster |
| poster print A3 | — | **Marta** (print files) |

## templates (first ones)
- `first-post`: `--black-absolute` background, logo `Line_W` or `Stacked_W` centred-left, one line in Space Mono with the date `[DATE TBC]` until confirmed. Nothing else.
- `save-the-date`: rec countdown `GG:OO:MM:SS ●rec`, no venue, no artist (decision 15.09), QR → registration `[ASK: link]`.
- `info-poster`: approved poster copy, structure A (DEMO_FREEX opening, free.session_01, brand block closing).
