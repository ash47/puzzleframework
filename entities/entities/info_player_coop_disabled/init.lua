ENT.Type = "point"

function ENT:Initialize()
end

function ENT:AcceptInput( name, activator, caller, data )
	if ( name == "Enable" ) then
		local new = ents.Create("info_player_coop")
		new:SetPos(self.Entity:GetPos())
		new:SetAngles(self.Entity:GetAngles())
		new:Spawn()
		new:SetName(self.Entity:GetName())
		self.Entity:Remove()
		return true
	end
	return false
	
end
