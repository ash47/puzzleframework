--[[
server/sv_menu.lua

 - Menu related stuff
]]--

local meta = FindMetaTable("Player")

function meta:Menu(tab)
	net.Start("Menu")
	net.WriteInt(tab, 4)
	net.Send(self)
end

VotesNextMap = false

net.Receive("nextmap", function(len, ply)
	-- Stop general spam:
	if VotesNextMap then
		ply:Notify(1, 5, "Please wait for the current vote to finish.")
		return
	end
	
	-- Stop spam:
	if ply.VoteNextMap and ply.VoteNextMap > CurTime() then
		ply.VoteNextMap = ply.VoteNextMap+10
		ply:Notify(1, 5, "Please wait "..math.ceil(ply.VoteNextMap-CurTime()).." seconds before trying again.")
		return
	end
	
	-- Create the vote:
	VoteCreate({
	question = ply:Nick().." wants to move onto the next map.\n\nDo you want to skip to the next map?",
	default = false,
	callback = function(results)
		-- Finish voting:
		VotesNextMap = false
		ply.VoteNextMap = CurTime()+120
		
		if results.passed then
			NotifyAll(0, 5, "The vote to change maps has passed. Changing maps...")
			
			-- Change maps:
			timer.Simple(3, function()
				SkipMap()
			end)
		else
			NotifyAll(1, 5, "The vote to change maps has FAILED.")
		end
	end
	})
	
	-- Tell the player the request has been sent:
	ply:Notify(0, 5, "The vote has been created!")
end)

function meta:Goto(req)
	-- Validate the entity:
	if (not IsValid(req)) or (not req:IsPlayer()) then return end
	
	-- Check if it's the player:
	if self == req then
		self:Notify(1, 5, "Try going to someone else...")
		return
	end
	
	-- Check if the request was already sent:
	req.gotoRequests = req.gotoRequests or {}
	
	-- Stop spam etc:
	if req.gotoRequests[self] then
		if req.gotoRequests[self] == -1 then
			self:Notify(1, 5, "Please allow them time to respond to the request.")
			return
		elseif CurTime() < req.gotoRequests[self] then
			req.gotoRequests[self] = req.gotoRequests[self]+10
			self:Notify(1, 5, "Please wait another "..math.ceil(req.gotoRequests[self] - CurTime()).." seconds before asking again!")
			return
		end
	end
	
	local nick = req:Nick()
	
	-- Create the vote:
	VoteCreate({
	passrate = 1,
	passextra = 1,	-- 100% pass rate (one person voting)
	private = {req},
	question = "Do you want to allow "..self:Nick().." to teleport to you?",
	default = false,
	callback = function(results)
		-- No point continuing if the player isn't valid:
		if not self:IsValid() then return end
		
		if results.passed then
			if req:IsValid() then
				-- Do the teleport:
				self:SetGravity(req:GetGravity())
				self:SetVelocity(req:GetVelocity())
				self:SetPos(req:GetPos())
				self:SetEyeAngles(req:EyeAngles())
				self:SetAngles(req:GetAngles())
				self:StripWeapons()
				self:RemoveAllAmmo()
				
				for k,v in pairs(req:GetWeapons()) do
					local wep = self:Give(v:GetClass())
					self:SetAmmo(req:GetAmmoCount(v:GetPrimaryAmmoType()), v:GetPrimaryAmmoType())
					self:SetAmmo(req:GetAmmoCount(v:GetSecondaryAmmoType()), v:GetSecondaryAmmoType())
					wep:SetClip1(v:Clip1())
					wep:SetClip2(v:Clip2())
				end
				
				if IsValid(req:GetActiveWeapon()) then
					self:SelectWeapon(req:GetActiveWeapon():GetClass())
				end
				
				-- Allow them to teleport again:
				req.gotoRequests[self] = nil
			else
				-- Player has disconnected:
				self:Notify(1, 5, "Teleport failed, "..nick.." appears to have disconnected.")
			end
		else
			-- Player declined the teleport request:
			self:Notify(1, 5, nick.." has declined your teleport request. Please wait 60 seconds before trying again.")
			req.gotoRequests[self] = CurTime() + 60
		end
	end
	})
	
	-- Stop spam:
	req.gotoRequests[self] = -1
	
	-- Tell the player the request has been sent:
	self:Notify(0, 5, "Request has been sent...")
end

net.Receive("goto", function(len, ply)
	-- Goto that player:
	ply:Goto(net.ReadEntity())
end)

net.Receive("kick", function(len, ply)
	-- Grab the entity:
	local req = net.ReadEntity()
	
	-- Grab the reason:
	local reason = net.ReadString()
	
	-- Stop BS:
	if reason == "No reason." then return end
	if string.len(reason) < 10 then return end
	
	-- Validate the entity:
	if (not IsValid(req)) or (not req:IsPlayer()) then return end
	
	-- Check if it's the player:
	if ply == req then
		ply:Notify(1, 5, "You want to kick yourself?")
		return
	end
	
	-- Check if the request was already sent:
	req.kickRequest = req.gotoRequest or false
	
	if req.KickRequest then
		if req.KickRequest == -1 then
			ply:Notify(1, 5, "There is still a vote in progress to kick/ban this player.")
			return
		elseif CurTime() < req.KickRequest then
			ply:Notify(1, 5, "Please wait another "..math.ceil(req.KickRequest - CurTime()).." seconds before asking again!")
			return
		end
	end
	
	local nick = req:Nick()
	
	-- Log it:
	DB.Log("VOTEKICK: "..ply:Nick().." ("..(ply:SteamID() or "")..")".." - "..req:Nick().." ("..(req:SteamID() or "")..") "..reason)
	
	-- Create the vote:
	VoteCreate({
	question = ply:Nick().." wants to kick "..req:Nick().." with the reason '"..reason.."'.\n\nDo you want to kick "..req:Nick().."?",
	default = false,
	callback = function(results)
		-- No point continuing if the player isn't valid:
		if not ply:IsValid() then return end
		
		if results.passed then
			if req:IsValid() then
				-- Log it:
				DB.Log("KICK: "..req:Nick().." ("..(req:SteamID() or "")..") "..reason)
				
				-- Do it:
				req:Kick(reason)
				NotifyAll(0, 5, nick.." has been kicked!")
			else
				-- Log it:
				DB.Log("LOLKICK: "..req:Nick().." ("..(req:SteamID() or "")..") "..reason)
				
				-- Player has disconnected:
				NotifyAll(0, 5, nick.." has left the server on their own terms.")
			end
		else
			-- Log it:
			DB.Log("FAILKICK: "..req:Nick().." ("..(req:SteamID() or "")..") "..reason)
			
			-- Vote Failed:
			NotifyAll(1, 5, "The vote to kick "..nick.." has failed to get enough votes!")
			req.KickRequest = CurTime() + 60
		end
	end
	})
	
	-- Stop spam:
	req.KickRequest = -1
	
	-- Tell the player the request has been sent:
	ply:Notify(0, 5, "The vote has been created.")
end)

net.Receive("ban", function(len, ply)
	-- Grab the entity:
	local req = net.ReadEntity()
	
	-- Grab the reason:
	local reason = net.ReadString()
	
	-- Stop BS:
	if reason == "No reason." then return end
	if string.len(reason) < 10 then return end
	
	-- Validate the entity:
	if (not IsValid(req)) or (not req:IsPlayer()) then return end
	
	-- Check if it's the player:
	if ply == req then
		ply:Notify(1, 5, "You want to ban yourself?")
		return
	end
	
	-- Check if the request was already sent:
	req.kickRequest = req.gotoRequest or false
	
	if req.KickRequest then
		if req.KickRequest == -1 then
			ply:Notify(1, 5, "There is still a vote in progress to kick/ban this player.")
			return
		elseif CurTime() < req.KickRequest then
			ply:Notify(1, 5, "Please wait another "..math.ceil(req.KickRequest - CurTime()).." seconds before asking again!")
			return
		end
	end
	
	local nick = req:Nick()
	
	-- Log it:
	DB.Log("VOTEBAN: "..ply:Nick().." ("..(ply:SteamID() or "")..")".." - "..req:Nick().." ("..(req:SteamID() or "")..") "..reason)
	
	-- Create the vote:
	VoteCreate({
	question = ply:Nick().." wants to BAN "..req:Nick().." with the reason '"..reason.."'.\n\nDo you want to BAN "..req:Nick().."?",
	default = false,
	callback = function(results)
		-- No point continuing if the player isn't valid:
		if not ply:IsValid() then return end
		
		if results.passed then
			if req:IsValid() then
				-- Log it:
				DB.Log("BAN: "..req:Nick().." ("..(req:SteamID() or "")..") "..reason)
				
				req:Ban(60, reason)
				req:Kick(reason)
				NotifyAll(0, 5, nick.." has been banned!")
			else
				-- Log it:
				DB.Log("BANDODGE: "..req:Nick().." ("..(req:SteamID() or "")..") "..reason)
				
				-- Player has disconnected:
				NotifyAll(0, 5, nick.." has left the server on their own terms. <I plan on adding a banning thing here>")
			end
		else
			-- Log it:
			DB.Log("FAILBAN: "..req:Nick().." ("..(req:SteamID() or "")..") "..reason)
			
			-- Vote Failed:
			NotifyAll(1, 5, "The vote to ban "..nick.." has failed to get enough votes!")
			req.KickRequest = CurTime() + 120
		end
	end
	})
	
	-- Stop spam:
	req.KickRequest = -1
	
	-- Tell the player the request has been sent:
	ply:Notify(0, 5, "The vote has been created.")
end)