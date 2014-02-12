ENT.Type = "point"

function ENT:Initialize()
end

function ENT:KeyValue( key, value )
	if ( string.lower(key) == "timertext" ) then
		self.Entity.text = value
	end
end

function ENT:AcceptInput( name, activator, caller, data )
	if ( string.lower(name) == "start" ) then
		data = tonumber(data)
		if data>0 then
			hud_timer = CurTime()+data
			hud_text = self.Entity.text
			umsg.Start("hud_timer")
			umsg.Long(data)
			umsg.String(hud_text)
			umsg.End()
		end
		return true
	end
	return false
end
