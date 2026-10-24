---
name: decide
description: Open Giordana's decision inbox and record her answers. Usage /decide (lists open items) or /decide D-007 a (records an answer). Updates plan and log.
---

# /decide [id answer]

- No args: list open items from `ops/decisions.md` (max 5, ranked), Italian, one line each + recommendation.
- With answer: write `answer: <her words> (AAAA-MM-GG)` in the item, append to `ops/log.md`, mark item closed, run `planner` to apply (flip `conf` to `confirmed` where the answer confirms a fact).
- Also use it to record "sent draft X to Y on DD.MM" and collaborators' answers she reports.
- Approved copy she gives → paste into the relevant `## approved` section and log it in the `voice-giordana` skill.
- If she approves an asset addition, update `design-system/inventory.md` status to `approved`.
