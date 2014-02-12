function map_patch()
	-- Map gives weapons, none needed:
	puzzle_spawn_weapons = {}
	
	for k, v in pairs(ents.GetAll()) do
		if v:GetName() == "maker_alien_grunt01_01" then
			v:SetKeyValue("NPCType", "npc_zombie")
		end
		
		if v:GetName() == "maker_alien_grunt01_02" then
			v:SetKeyValue("NPCType", "npc_fastzombie")
		end
		
		if v:GetName() == "maker_alien_grunt01_03" then
			v:SetKeyValue("NPCType", "npc_zombie")
		end
		
		if v:GetName() == "maker_alien_grunt01_04" then
			v:SetKeyValue("NPCType", "npc_fastzombie")
		end
		
		if v:GetName() == "maker_alien_grunt01_05" then
			v:SetKeyValue("NPCType", "npc_zombie")
		end
		
		if v:GetName() == "maker_alien_grunt01_06" then
			v:SetKeyValue("NPCType", "npc_fastzombie")
		end
		
		if v:GetName() == "maker_alien_grunt01_07" then
			v:SetKeyValue("NPCType", "npc_zombie")
		end
		
		if v:GetName() == "maker_stalker01" then
			v:SetKeyValue("NPCType", "npc_fastzombie")
		end
		
		if v:GetName() == "maker_stalker02" then
			v:SetKeyValue("NPCType", "npc_fastzombie")
		end
		
		if v:GetName() == "maker_me3_npc" then
			v:SetKeyValue("NPCType", "npc_fastzombie")
		end
	end
	
	Spawn_Coop = true
end
