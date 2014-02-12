--[[
server/sv_savestates.lua

 - Save States
]]--

local meta = FindMetaTable("Player")

-- Save a state:
function meta:SaveState(slot)
	if self.CantSaveState then
		return
	end
	--if self:IsDonor() then
		self.LastSlot = slot or 1
	--else
	--	self.LastSlot = 1
	--end
	
	if not self:Alive() or self.LastSpawn+5>CurTime() then
		Notify(self, 1, 5, "Please wait atleast 5 seconds before saving your state!")
		return false
	end
	
	-- Stop spamming:
	self.CantSaveState = true
	timer.Simple(0.5,function()
		self.CantSaveState = false
	end)
	
	if(not self:GetVehicle():IsValid()) then
		-- Save Position:
		self._savestate[self.LastSlot] = {}
		
		-- Store our position:
		self._savestate[self.LastSlot]["pos"] = self:GetPos()
		
		-- Save Our Eye Angles:
		self._savestate[self.LastSlot]["eye"] = self:EyeAngles()
		
		-- Save Our Angles:
		self._savestate[self.LastSlot]["angles"] = self:GetAngles()
		
		-- Save Gravity:
		self._savestate[self.LastSlot]["gravity"] = self:GetGravity()
		
		-- Save Velocity:
		self._savestate[self.LastSlot]["velocity"] = self:GetVelocity()
		
		-- Save Weapons:
		local stripped = {}
		for k,v in pairs(self:GetWeapons()) do
			table.insert(stripped, {v:GetClass(), self:GetAmmoCount(v:GetPrimaryAmmoType()), 
			v:GetPrimaryAmmoType(), self:GetAmmoCount(v:GetSecondaryAmmoType()), v:GetSecondaryAmmoType(),
			v:Clip1(), v:Clip2()})
		end
		self._savestate[self.LastSlot]["weps"] = stripped
		
		if self:GetActiveWeapon():IsValid() then
			self._savestate[self.LastSlot]["aw"] = self:GetActiveWeapon():GetClass()
		else
			self._savestate[self.LastSlot]["aw"] = ""
		end
		
		-- Tell the player:
		Notify(self, 0, 5, "State Saved!")
		
		-- Success:
		return true
	else
		-- In a vehicle
		self._savestateVEH[self.LastSlot] = {}
		self._savestateVEH[self.LastSlot]["pos"] = self:GetVehicle():GetPos()
		self._savestateVEH[self.LastSlot]["angles"] = self:GetVehicle():GetAngles()
		self._savestateVEH[self.LastSlot]["velocity"] = self:GetVehicle():GetVelocity()
		
		-- Tell the player:
		Notify(self, 0, 5, "Vehicle's state saved!")
		
		-- Success:
		return true
	end
end

-- Load a state:
function meta:LoadState(slot)
	if self.CantLoadState then
		return
	end
	
	--if self:IsDonor() then
		self.LastSlot = slot or 1
	--else
	--	self.LastSlot = 1
	--end
	
	-- Stop spamming:
	self.CantLoadState = true
	timer.Simple(0.5,function()
		self.CantLoadState = false
	end)
	
	if(not self:GetVehicle():IsValid()) then
		if self._savestate[self.LastSlot] then
			-- Set Our Gravity:
			self:SetGravity(self._savestate[self.LastSlot]["gravity"])
			
			-- Reset our velocity:
			self:SetVelocity(Vector(0,0,0))
			self:SetLocalVelocity(Vector(0,0,0))
			
			-- Set Our Velocity:
			self:SetVelocity(self._savestate[self.LastSlot]["velocity"])
			
			-- Set Our Position:
			self:SetPos(self._savestate[self.LastSlot]["pos"])
			
			-- Set Our View Angle:
			self:SetEyeAngles(self._savestate[self.LastSlot]["eye"])
			
			-- Set Our Angle:
			self:SetAngles(self._savestate[self.LastSlot]["angles"])
			
			-- Give the player their weapons:
			self:StripWeapons()
			self:RemoveAllAmmo()
			for k,v in pairs(self._savestate[self.LastSlot]["weps"]) do
				local wep = self:Give(v[1])
				if wep:IsValid() then
					self:SetAmmo(v[2], v[3], false)
					self:SetAmmo(v[4], v[5], false)
					wep:SetClip1(v[6])
					wep:SetClip2(v[7])
				end
			end
			
			--  Set our active weapon:
			if self._savestate[self.LastSlot]["aw"] ~= "" then
				timer.Simple(0.5,function()
					self:SelectWeapon(self._savestate[self.LastSlot]["aw"])
				end)
			end
			
			-- Stop loading glitch:
			self.LastSpawn = CurTime()-5
			
			-- Tell the player:
			Notify(self, 0, 5, "State Loaded!")
			
			-- Success:
			return true
		else
			Notify(self, 1, 5, "You haven't saved a state!")
			return false
		end
	else
		-- In a vehicle:
		if self._savestateVEH[self.LastSlot] then
			self:GetVehicle():SetPos(self._savestateVEH[self.LastSlot]["pos"])
			self:GetVehicle():SetAngles(self._savestateVEH[self.LastSlot]["angles"])
			self:GetVehicle():SetLocalVelocity(self._savestateVEH[self.LastSlot]["velocity"])
			self:GetVehicle():SetVelocity(self._savestateVEH[self.LastSlot]["velocity"])
			
			--self:GetVehicle():SetVelocity(Vector(100, 0, 0))
			--self:GetVehicle():SetLocalVelocity(Vector(100, 0, 0))
			
			-- Stop loading glitch:
			self.LastSpawn = CurTime()-5
			
			-- Tell the player:
			Notify(self, 0, 5, "Vehicle state Loaded! <needs fixing, sorry>")
			
			-- Success:
			return true
		else
			Notify(self, 1, 5, "You haven't saved a VEHICLE state!")
			return false
		end
	end
end

-- Saving + Loading:
concommand.Add( "_savepos", function(ply, cmd, args)
	ply:SaveState(math.floor(tonumber(args[1] or ply.LastSlot or 1) or 1))
end)

concommand.Add( "_getpos", function(ply, cmd, args)
	ply:LoadState(math.floor(tonumber(args[1] or ply.LastSlot or 1) or 1))
end)
