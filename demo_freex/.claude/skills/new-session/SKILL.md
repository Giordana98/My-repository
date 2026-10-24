---
name: new-session
description: Start planning a new free.session_NN. Usage /new-session <NN> <date?> <venue?> <artist?>. Planner builds tasks from session-checklist.
---

# /new-session

1. Create goal `G-n | free.session_NN` via `/goal` (date `assumed` unless Giordana says confirmed).
2. Planner instantiates `session-checklist` backwards from the date into `ops/plan.md` (ids prefixed `S<NN>-`).
3. Missing basics (date, venue, artist, merch) → decisions.md.
4. Reply in Italian: critical path + first decisions.
