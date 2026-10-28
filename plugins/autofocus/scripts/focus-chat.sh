#!/bin/bash
# Stop hook: tell FocusClaude.app which VS Code window to bring back, then launch it (macOS only).

# Only for Claude sessions running inside VS Code on a Mac.
[[ "$OSTYPE" == darwin* && "$CLAUDE_CODE_ENTRYPOINT" == "claude-vscode" ]] || exit 0

# Off unless switched on with /autofocus:on (which creates this file).
[[ -f "$HOME/Library/Caches/FocusClaude/enabled" ]] || exit 0

app="$HOME/Applications/FocusClaude.app"
[[ -d "$app" ]] || exit 0  # not built yet: run scripts/build-focus-app.sh

# VS Code window titles contain the project folder name, e.g. "PLAN.md — agent-kit".
note="$HOME/Library/Caches/FocusClaude/window"
mkdir -p "$(dirname "$note")"
basename "${CLAUDE_PROJECT_DIR:-$PWD}" > "$note"

afplay /System/Library/Sounds/Glass.aiff &
open -a "$app"
