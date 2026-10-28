---
name: off
description: Turn autofocus off, so Claude finishes quietly without switching windows.
disable-model-invocation: true
allowed-tools: Bash(rm -f ~/Library/Caches/FocusClaude/enabled)
---

Run exactly: `rm -f ~/Library/Caches/FocusClaude/enabled`

Then reply with one line: "⌨️ Autofocus off."
