ENT.Base = "base_brush"
ENT.Type = "brush"

function ENT:Initialize()
	self.Entity.inside = 0
end

function ENT:KeyValue( key, value )
	if ( key == "PlayerValue" ) then
		self.Entity.percent = tonumber(value)
	end
	if ( key == "CountType" ) then
		self.Entity.mode = tonumber(value)
	end
	if string.lower(string.sub(key, 1, 2)) == "on" then
		self:StoreOutput( key, value )
	end
end

function ENT:StartTouch( ent )
	if ent:IsPlayer() and ent:IsValid() then
		self.Entity.inside=self.Entity.inside+1
		if self.Entity.mode == 1 then
			if self.Entity.inside/(#player.GetAll())*100>=self.Entity.percent then
				self:TriggerOutput( "OnPlayersIn", ent )
			end
		else
			if self.Entity.inside>=self.Entity.percent then
				self:TriggerOutput( "OnPlayersIn", ent )
			end
		end
	end
end

function ENT:EndTouch( ent )
	if ent:IsPlayer() and ent:IsValid() then
		self.Entity.inside=self.Entity.inside-1
	end
end