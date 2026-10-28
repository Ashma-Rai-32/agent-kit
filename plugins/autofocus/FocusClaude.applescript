-- FocusClaude: bring the right VS Code window to the front and focus the Claude chat box.
-- Built into FocusClaude.app so only this tiny app needs macOS permissions.

-- The Stop hook writes the project folder name here (see scripts/focus-chat.sh).
set notePath to (POSIX path of (path to home folder)) & "Library/Caches/FocusClaude/window"
set projectName to ""
try
	set projectName to do shell script "cat " & quoted form of notePath
end try

tell application "Visual Studio Code" to activate
delay 0.3

-- Pick the project's window from VS Code's Window menu, like clicking it by hand.
if projectName is not "" then
	set seen to {}
	tell application "System Events" to tell process "Code"
		set windowMenu to menu "Window" of menu bar item "Window" of menu bar 1
		repeat with mi in menu items of windowMenu
			set itemName to name of mi
			if itemName is not missing value then
				set end of seen to itemName
				if itemName contains projectName then
					click mi
					exit repeat
				end if
			end if
		end repeat
	end tell
	-- Record what was found, for troubleshooting: ~/Library/Caches/FocusClaude/log
	set AppleScript's text item delimiters to " | "
	do shell script "echo " & quoted form of ("looking for: " & projectName & linefeed & "seen: " & (seen as text)) & " > ~/Library/Caches/FocusClaude/log"
	delay 0.3
end if

tell application "System Events"
	keystroke "p" using {command down, shift down} -- open the command palette
	delay 0.3
	keystroke "Claude Code: Focus input"
	delay 0.3
	key code 36 -- Return
end tell
