# agent-kit

My Claude Code plugins and skills, set up so I can install them on any laptop.

## Install

Add the marketplace once:

```bash
claude plugin marketplace add Ashma-Rai-32/agent-kit
```

Then install the plugins you want, for example:

```bash
claude plugin install frontend@ashma-skills
```

Start a new Claude Code session after installing.

## Plugins

### Development

| Plugin | Skills | What it does |
|---|---|---|
| [frontend](plugins/frontend) | `/frontend:design` | Builds clean, accessible UIs with React/Next.js |

### Workflow

| Plugin | Commands | What it does |
|---|---|---|
| [autofocus](plugins/autofocus) | `/autofocus:on`, `off`, `status` | macOS: brings Claude's VS Code window and chat box back when it finishes. Needs a one-time setup, see its [README](plugins/autofocus/README.md). |

Claude picks skills up on its own when they fit the task. You can also run them directly.

## Updating

```bash
claude plugin marketplace update ashma-skills
claude plugin update <plugin>@ashma-skills
```

## License

MIT
