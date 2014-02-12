function map_patch()
	puzzle_spawn_weapons = {"weapon_physcannon","weapon_crowbar","weapon_smg1"}
	
	for k, v in pairs(ents.GetAll()) do
		if v:GetName() == "door_7" then
			v:Remove()
		end
		
		if v:GetName() == "door_13" then
			v:Remove()
		end
		
		if v:GetPos() == Vector(-122,181,1904) then
			v:Remove()
		end
		
		if v:GetPos() == Vector(-130,181,1886) then
			v:Remove()
		end
	end
	
	Spawn_Coop = true
end
