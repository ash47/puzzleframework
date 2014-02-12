ENT.Type = "point"

function ENT:Initialize()
end

function ENT:KeyValue( key, value )
end

function ENT:AcceptInput( name, activator, caller, data )
	if ( name == "Disable" ) then
		local new = ents.Create("info_player_coop_disabled")
		new:SetPos(self.Entity:GetPos())
		new:SetAngles(self.Entity:GetAngles())
		new:Spawn()
		new:SetName(self.Entity:GetName())
		self.Entity:Remove()
		return true
	end
	
	if ( name == "SetCheckPoint" ) then
		for k,v in pairs(ents.GetAll()) do
			if v:GetClass() == "info_player_start" or v:GetClass() == "info_player_coop_disabled" or v:GetClass() == "info_player_coop" or v:GetClass() == "info_player_deathmatch" then
				if v:GetName() ~= data then
					local new = ents.Create("info_player_coop_disabled")
					new:SetPos(v:GetPos())
					new:SetAngles(v:GetAngles())
					new:Spawn()
					new:SetName(v:GetName())
					v:Remove()
				else
					local new = ents.Create("info_player_coop")
					new:SetPos(v:GetPos())
					new:SetAngles(v:GetAngles())
					new:Spawn()
					new:SetName(v:GetName())
					v:Remove()
				end
			end
		end
	end
	
	if ( name == "TeleportPlayers" ) then
		//Find the teleport:
		local ent = false
		for k,v in pairs(ents.GetAll()) do
			if v:GetName() == data then
				ent = v
			end
		end
		
		//Teleport the players:
		if ent then
			for k,v in pairs(player.GetAll()) do
				v:SetPos(ent:GetPos())
			end
		end
	end
end
