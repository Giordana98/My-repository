---
name: change
description: Something changed (delay, new info, new date, a collaborator's answer). Usage /change <what>. Planner re-plans, shows downstream impact and options; never touches docs/.
---

# /change <what>

1. Append to `ops/log.md`: `AAAA-MM-GG | change: <what> | source: Giordana`.
2. Run `planner` with the change: recompute affected tasks downstream, list what slips and by how much, update `conf` (a collaborator's answer reported by Giordana counts as recorded → `confirmed`).
3. If a choice is needed, planner writes it into `ops/decisions.md` with options + recommendation.
4. If `docs/` or `CLAUDE.md` became outdated, add a proposal to `ops/docs-proposals.md` (don't edit them).
5. Reply in Italian: impact in ≤5 lines + any decision needed.
