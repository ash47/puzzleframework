--[[
server/sv_shop.lua

 - Shop
]]--

local meta = FindMetaTable("Player")

function meta:InvLoad()
	-- Create a new inventory:
	self.Inv = {}
	self.Inv.Owned = {}
	self.Inv.Equipped = {}
	
	-- Stuff:
	self.puzzlesbeaten = 0
	self.timebonus = 0
	
	-- Load Shite:
	self:Loadmoney()
	self:LoadPlaytime()
	self:LoadExp()
	
	-- Set their team:
	self:SetTeam(TEAM_NOOB)
	
	DB.Query("SELECT * FROM items WHERE steam = " .. sql.SQLStr(self:UniqueID()) .. ";", function(r)
		if r then
			for k,v in pairs(r) do
				self.Inv.Owned[tonumber(v.item)] = true
			end
		end
	end)
	
	DB.Query("SELECT * FROM equipped WHERE steam = " .. sql.SQLStr(self:UniqueID()) .. ";", function(r)
		if r then
			for k,v in pairs(r) do
				self:Equip(tonumber(v.item))
			end
		end
	end)
	
	-- Send inv:
	self:InvSend()
	self:InvSendEquipped()
end

-- Give a player an item:
function meta:InvGive(id)
	-- Give item:
	self.Inv.Owned[id] = true
	
	-- Store into DB:
	DB.Query("INSERT INTO items VALUES("..self:UniqueID()..", "..id..");")
	
	-- Send new inventory:
	self:InvSend()
end

-- Send the player their inventory:
function meta:InvSend()
	net.Start("inv")
	for k,v in pairs(self.Inv.Owned) do
		net.WriteInt(k, 16)
	end
	net.Send(self)
end

-- Send the player what is equipped:
function meta:InvSendEquipped()
	net.Start("invE")
	for k,v in pairs(self.Inv.Equipped) do
		net.WriteInt(v, 16)
	end
	net.Send(self)
end

-- Store what we have equipped:
function meta:InvStoreEquipped()
	DB.Query("DELETE FROM equipped WHERE steam = " .. sql.SQLStr(self:UniqueID()) .. ";")
	
	-- Anything to store:
	if #self.Inv.Equipped > 0 then
		-- Build the query:
		local q = ""
		for k,v in pairs(self.Inv.Equipped) do
			q = q.."INSERT INTO equipped VALUES("..self:UniqueID()..", "..v..");"
		end
		
		-- Run it:
		DB.Query(q)
	end
end

-- Toggle equip an item:
function meta:InvTEquip(id)
	local item = InvFindItem(id)
	
	-- Do they have something equipped in this slot:
	if self.Inv.Equipped[item.type] then
		if self.Inv.Equipped[item.type] == id then
			-- Unequip
			self:Unequip(id)
			
			-- Store equipped:
			self:InvStoreEquipped()
			
			-- Send new list:
			self:InvSendEquipped()
			
			-- Stop here
			return
		else
			-- Unequip old item
			self:Unequip(id)
		end
	end
	
	-- Equip new one:
	self:Equip(id)
	
	-- Store equipped:
	self:InvStoreEquipped()
	
	-- Send new list:
	self:InvSendEquipped()
end

function meta:Equip(id)
	local item = InvFindItem(id)
	
	-- Uneqip old items:
	if self.Inv.Equipped[item.type] then
		self:Unequip(id)
	end
	
	-- Equip our item:
	if item.type == ShopTypeModel then
		-- A player model:
		self:SetModel(item.model)
	elseif item.type == ShopTypeTrail then
		-- A trail:
		self.Trailent = util.SpriteTrail(self, 0, Color(255, 255, 255, 255), false, 15, 1, 4, 0.125, item.material)
	end
	
	-- Store the equipped item:
	self.Inv.Equipped[item.type] = id
end

function meta:Unequip(id)
	local item = InvFindItem(id)
	
	if self.Inv.Equipped[item.type] then
		if item.type == ShopTypeModel then
			-- A player model:
			self:SetModel(_settings.ModelDefault)
		elseif item.type == ShopTypeTrail then
			-- A trail:
			if self.Trailent then
				-- Remove the trail:
				SafeRemoveEntity(self.Trailent)
			end
		end
	end
	
	self.Inv.Equipped[item.type] = nil
end

function InvFindItem(id)
	return Shop[ShopR[id]].items[id]
end

-- When a player spawns, set their equipment:
function meta:SpawnEquip()
	-- Set default model:
	self:SetModel(_settings.ModelDefault)
	
	-- Apply equipment:
	for k,v in pairs(self.Inv.Equipped) do
		self:Equip(v)
	end
end

net.Receive("shop", function(len, ply)
	-- Read the ID:
	local id = net.ReadInt(16)
	
	-- Validate it:
	if not ShopR[id] then
		ply:Notify(1, 5, "This item appears to be invalid...")
		return
	end
	
	local item = InvFindItem(id)
	
	-- Check if they own it:
	if ply.Inv.Owned[id] then
		ply:InvTEquip(id)
	else
		-- They want to buy it:
		if ply.money>=item.cost then
			-- Tell them they bought it:
			ply:Notify(0, 5, "You bought '"..item.name.."'")
			
			-- Take money:
			ply.money = ply.money - item.cost
			ply:Savemoney()
			
			-- Add it to their list of owned stuff:
			ply:InvGive(id)
		else
			ply:Notify(1, 5, "You can't afford this item!")
		end
	end
end)
