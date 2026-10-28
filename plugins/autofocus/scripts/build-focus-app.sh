#!/bin/bash
# Build FocusClaude.app from its AppleScript source into ~/Applications.
# Re-run after changing FocusClaude.applescript (macOS will then ask for permission again).
set -euo pipefail

src="$(dirname "$0")/../FocusClaude.applescript"
app="$HOME/Applications/FocusClaude.app"

mkdir -p "$HOME/Applications"
rm -rf "$app"
osacompile -o "$app" "$src"

plist="$app/Contents/Info.plist"
# Give it a clear name and ID, so macOS permission prompts say "FocusClaude", not "applet".
plutil -replace CFBundleName -string "FocusClaude" "$plist"
plutil -replace CFBundleIdentifier -string "com.ashma.focusclaude" "$plist"
# Run in the background without a Dock icon.
plutil -replace LSUIElement -bool true "$plist"
# Re-sign locally after editing Info.plist, or macOS refuses to open it.
codesign --force --sign - "$app"

echo "Built $app"
