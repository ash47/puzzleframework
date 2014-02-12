--[[
server/sv_chat.lua

 - Chat related things
 - Stop chat spam
 - Log chat
]]--

-- Find a player by name:
function player.GetByName(name)
	local t = {}
	
    name = string.lower(name);
    for k,v in ipairs(player.GetAll()) do
        if(string.find(v:Name():lower(),name,1,true)) then
			table.insert(t, v)
        end
    end
	
	return t
end

-- Kill:
local Kill = function(ply)
	ply:Kill()
end

-- Goto:
local Goto = function(ply, args)
	local a = table.concat(args, " ")
	local p = player.GetByName(a)
	
	-- Decide what to do:
	if #p == 0 then
		ply:Notify(1, 5, "Couldn't find a match for '"..a.."'")
	elseif #p == 1 then
		ply:Goto(p[1])
	else
		ply:Notify(1, 5, "Found "..#p.." matches, be more specific.")
	end
end

-- Save:
local Save = function(ply, args)
	ply:SaveState(tonumber(args[1]))
end

-- Load:
local Load = function(ply, args)
	ply:LoadState(tonumber(args[1]))
end

-- Commands:
local Commands = {
-- TP Commands:
tp = Goto,
goto = Goto,

-- Suicide commands:
kill = Kill,
explode = Kill,
suicide = Kill,
stuck = Kill,

-- Saving:
save = Save,
cp = Save,
checkpoint = Save,
savecp = Save,
savepos = Save,
savestate = Save,

-- Loading:
load = Load,
loadcp = Load,
getcp = Load,
loadcheckpoint = Load,
loadpos = Load,
loadstate = Load
}

-- When a player chats:
function GM:PlayerSay(ply, text, public)
	-- Check for commands:
	local s = string.sub(text, 1, 1)
	if s == "!" or s == "/" then
		-- Workout the args:
		local args = string.Explode(" ", string.sub(text, 2, text:len()))
		
		-- Grab the command:
		local cmd = args[1]:lower()
		
		-- Remove the command:
		table.remove(args, 1)
		
		-- Does the command exist:
		if Commands[cmd] then
			-- Run it:
			Commands[cmd](ply, args)
			
			-- Don't print it:
			return ""
		end
	end
	
	-- Stop spam BS:
	if CurTime()<ply.lastMsgTime+1 and not ply:IsAdmin() then
		Notify(ply, 1, 5, "Please refrain from spamming!")
		return ""
	elseif CurTime()<ply.lastMsgTime+5 then
		if text == ply.lastMsg then
			Notify(ply, 1, 5, "Didn't you just say that?!?")
			return ""
		end
	end
    ply.lastMsgTime = CurTime()
	ply.lastMsg = text
	
	-- Log the chat:
	DB.Log(ply:Nick().." ("..(ply:SteamID() or "")..")"..": "..text)
	
	-- Return the text:
	return text
end
