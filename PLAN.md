# agent-kit: plan

## Goal

A clean, deliberately designed set of AI coding-agent tools (skills, plugins, settings) that anyone, but mainly me, can install on any laptop in a few commands.

This is **not** a copy of my old `~/.claude` setup. Every skill is rebuilt on purpose: focused, current, and public-safe.

## Principles

1. **Minimal first.** Build one small piece, see it work, then grow.
2. **One skill, one job.** e.g. `python`, `langgraph`, `rag` as separate skills, not one giant "AI engineer" skill.
3. **Current knowledge.** Check current docs and versions; no deprecated APIs.
4. **Public-safe.** No employer or client content. Private notes stay in local files outside the repo.
5. **Tool-agnostic content.** Skills are plain `SKILL.md` folders (open Agent Skills format), so other agents (Codex, Cursor, Copilot) can use them later.
6. **Clean history.** Commit at every checkpoint with a Conventional Commit message.

## How it works

```
marketplace (this repo)  →  plugins  →  skills
.claude-plugin/              plugins/frontend/      skills/design/SKILL.md
  marketplace.json             .claude-plugin/        → /frontend:design
                                 plugin.json
```

- **Skill:** a `SKILL.md` with instructions. Its `description` decides when Claude uses it automatically.
- **Plugin:** a folder that bundles related skills. Skills are named `/plugin:skill`.
- **Marketplace:** the catalog of plugins in this repo.

**Install:**

```bash
claude plugin marketplace add Ashma-Rai-32/agent-kit   # or a local path
claude plugin install frontend@ashma-skills
```

**Edit loop:** edit the skill, commit, run `claude plugin marketplace update ashma-skills` and `claude plugin update frontend@ashma-skills`, then start a new session.

## Roadmap

### ✅ Phase 1: first plugin, end to end
- [x] Marketplace with one plugin: `frontend`
- [x] One skill: `design` (professional UI, accessibility, React/Next standards)
- [x] Installed, loaded and updated locally

### Phase 2: ready to share
- [ ] `LICENSE` (MIT)
- [ ] `README.md`: what this is plus the install commands
- [ ] Push to GitHub (public); install from GitHub to test what others get

### Phase 3: grow `frontend`
- [ ] Test that `design` triggers automatically (no slash command)
- [ ] Improve `design` based on real use
- [ ] Add focused skills only when needed (e.g. `nextjs`, `review`)

### Phase 4: `ai-engineering` plugin, designed fresh
- [ ] `python`: modern, typed, production Python for AI apps
- [ ] `langgraph`: agents, state, persistence, human-in-the-loop
- [ ] Later: `rag` (incl. Qdrant), `evals`, other frameworks (Mastra, Claude Agent SDK, ...)

### Phase 5: one-command laptop setup
- [ ] `home/CLAUDE.md`: global working rules (check docs, frameworks first, never commit unasked, explain then do) plus a private import `@~/.claude/CLAUDE.private.md`
- [ ] `home/settings.json`: preferred settings
- [ ] `bootstrap.sh`: install/update Claude Code, link CLAUDE.md, merge settings, add marketplace, install plugins; `--dry-run`; safe to re-run

### Later
- [ ] Support other coding agents (Codex, Cursor, Copilot)
- [ ] Background agents that run while offline (cloud routines or GitHub Actions)

## Decisions

| Decision | Why |
|---|---|
| Plugin marketplace, not copied files | Versioned, one-command install, shareable |
| Public repo, no employer content | Portfolio-friendly and safe to share |
| Start with one small `frontend` plugin | Learn how plugins work before scaling |
| Skill named `design`, not `frontend-design` | Avoids `/frontend:frontend-design` repetition |
| Plugin version = git commit | Edits reach installs only after commit + update |
