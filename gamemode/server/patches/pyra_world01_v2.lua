function map_patch()
	//Map gives weapons, none needed:
	puzzle_spawn_weapons = {"weapon_physcannon","weapon_crowbar","weapon_smg1","weapon_pistol"}
	
	for k, v in pairs(ents.GetAll()) do
		if v:GetClass() == "info_player_deathmatch" then
			v:Remove()
		end
		if v:GetClass() == "info_player_start" then
			if v:GetPos() ~= Vector(672,-672,-887) then
				v:Remove()
			end
		end
		if v:GetName() == "door1_p3" then
			v:Remove()
		end
		if v:GetPos() == Vector(32,2624,-536) then
			v:Remove()
		end
		if v:GetName() == "door_end_p1" then
			v:Remove()
		end
		if v:GetName() == "break1_p2" then
			v:Remove()
		end
		if v:GetName() == "break3_p2" then
			v:Remove()
		end
	end
	
	Spawn_Coop = true
end
