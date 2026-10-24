# ops/ — team operating protocol

Shared state of the DEMO_FREEX agent team. Agents start with no memory: **everything lives in these files**.
Internal language: English. To Giordana: Italian, short.

## Files and owners

| file | what | owner (writes) | everyone else |
|---|---|---|---|
| `goals.md` | outcomes with "done when" + deadline | Giordana (via `/goal`), planner decomposes | read |
| `plan.md` | **the shared plan**: milestones, tasks, owners, deps, dates, status, confidence | planner (agents only flip status of their own tasks) | read first, always |
| `board.md` | handoffs between agents | anyone appends; receiver updates status | read your inbox |
| `decisions.md` | Giordana's inbox: questions only she can answer | planner (others route via board) | read |
| `log.md` | append-only: date, change, impact, decision | planner + `/decide` + `/change` | read |
| `risks.md` | open risks, owner, mitigation | planner | read |
| `health.md` | traffic light, written every tick | tick (regia) | read |
| `schedule.md` | every automatic scheduled task/check-in that exists | planner / tick | read |
| `contacts.md` | who is who, channel, language | planner (only facts from docs or Giordana) | read |
| `docs-proposals.md` | proposed edits to `docs/` / `CLAUDE.md` | anyone | Giordana approves |
| `drafts/` | messages to collaborators — **never sent by agents** | planner | reviewer checks |

`docs/` and `CLAUDE.md` belong to Giordana. Agents never edit them: they propose in `docs-proposals.md`.

## Task line (plan.md)

```
- [status] T-012 | owner | task | due DD.MM | deps T-003,T-004 | conf | out: path
```
- status: `todo` `doing` `review` `done` `blocked`
- owner: `planner` `social` `design` `research` `site` `reviewer` `giordana` `marta` `felah` `bumma` `printer`
- conf (confidence of the date/fact): `confirmed` (an answer is recorded in log.md) · `proposed` (we asked / will ask) · `assumed` (internal hypothesis)
- Nothing that depends on an external person becomes `confirmed` without a recorded answer (`/decide`).

## Board message (board.md)

```
[open] from → to | subject | in: path | due: DD.MM | note
```
Lifecycle: `[open]` → `[doing]` → `[done] → out: path` or `[blocked] reason`.
Special receivers: `→ giordana` (planner moves it into decisions.md), `→ reviewer`.
Missing info: `[ASK: …]` → to planner. Then move on to the next task; don't stall.

## Tick (one loop iteration, see `/tick`)
read goals/plan/board → decompose → dispatch unblocked tasks in parallel (background) → reviewer on every output → update plan/board/log/health → schedule next check-ins → escalate only "always Giordana" items.

## Always Giordana (never decided by agents)
final copy · dates, money, quantities, prices · people and any outbound message · publishing or anything irreversible · facts not in the folder · edits to docs/ · additions to `design-system/inventory.md`.

## Report format (every agent, every run)
max 5 bullets: `done:` · `out:` (paths) · `blocked:` · `next:` · `ask:`. No preamble.
