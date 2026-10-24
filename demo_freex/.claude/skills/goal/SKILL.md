---
name: goal
description: Add or change a team goal. Usage /goal <text>. The planner decomposes it into tasks in the shared plan on the next tick.
---

# /goal <text>

1. Append to `ops/goals.md`:
   ```
   ## G-n | <short name> | due DD.MM | conf: assumed|confirmed
   done when: <measurable outcome — ask Giordana in one question if unclear>
   status: active
   ```
   Changing an existing goal: edit in place, log the change in `ops/log.md`.
2. Run `planner` to decompose it into tasks in `ops/plan.md`.
3. Reply in Italian: goal id, done-when, first 3 tasks with owner and date.
