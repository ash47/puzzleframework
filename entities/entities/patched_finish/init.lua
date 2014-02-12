ENT.Type = "point"

function ENT:Initialize()
end

function ENT:AcceptInput( name, activator, caller, data )
	if ( string.lower(name) == "endgame" ) then
		FinishMap()
		return true
	end
	if ( string.lower(name) == "command" ) then
		local txt = string.Explode(" ",data)
		if txt[1] == "changelevel" then
			DB.FinshMap()
			timer.Simple(0.1, function()
				RunConsoleCommand("changelevel",txt[2])
			end)
			--timer.Simple(3, MapVote) // Backup
		end
		return true
	end
	return false
end
