---
name: on
description: Turn autofocus on, so this VS Code window and its chat box come back when Claude finishes.
disable-model-invocation: true
allowed-tools: Bash(mkdir -p ~/Library/Caches/FocusClaude && touch ~/Library/Caches/FocusClaude/enabled)
---

Run exactly: `mkdir -p ~/Library/Caches/FocusClaude && touch ~/Library/Caches/FocusClaude/enabled`

If `~/Applications/FocusClaude.app` does not exist, tell the user to build it first with the
autofocus plugin's `scripts/build-focus-app.sh`.

Then reply with one line: "🎙️ Autofocus on. I'll bring this window back when I finish."
