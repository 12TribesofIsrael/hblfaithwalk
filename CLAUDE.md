# hblfaithwalk — workspace root

This directory is a **multi-repo VS Code workspace**, not itself a git repo. It's the umbrella for Thomas's faith-tech work under the **AI Bible Gospels** brand. Each child folder is an independent git repo with its own `CLAUDE.md` — read the relevant one before doing repo-specific work. This file is the orientation map across them.

Opened via [hblfaithwalk.code-workspace](hblfaithwalk.code-workspace).

## Brand hierarchy

- **AI Bible Gospels** — parent faith-tech brand. Live at [aibiblegospels.com](https://aibiblegospels.com) (Vercel, in production since ~Apr 22, 2026). YouTube channel + parent site.
- **Two flagships, both currently live** under AI Bible Gospels:
  - **Faith Walk Live** — supporter-built companion to Minister Zay's 3,000-mile Philly → Cali walk. **NOT official HMBL.** Lives at [faithwalklive.com](https://faithwalklive.com).
  - **Anointed** — paste-script-to-cinematic-video platform for ministers and creators. Lives at [anointed.app](https://anointed.app). Added as second flagship 2026-04-29. *No repo for it in this workspace as of 2026-05-11 — it's surfaced on aibiblegospels.com but the codebase lives elsewhere.*
- **HMBL consulting (ZayAutomations)** — client engagement for Isaiah M. "Minister Zay" Thomas (HMBL Clothing). Source of truth for the walk tracker lives here.
- **Faith Walk book** — private memoir project. Read-only mirror of source material from the consulting repo.

Distinct people: **Thomas / Tommy** = the user/operator. **Minister Zay / Isaiah M. Thomas** = the client. Same last name, not the same person.

**Note on Born Made Bosses / Technology Gurus LLC:** earlier brand-stack umbrella references have been scrubbed in favor of "the brand is AI Bible Gospels only" (`aibiblegospelscom` commit `df9a44f`, 2026-04-22). Decommissioned LLC framing should not be reintroduced in public copy.

## Repos in this workspace

| Folder | Role | Visibility | Authoritative doc |
|---|---|---|---|
| [AIconsultantforHmblzayy/](AIconsultantforHmblzayy/) | HMBL client consulting. Owns `checkpoints.json` (Faith Walk source of truth), tracker scripts, Twitch clipper/chatbot, distribution playbooks, daily X poster, HARO press lane. | Public (12TribesofIsrael/AIconsultantforHmblzayy) | [AIconsultantforHmblzayy/CLAUDE.md](AIconsultantforHmblzayy/CLAUDE.md) |
| [faithwalklivecom/](faithwalklivecom/) | Live site at faithwalklive.com (Next.js 16, Vercel). Public face of the walk — map, clips archive, prayer routing, /press, /updates/april-28-incident. Mirrors `checkpoints.json` from the consulting repo on every tracker push. | Public (12TribesofIsrael/faithwalklive) | [faithwalklivecom/CLAUDE.md](faithwalklivecom/CLAUDE.md) |
| [aibiblegospelscom/](aibiblegospelscom/) | **Live parent-brand site at [aibiblegospels.com](https://aibiblegospels.com)** (Next.js 16, Vercel, in production since ~Apr 22 2026). Surfaces both flagships (Faith Walk Live + Anointed), TikTok funnel ("Welcome, remnant"), `/connect/tiktok` OAuth, `/privacy`, `/terms`. In TikTok app review. | Public, live | [aibiblegospelscom/CLAUDE.md](aibiblegospelscom/CLAUDE.md) |
| [faithwalkbook/](faithwalkbook/) | Private book project. `source-material/` is a read-only sync target from the consulting repo. | **PRIVATE** | [faithwalkbook/CLAUDE.md](faithwalkbook/CLAUDE.md) |
| [claude-memory-backup/](claude-memory-backup/) | Cross-machine sync for Claude Code per-project auto-memory, normalized by repo folder name (so desktop and laptop share memory regardless of path). | Public | [claude-memory-backup/README.md](claude-memory-backup/README.md) |

## Cross-repo data flow

```
                 AIconsultantforHmblzayy (consulting — source of truth)
                          │
        checkpoints.json  │  book/source-material/*.md
                          │
        ┌─────────────────┼─────────────────────┐
        ▼                 ▼                     ▼
  faithwalklivecom   faithwalklivecom      faithwalkbook
  src/data/          (Vercel rebuild       source-material/
  checkpoints.json   on every push)        (read-only here)
```

- **Tracker pipeline:** `tracker:from-title` / `tracker:update` in the consulting repo write `checkpoints.json`, then auto-mirror to `../faithwalklivecom/src/data/checkpoints.json`, commit, push — Vercel rebuilds. One command, two pushes, ~1 min build.
- **Book sync:** `npm run book:sync` in the consulting repo mirrors `book/source-material/` → `../faithwalkbook/source-material/`. **Never hand-edit inside `faithwalkbook/source-material/`** — it gets overwritten.
- **Memory sync:** desktop and laptop share per-project Claude memory via `claude-memory-backup` (separate from the standalone `.claude/memory/` system in the consulting repo).

## Sibling repo OUTSIDE this workspace — `C:\Users\Claude\youtubeoptermizer`

Owned by a different Claude instance. Has live API creds for **YouTube Data v3, Meta Graph (FB+IG), X v2, TikTok, Anthropic Claude API** plus ~30 Python scripts. From any repo in this workspace:

1. **Never edit, commit, or push there.** Reading files for context is fine.
2. **Ask Thomas before every API call or script run.** Each invocation needs its own ack — no piggybacking on prior approvals. Default-deny on calls, default-allow on reading.

State the option in plain language (script name + endpoint), wait for go. Same posture as `faithwalkbook` re: editing.

## Workspace-wide rules (also live in `~/.claude/CLAUDE.md`)

These apply to **every** repo in this workspace. Per-repo CLAUDE.md may add more — never less.

1. **Verse source.** All scripture is read verbatim from `AIconsultantforHmblzayy/docs/1611KjvW_apocrypha.pdf` via `pdftotext`. Never quote from training-data memory. Daily X poster + book chapters + site copy all enforce this.
2. **Character depiction (AI Bible Gospels image/video prompts).** Biblical figures must be specified as melanated Black/African American — "dark-brown to deep-brown skinned," "wool-textured / coiled hair," "NO Caucasian, European, or light-skinned depictions." Inject into every Kling/Runway/Sora/DALL-E/Midjourney/FLUX prompt without asking.
3. **Public-copy-safety.** No vehicle / hospital / accident-spot specifics about Day 34 (Apr 28 2026 incident) on `faithwalklivecom` or the public consulting tracker. Only `faithwalkbook` source material carries those. Public copy says "accident on the route." Refuse if asked to add more publicly.
4. **Voice: testimony, not tech.** Faith-first across all public-facing copy on `faithwalklive.com` and `aibiblegospels.com`. No "AI-powered / revolutionize / disrupt" language. Plain, short sentences. No em-dash piling. No "as an AI" hedging.
5. **Never go negative on HMBL publicly.** Not in copy, not in commits, not in comments. The consulting repo is Zay's; the book repo can name friction privately; public sites credit and route.
6. **Research protocol — 4-agent ROI check.** Before any substantive new tactic/tool/concept, ask *"Want me to run the 4-agent ROI check?"* If yes, spin up 4 parallel sub-agents (Reddit, YouTube, X, case-study blogs), each answering the same 5 questions. Deliver 4 separate reports + ship/reframe/skip recommendation. Best practices ≠ ROI. Full spec in [AIconsultantforHmblzayy/CLAUDE.md](AIconsultantforHmblzayy/CLAUDE.md#research-protocol--4-agent-roi-check-on-new-concepts).
7. **Browser logins are persistent.** The Playwright `browser` skill uses one Chromium profile per Windows user at `~/.meta-playwright-profile/`, shared across every Claude session. If a login wall hits Google / GitHub / Modal / Cloudflare / Supabase / Meta / IG / X / TikTok / Discord / LinkedIn / etc., **retry under the persistent context** before asking the user to log in. If the retry fails, surface that the cookie likely expired and offer to re-run the sweep at `python ~/.claude/skills/browser/scripts/browser_pilot.py C:/Users/Claude/ecosystem/logins/sweep_actions.json`.
8. **Gmail multi-account.** Both BMB Gmail accounts are authed at `C:\Users\Claude\ecosystem\gmail\`: `bmb` → `bmbaiautomation@gmail.com`, `aibiblegospels` → `aibiblegospels444@gmail.com`. Use the `gmail-inbox` skill scripts for multi-account ops, or the `mcp__claude_ai_Gmail__*` MCP tools for the currently-attached account.

## Two-machine setup

- **Desktop** (192.168.0.131, user `Claude`/`Deskt`) — repos under `C:\Users\Claude\hblfaithwalk\` (this directory). Currently primary.
- **Laptop** (192.168.0.197, user `Owner`) — repos under `C:\Users\Owner\repos\`. Mounted on desktop as `Z:\`.

For "what repos do I have, what's their status?" use the portfolio scanner at `C:\Users\Claude\projectmanager\` (`python src/scanner/scan.py --root <path>`). Don't reinvent inventory.

## When working in this workspace

- **Identify which repo you're touching first.** A file path under `AIconsultantforHmblzayy/` vs `faithwalklivecom/` decides which `CLAUDE.md` rules apply and which `package.json` scripts are available.
- **Don't run `git` operations at the workspace root** — it's not a repo. `cd` into the specific sub-repo first.
- **Cross-repo work is normal here.** A single task often spans consulting (write checkpoint) → faithwalklive (auto-mirror + Vercel rebuild) → book (sync source material). The consulting repo's npm scripts already handle the cross-repo plumbing — prefer them over manual `cp`.
- **Live URLs:**
  - Tracker (GitHub Pages): https://12tribesofisrael.github.io/AIconsultantforHmblzayy/docs/faith-walk-tracker.html
  - Faith Walk Live (flagship #1): https://faithwalklive.com
  - Parent brand site: https://aibiblegospels.com
  - Anointed (flagship #2): https://anointed.app

## Pulling all repos at once

Workspace root isn't a git repo, so `git pull` here will fail with `not a git repository`. Use [pull-all.cmd](pull-all.cmd) (shim that bypasses PowerShell execution policy) or [pull-all.ps1](pull-all.ps1) directly:

```cmd
pull-all                  REM pulls all 5 sub-repos with --rebase --autostash, summary at end
pull-all -Status          REM just shows ahead/behind status, no pull
```

Or one-liner:
```powershell
'AIconsultantforHmblzayy','faithwalklivecom','aibiblegospelscom','faithwalkbook','claude-memory-backup' | % { Write-Host "=== $_ ==="; git -C $_ pull --rebase --autostash }
```
