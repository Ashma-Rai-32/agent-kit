# agent-kit: plan

Goal: keep my AI coding-agent setup (instructions, settings, skills) in one public git repo, so a new laptop is fully set up by running one script.

Phase 1 targets Claude Code. The skills themselves stay tool-agnostic (plain `SKILL.md` folders, the open Agent Skills format), so other agents such as Codex, Cursor or Copilot can be supported later by extending the bootstrap, not by rewriting skills.

## 1. Background: where Claude Code keeps your setup

Everything personal lives in `~/.claude/` on each laptop:

| Thing | Location | What it does |
|---|---|---|
| Global instructions | `~/.claude/CLAUDE.md` | Read at the start of every session, in every project |
| Settings | `~/.claude/settings.json` | Theme, effort level, permissions (what Claude may or may not do) |
| Skills | `~/.claude/skills/<name>/SKILL.md` | Expert instructions that load only when relevant |
| Commands | `~/.claude/commands/*.md` | Things you type, like `/commit` |
| Memory | `~/.claude/projects/<project>/memory/` | Facts Claude remembers per project |

A new laptop starts with none of this. The goal is to keep it in a git repo and have one script put it back.

## 2. The key idea: a plugin marketplace

- A **plugin** is a folder that bundles skills and commands together, plus a small `plugin.json` describing it.
- A **marketplace** is a repo listing one or more plugins in a `marketplace.json` file.
- Claude Code can install plugins from a marketplace with `claude plugin install`. This is free; it's just reading files from a folder or a GitHub repo.

So this repo *is* my marketplace. On any laptop: clone it, run the script, and the script tells Claude Code "install my plugins from here."

Why not just copy the files into `~/.claude/skills`? You could, but plugins can be versioned, updated with one command, and installed by other people (clients, teammates) from the public repo. That's the professional route.

## 3. What goes in the repo

```
agent-kit/
├── .claude-plugin/
│   └── marketplace.json        ← "this repo offers 2 plugins: ai-engineering, fullstack"
├── plugins/
│   ├── ai-engineering/
│   │   ├── .claude-plugin/plugin.json
│   │   └── skills/  python-ai-engineer/, qdrant/
│   └── fullstack/
│       ├── .claude-plugin/plugin.json
│       └── skills/  senior-react-dev/, aws-terraform-engineer/, commit/
├── home/
│   ├── CLAUDE.md               ← global instructions (generic, public-safe)
│   └── settings.json           ← preferred settings
├── bootstrap.sh                ← the one script
├── PLAN.md                     ← this file
└── README.md
```

**Public vs private:** no employer content goes in this repo. The global `CLAUDE.md` ends with a line that pulls in `~/.claude/CLAUDE.private.md`, a file that exists only on the work laptop. On the current laptop, the script moves the existing work-specific pointer into that file, so nothing is lost.

## 4. What `bootstrap.sh` does, step by step

1. **Installs or updates Claude Code.** If `claude` is missing it runs the official installer; otherwise it runs `claude update`. The current version (2.1.220) is too old for some plugin commands.
2. **Makes a backup** of the current `~/.claude/CLAUDE.md`, `settings.json` and any skills it touches, into `~/.claude/backups/bootstrap-<date>/`. Nothing is deleted outright.
3. **Global instructions.** It replaces `~/.claude/CLAUDE.md` with a symlink to `home/CLAUDE.md`. A symlink is a shortcut: editing either one edits the repo file, so `git commit` captures the change.
4. **Settings: merged, not linked.** Claude Code writes to `settings.json` itself (when you approve permissions or install plugins). Linking it would leak those machine-specific writes into the repo. Instead the script merges `home/settings.json` *into* the existing file, so the repo's values win and everything else is kept.
5. **Plugins.** It registers the repo as a marketplace (`claude plugin marketplace add <this folder>`), then installs both plugins.
6. **Removes duplicates.** On the current laptop, the old loose copies of the 4 generic skills and `commands/commit.md` move to the backup folder; otherwise each skill would load twice. Work skills are left alone.
7. **Safe to re-run.** Running it twice does nothing harmful. A `--dry-run` flag prints what it *would* do without changing anything.

**On a new laptop:**

```bash
git clone https://github.com/<you>/agent-kit.git && cd agent-kit
./bootstrap.sh --dry-run   # look first
./bootstrap.sh
claude auth login          # sign in once
```

## 5. Things to know

- **One small difference:** plugin skills get a prefix. `/commit` becomes `/fullstack:commit`. Skills Claude picks up automatically work the same as before.
- **Proposed settings addition:** block Claude from reading `.env` files and `~/.ssh`. That's sensible when freelancing in client repos.
- **Memory doesn't move.** Memory is per-laptop and per-project. That's fine; it's meant to be local.

## 6. Phases

- [ ] **Phase 1 (now):** repo layout, plugins, `home/` files, `bootstrap.sh`, README.
- [ ] **Phase 2:** an `agent-frameworks` skill in `ai-engineering`, with a framework-agnostic core (state, persistence, human-in-the-loop, tools, evals, tracing) plus `references/langgraph.md`, and one reference file per framework added later (Mastra, Claude Agent SDK, ...).
- [ ] **Later:** support other coding agents (e.g. link skills into Codex/Cursor skill folders, add an `AGENTS.md`).
- [ ] **Phase 3:** background agents that run while offline (Claude cloud routines or GitHub Actions). Note: cloud sessions only see skills committed inside each project's own `.claude/` folder, not personal plugins.

## 7. Open questions

1. Already done: 4 generic skills copied into `plugins/`, and work-specific sections removed from `senior-react-dev`. Keep these, or delete and redo?
2. Add the `.env` / `~/.ssh` deny rule to settings: yes or no?
