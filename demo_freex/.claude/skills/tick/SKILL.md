---
name: tick
description: One iteration of the DEMO_FREEX team loop (run as `/loop /tick` or by the daily scheduled task). Reads goals/plan/board, dispatches agents in background, runs reviewer, updates plan/board/health, schedules next check-ins, escalates only what Giordana must decide.
---

# /tick — regia loop iteration

You are the **regia** (main session). Subagents can't call each other: you dispatch.

1. **Read** `ops/goals.md`, `ops/plan.md`, `ops/board.md`, `ops/health.md`, `ops/schedule.md`.
2. **Plan**: launch `planner` (foreground) — it applies new facts, decomposes goals, re-plans.
3. **Dispatch**: for each `todo` task that is unblocked and owned by an agent (and each `[open]` board item to an agent), launch that agent with the Agent tool, `run_in_background: true`, **in parallel** (one message, many calls). Prompt = task id + board line + "follow your operating rules". Max 1 run per agent per tick (batch its items).
4. **Review**: when outputs land, launch `reviewer` on the changed paths. FAIL → task back to `todo` for the author with the reasons.
5. **Update**: planner closes board items, updates plan statuses, appends `log.md`.
6. **Health** → write `ops/health.md`:
   ```
   AAAA-MM-GG HH:MM | light: green|yellow|red
   overdue: … | stuck handoffs (>1 tick): … | goals off-pace: … | scheduled tasks failed: … | reviewer recurring: … | loop last run: …
   ```
   red = a critical-path due date within 72h at risk · critical path blocked · scheduled task failed twice · loop silent > 24h.
7. **Schedule**: ensure planner check-ins exist for upcoming critical dates (`ops/schedule.md` = truth; cloud: `list_triggers` to verify last runs).
8. **Escalate**:
   - red → notify Giordana now (PushNotification if available; otherwise top of the reply), Italian, ≤4 lines: what, why now, what it blocks, options + recommendation, answer by.
   - yellow → stays for Monday `/punto`.
   - green → silent.
9. **Pace** (when in /loop): open work → next tick in 20–30 min; only waiting on people → 2–4 h; 23:00–07:00 Europe/Zurich → wake at 07:30.

Commit after each tick that changed files: `git add -A && git commit -m "tick AAAA-MM-GG HH:MM: <1-line summary>"` and push to the default branch if a remote exists.
Never: publish, send, pay, deploy, edit `docs/`.
