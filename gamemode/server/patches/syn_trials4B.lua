function skip_first_jump()
	PrintMessage( HUD_PRINTCENTER, "Skipping the first Jump (LOL)" )
	for k, v in pairs(player.GetAll()) do
		v:SetPos(Vector(838,-293,-400))
	end
	for k,v in pairs(ents.GetAll()) do
		if v:GetClass() == "info_player_start" or v:GetClass() == "info_player_coop_disabled" or v:GetClass() == "info_player_coop" or v:GetClass() == "info_player_deathmatch" then
			local new = ents.Create("info_player_coop_disabled")
			new:SetPos(v:GetPos())
			new:SetAngles(v:GetAngles())
			new:Spawn()
			new:SetName(v:GetName())
			v:Remove()
		end
	end
	local new = ents.Create("info_player_coop")
	new:SetPos(Vector(838,-293,-400))
	new:Spawn()
	for k, v in pairs(ents.GetAll()) do
		if v:GetName() == "rank_counter" then
			v:Fire("add",3,0)
		end
	end
end

function unlock_first_door()
	PrintMessage( HUD_PRINTCENTER, "Unlocked the first door" )
	for k, v in pairs(ents.GetAll()) do
		if v:GetName() == "rank_counter" then
			v:Fire("add",3,0)
		end
		if v:GetName() == "trial_a_button" then
			v:Fire("press",0,0)
		end
	end
end

function unlock_second_door()
	PrintMessage( HUD_PRINTCENTER, "Unlocked the second door" )
	for k, v in pairs(ents.GetAll()) do
		if v:GetName() == "rank_counter" then
			v:Fire("add",3,0)
		end
		if v:GetPos() == Vector(152,600,-409.29) then
			v:Fire("press",0,0)
		end
	end
end

function skip_crushers()
	PrintMessage( HUD_PRINTCENTER, "Skipped Trial #8 (Dodger)" )
	for k, v in pairs(ents.GetAll()) do
		if v:GetName() == "rank_counter" then
			v:Fire("add",3,0)
		end
		if v:GetName() == "trial_b_crusher4" then
			v:Remove()
		end
		if v:GetName() == "trial_b_crusher3" then
			v:Remove()
		end
		if v:GetName() == "trial_b_crusher2" then
			v:Remove()
		end
		if v:GetName() == "trial_b_crusher1" then
			v:Remove()
		end
	end
end

function skip_electric()
	PrintMessage( HUD_PRINTCENTER, "Skipped the Rlectric Room" )
	for k, v in pairs(ents.GetAll()) do
		if v:GetName() == "rank_counter" then
			v:Fire("add",3,0)
		end
		if v:GetName() == "trial_b2_trigger" then
			v:Remove()
		end
		if v:GetName() == "trial_b2_doors" then
			v:Remove()
		end
		if v:GetName() == "trial_b2_pretrigger" then
			v:Remove()
		end
		if v:GetName() == "trial_b_crusher1" then
			v:Remove()
		end
	end
end

function skip_zombie()
	PrintMessage( HUD_PRINTCENTER, "Skipped trial #9 (Zombie Gauntlet)" )
	for k, v in pairs(ents.GetAll()) do
		if v:GetName() == "rank_counter" then
			v:Fire("add",3,0)
		end
		if v:GetName() == "trial_c_zombie1" then
			v:Fire("open",0,0)
		end
		if v:GetName() == "trial_c_zombie2" then
			v:Fire("open",0,0)
		end
		if v:GetName() == "trial_c_zombie3" then
			v:Fire("open",0,0)
		end
		if v:GetName() == "trial_c_zombie4" then
			v:Fire("open",0,0)
		end
	end
end

function remove_hunter()
	PrintMessage( HUD_PRINTCENTER, "Removed the hunter" )
	for k, v in pairs(ents.GetAll()) do
		if v:GetName() == "rank_counter" then
			v:Fire("add",3,0)
		end
		if v:GetName() == "trial_c_hunter" then
			v:Remove()
		end
	end
end

function skip_slime()
	PrintMessage( HUD_PRINTCENTER, "Skipped Trial #10 (The River Of Slime)" )
	for k, v in pairs(player.GetAll()) do
		v:SetPos(Vector(-1549,63,-335))
	end
	for k,v in pairs(ents.GetAll()) do
		if v:GetClass() == "info_player_start" or v:GetClass() == "info_player_coop_disabled" or v:GetClass() == "info_player_coop" or v:GetClass() == "info_player_deathmatch" then
			local new = ents.Create("info_player_coop_disabled")
			new:SetPos(v:GetPos())
			new:SetAngles(v:GetAngles())
			new:Spawn()
			new:SetName(v:GetName())
			v:Remove()
		end
	end
	local new = ents.Create("info_player_coop")
	new:SetPos(Vector(-1549,63,-335))
	new:Spawn()
	for k, v in pairs(ents.GetAll()) do
		if v:GetName() == "rank_counter" then
			v:Fire("add",3,0)
		end
		if v:GetName() == "trial_d_door" then
			v:Remove()
		end
	end
end

function skip_dark()
	PrintMessage( HUD_PRINTCENTER, "Skipped Trial #11 (The Trials Forgotten)" )
	for k, v in pairs(player.GetAll()) do
		v:SetPos(Vector(368,-691,-160))
	end
	for k,v in pairs(ents.GetAll()) do
		if v:GetClass() == "info_player_start" or v:GetClass() == "info_player_coop_disabled" or v:GetClass() == "info_player_coop" or v:GetClass() == "info_player_deathmatch" then
			local new = ents.Create("info_player_coop_disabled")
			new:SetPos(v:GetPos())
			new:SetAngles(v:GetAngles())
			new:Spawn()
			new:SetName(v:GetName())
			v:Remove()
		end
	end
	local new = ents.Create("info_player_coop")
	new:SetPos(Vector(368,-691,-160))
	new:Spawn()
	for k, v in pairs(ents.GetAll()) do
		if v:GetName() == "rank_counter" then
			v:Fire("add",3,0)
		end
	end
end

function skip_danger()
	PrintMessage( HUD_PRINTCENTER, "Skipped Trial #12 (Invisible Danger)" )
	for k, v in pairs(ents.GetAll()) do
		if v:GetName() == "rank_counter" then
			v:Fire("add",3,0)
		end
		if v:GetPos() == Vector(1079.84,-1326.14,-161.57) then
			v:Fire("Press",0,0)
		end
	end
end



function map_patch()
	//Map gives weapons, none needed:
	puzzle_spawn_weapons = {"weapon_crowbar"}
	
	for k, v in pairs(ents.GetAll()) do
		if v:GetName() == "game_start" then
			v:Fire("trigger","",0)
		end
	end
	
	//Create some patches:
	new_patch("Skip the first Jump",skip_first_jump)
	new_patch("Unlock the first door",unlock_first_door)
	new_patch("Unlock the second door",unlock_second_door)
	new_patch("Skip Trial #8 (Dodger)",skip_crushers)
	new_patch("Skip Electric Room",skip_electric)
	new_patch("Skip Trial #9 (Zombie Gauntlet)",skip_zombie)
	new_patch("Remove the hunter(If it gets stuck)",remove_hunter)
	new_patch("Skip Trial #10 (The River Of Slime)",skip_slime)
	new_patch("Skip Trial #11 (The Trials Forgotten)",skip_dark)
	new_patch("Skip Trial #12 (Invisible Danger)",skip_danger)
	
	Spawn_Coop = true
end
