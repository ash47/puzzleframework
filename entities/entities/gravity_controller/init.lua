ENT.Base = "base_brush"
ENT.Type = "brush"

function ENT:Initialize()
	self.Entity.gravity = self.Entity.gravity or 1
	self.Entity.Start = self.Entity.Start or 1
	self.Entity.End = self.Entity.End or 1
end

function ENT:AcceptInput( name, activator, caller, data )
	if ( string.lower(name) == "start" ) then
		if data == "!activator" then
			activator:SetGravity(self.Entity.gravity )
		end
	end
	if ( string.lower(name) == "end" ) then
		if data == "!activator" then
			activator:SetGravity(1)
		end
	end
	return false
end


function ENT:KeyValue( key, value )
	if ( key == "targetname" ) then
		self.Entity:SetName(value)
	end
	if ( key == "gravity" ) then
		self.Entity.gravity = tonumber(value)
	end
	if ( key == "start" ) then
		self.Entity.Start = tonumber(value)
	end
	if ( key == "end" ) then
		self.Entity.End = tonumber(value)
	end
end

function ENT:StartTouch( ent )
	if ent:IsValid() then
		if self.Entity.Start == 1 then
			ent:SetGravity(self.Entity.gravity)
		end
	end
end

function ENT:EndTouch( ent )
	if ent:IsValid() then
		if self.Entity.End == 1 then
			ent:SetGravity(1)
		end
	end
end
