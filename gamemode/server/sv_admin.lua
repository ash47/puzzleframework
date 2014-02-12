--[[
server/sv_admin.lua

 - Admin related stuff
]]--

-- Noclipping:
function GM:PlayerNoClip( ply )
	return ply:IsAdmin()
end

-- Give:
concommand.Add( "_give", function( ply, cmd, args )
	if not ply:IsAdmin() then return end
	ply:Give(args[1])
end )

-- Remover:
concommand.Add( "_remove", function( ply, cmd, args )
	if not ply:IsAdmin() then return end
	local vStart = ply:GetShootPos() 
	local vForward = ply:GetAimVector()
	
	local pos = ply:GetShootPos()
	local ang = ply:GetAimVector()
	local tracedata = {}
	tracedata.start = pos
	tracedata.endpos = pos+(ang*80)
	tracedata.filter = ply
	local tr = util.TraceLine(tracedata)
	
	if tr.Entity:IsValid() then
		tr.Entity:Remove()
	end
end)

concommand.Add("tempAir", function(ply,cmdargs)
	if not ply:IsAdmin() then return end
	
	for k, v in pairs(ents.GetAll()) do
		if(v:GetClass() == "prop_vehicle_airboat") then
			-- Build new ones:
			local new = ents.Create(v:GetClass())
			new:SetName(v:GetName())
			new:SetModel(v:GetModel())
			new:SetPos(v:GetPos())
			new:SetAngles(v:GetAngles())
			for kk, vv in pairs(v:GetKeyValues()) do
				new:SetKeyValue(kk, vv)
			end
			new:SetKeyValue("VehicleScript", "scripts/vehicles/temp.txt")
			new:Spawn()
			new:Activate()
			
			-- Remove the old one:
			v:Remove()
		end
	end
end)

concommand.Add("spawnAirBoat", function(ply,cmdargs)
	if not ply:IsAdmin() then return end
	
	for k, v in pairs(ents.GetAll()) do
		if(v:GetClass() == "prop_vehicle_airboat") then
			for kk,vv in pairs(player.GetAll()) do
				if(not vv:GetVehicle():IsValid()) then
					-- Build new ones:
					local new = ents.Create(v:GetClass())
					new:SetName(v:GetName())
					new:SetModel(v:GetModel())
					new:SetPos(vv:GetPos())
					new:SetAngles(vv:GetAngles())
					for kk, vv in pairs(v:GetKeyValues()) do
						new:SetKeyValue(kk, vv)
					end
					new:SetKeyValue("VehicleScript", "scripts/vehicles/temp.txt")
					new:Spawn()
					new:Activate()
				end
			end
			
			return
		end
	end
end)
