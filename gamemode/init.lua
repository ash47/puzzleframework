--[[
init.lua

 - Load everything
 - Send client side files
]]--

-- Rename this if you change the folder name
PUZZLE_ADDON_NAME = 'puzzleframework'

-- Send all the lua in a folder:
function AddCSLuaFolder(folder)
	-- Find all the files and directories:
	local f, d = file.Find(GM.FolderName.."/gamemode/"..string.lower(folder).."/*", "LUA")

	-- Add each file:
	for k,v in pairs(f) do
		AddCSLuaFile(string.lower(folder.."/"..v))

		-- Workaround for shit:
		include(string.lower(folder.."/"..v))
	end

	-- Add all folders:
	for k,v in pairs(d) do
		AddCSLuaFolder(folder.."/"..v)
	end
end

-- Send all the sounds in a folder:
function AddFileFolder(folder)
	-- Find all the files and directories:
	local f, d = file.Find(folder.."/*", "GAME")

	-- Add each file:
	for k,v in pairs(f) do
		resource.AddFile(folder.."/"..v)
	end

	-- Add all folders:
	for k,v in pairs(d) do
		AddCSLuaFolder(folder.."/"..v)
	end
end

-- Send over main client file:
AddCSLuaFile("cl_init.lua")
include("cl_init.lua")

-- Send over the client files:
AddCSLuaFolder("shared")
AddCSLuaFolder("client")

-- Server Settings:
include("server_settings.lua")

-- Load server files:
include("server/_server.lua")
