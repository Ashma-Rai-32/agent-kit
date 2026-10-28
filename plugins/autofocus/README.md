# autofocus

When Claude finishes, bring its VS Code window back to the front and put the cursor in the chat box, so you can keep going without touching the mouse. Pairs well with macOS Voice Control for a fully hands-free loop.

Off until you turn it on.

## Requirements

- macOS
- VS Code with the Claude Code extension
- Claude Code CLI (`claude`) for the install commands

## Setup (once per Mac)

**1. Install the plugin**

```bash
claude plugin marketplace add Ashma-Rai-32/agent-kit
claude plugin install autofocus@ashma-skills
```

**2. Build the FocusClaude helper app**

Autofocus uses a tiny helper app, so only that app gets permission to switch windows, not VS Code. Build it from source on your own Mac (read `FocusClaude.applescript` first if you like, it's short):

```bash
git clone https://github.com/Ashma-Rai-32/agent-kit.git
agent-kit/plugins/autofocus/scripts/build-focus-app.sh
```

This creates `~/Applications/FocusClaude.app`.

**3. Give FocusClaude its two permissions**

- **Automation:** the first time it runs, macOS asks *"FocusClaude wants access to control System Events"*. Click **Allow**.
- **Accessibility:** System Settings → Privacy & Security → Accessibility → **+** → press `Cmd+Shift+G`, paste `~/Applications/FocusClaude.app`, open it, and switch it on.

**4. (Optional) Hands-free with Voice Control**

System Settings → Accessibility → Voice Control → turn on. Then **Commands… → +**:

- When I say: `send it`
- While using: Code
- Perform: Press Keyboard Shortcut → **Return**

Now you can speak an instruction and say "send it" to submit it.

## Daily use

Start a new Claude session after installing, then:

| Command | What it does |
|---|---|
| `/autofocus:on` | Bring this window and chat box back whenever Claude finishes |
| `/autofocus:off` | Claude finishes quietly, no window switching |
| `/autofocus:status` | Shows ON or OFF |

The switch applies to all sessions on this Mac and stays as you left it. With Voice Control, say "go to sleep" or "wake up" to pause or resume listening.

## How it works

1. Claude finishes → the plugin's `Stop` hook runs `scripts/focus-chat.sh`.
2. If autofocus is on, it notes the project folder name, plays a sound and launches FocusClaude.
3. FocusClaude picks that project's window from VS Code's **Window** menu and runs **Claude Code: Focus input**.

## Troubleshooting

- **Wrong window or nothing happens:** check `~/Library/Caches/FocusClaude/log`. It shows which project it looked for and which windows it saw.
- **"FocusClaude is not allowed assistive access":** the Accessibility step is missing. After rebuilding the app, remove FocusClaude from the Accessibility list and add it again.
- **Two windows with the same folder name:** it picks the first one.

## Uninstall

```bash
claude plugin uninstall autofocus@ashma-skills
rm -rf ~/Applications/FocusClaude.app ~/Library/Caches/FocusClaude
```

Then remove FocusClaude from System Settings → Privacy & Security → Accessibility and Automation.
