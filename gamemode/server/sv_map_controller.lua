--[[
server/sv_map_controller.lua

 - Handles map related tasks
 - Changing maps
 - Map Rotation
]]--

function BuildMapList()
	MapList = {}

	local old = ""
	local oldFound = ""

	for k,v in pairs(string.Explode("\n", file.Read(PUZZLE_ADDON_NAME.."/gamemode/NewMapList.txt","LUA"))) do
		if v ~= "" then
			if file.Exists("maps/"..v..".bsp", "GAME") then
				-- If we have a matching header:
				if old ~= "" then
					table.insert(MapList, {string.lower(v), old})
					old = ""
					oldFound = ""
				else
					oldFound = v
				end
			else
				if oldFound ~= "" then
					table.insert(MapList, {string.lower(oldFound), v})
					old = ""
					oldFound = ""
				else
					old = v
				end
			end
		end
	end
end

-- Build the map list:
BuildMapList()

-- Map rotation patch (fixes crashes):
if string.lower(game.GetMap()) == "gm_flatgrass" then
	print("\nServer has restarted, loading next map...\n")
	DB.Log("Server seemed to crash, loading map order...")

	local upto = MapList[1][1]

	-- Check if we know which map to load:
	if file.Exists("puzzle/upto.txt","DATA") then
		-- Decide which map we are up to:
		upto = file.Read("puzzle/upto.txt", "DATA")

		local mapnum = -1

		-- Check if the map is in our maplist:
		for k,v in pairs(MapList) do
			if v[1] == upto then
				mapnum = k
				break
			end
		end

		-- Failed to find that map:
		if mapnum == -1 then
			-- Default to the first level:
			upto = MapList[1][1]
		else
			-- Grab the next level:
			if MapList[mapnum+1] then
				-- Grab the correct level:
				upto = MapList[mapnum+1][1]
			else
				-- Default to the first level:
				upto = MapList[1][1]
			end
		end
	end

	-- Load the map:
	timer.Simple(0, function()
		RunConsoleCommand("changelevel",upto)
	end)
else
	if not GameLoaded then
		-- Server has loaded a valid map, save it:
		file.Write("puzzle/upto.txt", string.lower(game.GetMap()), "DATA")
		print("\nLoaded map "..string.lower(game.GetMap()).."\n")
		DB.Log("Loaded map "..string.lower(game.GetMap()))
	end
end

-- Run this to skip to the next map:
function SkipMap(m)
	-- Rebuild the map list:
	BuildMapList()

	-- Just to be sure:
	local m = string.lower(m or "")

	-- Validate the argument:
	if m and not file.Exists("maps/"..m..".bsp", "GAME") then
		m = string.lower(game.GetMap())
	end

	local n = -1

	-- Filter for our map:
	for k,v in pairs(MapList) do
		if m == v[1] then
			n = k
			break
		end
	end

	-- Grab the name of the next map:
	local upto = MapList[1][1]
	if n~=-1 and MapList[n+1] then
		upto = MapList[n+1][1]
	end

	-- Change to it:
	timer.Simple(0, function()
		RunConsoleCommand("changelevel",upto)
	end)
end

-- Called when a map is finished:
function FinishMap()
	//Update EXP:
	DB.FinshMap()

	-- Tell the player:
	PrintMessage( HUD_PRINTTALK, "Victory! Changing levels...")

	timer.Simple(3, function()
		SkipMap()
	end)
end