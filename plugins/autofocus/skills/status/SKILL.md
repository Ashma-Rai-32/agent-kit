---
name: status
description: Show whether autofocus is on or off.
disable-model-invocation: true
allowed-tools: Bash(test -f ~/Library/Caches/FocusClaude/enabled && echo ON || echo OFF)
---

Run exactly: `test -f ~/Library/Caches/FocusClaude/enabled && echo ON || echo OFF`

Then reply with one line: "Autofocus is ON" or "Autofocus is OFF", matching the output.
