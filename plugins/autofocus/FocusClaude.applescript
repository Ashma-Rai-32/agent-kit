-- FocusClaude: bring the right VS Code window to the front and focus the Claude chat box.
-- Built into FocusClaude.app so only this tiny app needs macOS permissions.

-- The Stop hook writes the project folder name here (see scripts/focus-chat.sh).
set notePath to (POSIX path of (path to home folder)) & "Library/Caches/FocusClaude/window"
set projectName to ""
try
	set projectName to do shell script "cat " & quoted form of notePath
end try

tell application "Visual Studio Code" to activate
delay 0.1

-- Pick the project's window from VS Code's Window menu, like clicking it by hand.
if projectName is not "" then
	set picked to "not found"
	tell application "System Events" to tell process "Code"
		set windowMenu to menu "Window" of menu bar item "Window" of menu bar 1
		set itemNames to name of every menu item of windowMenu -- one call, not one per item
		repeat with i from 1 to count of itemNames
			set itemName to item i of itemNames
			if itemName is not missing value and itemName contains projectName then
				click menu item i of windowMenu
				set picked to itemName
				exit repeat
			end if
		end repeat
	end tell
	-- Record the result, for troubleshooting: ~/Library/Caches/FocusClaude/log
	do shell script "echo " & quoted form of ("looking for: " & projectName & linefeed & "picked: " & picked) & " > ~/Library/Caches/FocusClaude/log"
	delay 0.15
end if

tell application "System Events"
	keystroke "p" using {command down, shift down} -- open the command palette
	delay 0.15
	keystroke "Claude Code: Focus input"
	delay 0.1
	key code 36 -- Return
end tell
