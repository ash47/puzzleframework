if SERVER then return end

--[[
client/cl_welcome.lua
]]--

Welcome = {}
local function NEW(...)
	table.insert(Welcome, {...})
end

local function A(...)
	table.Add(Welcome[#Welcome], {...})
end

NEW("Welcome to AussieServers.Net")
A("\"Accept the challenges so that you may feel the exhilaration of victory.\"")
A("You may access this menu using the F1 - F4 keys.")
A("")
A("NOTE: This server/gamemode is still under construction!")

NEW("Puzzle Gamemode Overview")
A("1. The goal is to complete as many puzzles as you can.")
A("2. Be fair and equal; do not use any exploits, cheats, 3rd party software, or scripts to gain an unfair advantage over other players.")
A("3. If someone is breaking rules or griefing you, politely ask them to stop.")
A("     - If they do not, feel free to use the F2 Menu to vote kick, or vote ban them.")
A("     - Please note: All kicking and banning is logged.")
A("4. Do not purposely annoy players with the microphone by any means.")
A("     - You are only allowed to 'sing' if most people are ok with it.")
A("5. If someone is using their microphone inappropriately, you may mute them using the F2 menu.")
A("6. Be tolerant of different players, refrain from using hate and/or racist language.")
A("7. Please refrain from staying AFK for too long, it's unfair to other players who want to play.")
A("8. The admins are here to help you, obey them at all times.")
A("9. If you find anything that can be considered a gamemode exploit, please report it to Ash47")

NEW("Explanation: Main Menu")
A(" - The main menu offers some very useful commands to help you beat those extremely difficult puzzles.")
A(" - \"I'm Stuck\"  button can be used to free yourself when ever you get stuck.")
A(" - \"Save State\" and \"Load State\" will respectively save and load your state, your state includes:")
A("     - Weapons")
A("     - Ammo")
A("     - Position")
A("     - Angle")
A("     - Gravity")
A(" - You can only save state while you aren't moving. You can freely load your state within reason.")
A(" - \"Vote Skip Map\" and \"Vote New Map\" can be used when a map is broken, or if everyone is sick of the current level.")
A("    - A majority vote is required for the change to occur.")
A(" - The player option section allows you to interact with other players.")
A("     - If someone is wrecking the puzzle you are doing, ask them to stop")
A("          - If they don't, feel free to use the vote kick/ban buttons.")
A("     - If someone is spamming, or annoying you through their micophone, try the mute button.")
A(" - To help you catchup to other players, the \"goto\" button can be used.")
A("     - It requires permission from the player before teleporting you.")
A("     - You will be set to the chosen player's \"state\"")
A("          - See Save Sates above for more info on states.")

NEW("Useful Console Commands")
A("You may like to bind some of these functions to keys, you will need console access to do this, here's how:")
A("     Press Escape ==> Select Options ==> Select Keyboard ==> Select Advanced ==> Click the console checkbox")
A("     Now that you have console access, press ~, it is on the left of 1 on most keyboards.")
A("")
A("Enter the following commands:")
A("     bind F5 _savepos")
A("     bind F7 _getpos")
A("")
A("Now if you go back into the game, and press F5, is should save your state, and if you press F7, it should load your state.")
A("")
A("Full list of commands:")
A("_savepos <slot>    Used to save your state")
A("_getpos  <slot>    Used to load your state")
A("")
A("More will be added soon...")
