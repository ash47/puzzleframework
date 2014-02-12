--[[
shared/sh_shop.lua

 - Shop items
]]--

Shop = {}
ShopR = {}

-- Useful vars:
ShopSortModel = 1		-- Use model preview
ShopSortMaterial = 2	-- Use texture preview

-- Different types:
ShopTypeModel = 1
ShopTypeTrail = 2

-- Adds a new category:
local function NewCat(title, icon, des)
	-- Create the category:
	Shop[title] = {}
	
	-- Store info:
	Shop[title].icon = icon
	Shop[title].des = des
	
	-- Item Store:
	Shop[title].items = {}
	
	-- Return it:
	return title
end

local function AddItem(cat, args)
	if not Shop[cat] then
		print("Couldn't find cat "..cat)
		return
	end
	
	-- Insert it:
	Shop[cat].items[args.id] = args
	ShopR[args.id] = cat
end

-- Models:
catModels = NewCat("Models")

-- Urban
AddItem(catModels,{
id = 1,
name = "Urban",
model = "models/player/urban.mdl",
sort = ShopSortModel,
type = ShopTypeModel,
cost = 100,
donorcost = 10
})

-- Odessa
AddItem(catModels,{
id = 2,
name = "Odessa",
model = "models/player/odessa.mdl",
sort = ShopSortModel,
type = ShopTypeModel,
cost = 50,
donorcost = 10
})

-- Kleiner
AddItem(catModels,{
id = 10,
name = "Kleiner",
model = "models/player/kleiner.mdl",
sort = ShopSortModel,
type = ShopTypeModel,
cost = 75,
donorcost = 10
})

-- Mossman
AddItem(catModels,{
id = 11,
name = "Mossman",
model = "models/player/mossman.mdl",
sort = ShopSortModel,
type = ShopTypeModel,
cost = 40,
donorcost = 10
})

-- Monk
AddItem(catModels,{
id = 12,
name = "Monk",
model = "models/player/monk.mdl",
sort = ShopSortModel,
type = ShopTypeModel,
cost = 60,
donorcost = 10
})

-- Gman
AddItem(catModels,{
id = 13,
name = "Gman",
model = "models/player/gman_high.mdl",
sort = ShopSortModel,
type = ShopTypeModel,
cost = 80,
donorcost = 10
})

-- Alyx
AddItem(catModels,{
id = 14,
name = "Alyx",
model = "models/player/alyx.mdl",
sort = ShopSortModel,
type = ShopTypeModel,
cost = 35,
donorcost = 10
})

-- Phoenix
AddItem(catModels,{
id = 15,
name = "Phoenix",
model = "models/player/phoenix.mdl",
sort = ShopSortModel,
type = ShopTypeModel,
cost = 45,
donorcost = 10
})

-- Arctic
AddItem(catModels,{
id = 16,
name = "Arctic",
model = "models/player/arctic.mdl",
sort = ShopSortModel,
type = ShopTypeModel,
cost = 88,
donorcost = 10
})

-- Barney
AddItem(catModels,{
id = 17,
name = "Barney",
model = "models/player/barney.mdl",
sort = ShopSortModel,
type = ShopTypeModel,
cost = 55,
donorcost = 10
})

-- Breen
AddItem(catModels,{
id = 18,
name = "Breen",
model = "models/player/breen.mdl",
sort = ShopSortModel,
type = ShopTypeModel,
cost = 53,
donorcost = 10
})

-- Combine Soldier
AddItem(catModels,{
id = 19,
name = "Combine Soldier",
model = "models/player/combine_soldier.mdl",
sort = ShopSortModel,
type = ShopTypeModel,
cost = 95,
donorcost = 10
})

-- Prison Guard
AddItem(catModels,{
id = 20,
name = "Prison Guard",
model = "models/player/combine_soldier_prisonguard.mdl",
sort = ShopSortModel,
type = ShopTypeModel,
cost = 95,
donorcost = 10
})

-- Combine Super Soldier
AddItem(catModels,{
id = 21,
name = "Combine Super Soldier",
model = "models/player/combine_super_soldier.mdl",
sort = ShopSortModel,
type = ShopTypeModel,
cost = 100,
donorcost = 10
})

-- Hobo
AddItem(catModels,{
id = 22,
name = "Hobo",
model = "models/player/corpse1.mdl",
sort = ShopSortModel,
type = ShopTypeModel,
cost = 150,
donorcost = 10
})

-- Eli
AddItem(catModels,{
id = 26,
name = "Eli",
model = "models/player/eli.mdl",
sort = ShopSortModel,
type = ShopTypeModel,
cost = 65,
donorcost = 10
})

-- Guerilla
AddItem(catModels,{
id = 27,
name = "Guerilla",
model = "models/player/guerilla.mdl",
sort = ShopSortModel,
type = ShopTypeModel,
cost = 100,
donorcost = 10
})

-- Leet
AddItem(catModels,{
id = 28,
name = "Leet",
model = "models/player/leet.mdl",
sort = ShopSortModel,
type = ShopTypeModel,
cost = 100,
donorcost = 10
})

-- Magnusson
AddItem(catModels,{
id = 29,
name = "Magnusson",
model = "models/player/magnusson.mdl",
sort = ShopSortModel,
type = ShopTypeModel,
cost = 72,
donorcost = 10
})

-- Civil Protection
AddItem(catModels,{
id = 30,
name = "Civil Protection",
model = "models/player/police.mdl",
sort = ShopSortModel,
type = ShopTypeModel,
cost = 100,
donorcost = 10
})

--[[
Trails
]]--
catTrails = NewCat("Trails")

-- Electric Trail
AddItem(catTrails,{
id = 3,
name = "Electric Trail",
material = "trails/electric.vmt",
sort = ShopSortMaterial,
type = ShopTypeTrail,
cost = 30,
donorcost = 10
})

-- Laser Trail
AddItem(catTrails,{
id = 4,
name = "Laser Trail",
material = "trails/laser.vmt",
sort = ShopSortMaterial,
type = ShopTypeTrail,
cost = 30,
donorcost = 10
})

-- LOL Trail
AddItem(catTrails,{
id = 5,
name = "LOL Trail",
material = "trails/lol.vmt",
sort = ShopSortMaterial,
type = ShopTypeTrail,
cost = 30,
donorcost = 10
})

-- Love Trail
AddItem(catTrails,{
id = 6,
name = "Love Trail",
material = "trails/love.vmt",
sort = ShopSortMaterial,
type = ShopTypeTrail,
cost = 30,
donorcost = 10
})

-- Plasma Trail
AddItem(catTrails,{
id = 7,
name = "Plasma Trail",
material = "trails/plasma.vmt",
sort = ShopSortMaterial,
type = ShopTypeTrail,
cost = 30,
donorcost = 10
})

-- Smoke Trail
AddItem(catTrails,{
id = 8,
name = "Smoke Trail",
material = "trails/smoke.vmt",
sort = ShopSortMaterial,
type = ShopTypeTrail,
cost = 30,
donorcost = 10
})

-- Tube Trail
AddItem(catTrails,{
id = 9,
name = "Tube Trail",
material = "trails/tube.vmt",
sort = ShopSortMaterial,
type = ShopTypeTrail,
cost = 30,
donorcost = 10
})

