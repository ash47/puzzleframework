function open_door()
	PrintMessage( HUD_PRINTCENTER, "Exploded the first door" )
	for k, v in pairs(ents.GetAll()) do
		if v:GetName() == "rank_counter" then
			v:Fire("add",3,0)
		end
		if v:GetName() == "dynamite_physbox" then
			v:SetPos(Vector(1391,-705,72))
		end
		if v:GetName() == "dynamite_button" then
			v:Fire("press",0,0)
		end
	end
end

function open_keycard()
	PrintMessage( HUD_PRINTCENTER, "Opened the keypad door" )
	for k, v in pairs(ents.GetAll()) do
		if v:GetName() == "rank_counter" then
			v:Fire("add",3,0)
		end
		if v:GetName() == "trial_a_door" then
			v:Fire("Open",0,0)
		end
	end
end

function skip_dive()
	PrintMessage( HUD_PRINTCENTER, "Skipped Trial #14 (Dive Dive Dive)" )
	for k, v in pairs(ents.GetAll()) do
		if v:GetName() == "rank_counter" then
			v:Fire("add",3,0)
		end
		if v:GetPos() == Vector(84,-1331,-523) then
			v:Fire("Press",0,0)
		end
		if v:GetPos() == Vector(-284,-1316.46,-520.46) then
			v:Fire("Trigger",0,0)
		end
		if v:GetName() == "trial_a_keybox2" then
			v:SetPos(Vector(-284,-1316.46,-520.46))
		end
	end
end

function skip_mines()
	PrintMessage( HUD_PRINTCENTER, "Skipped Trial #15 (Mines and Soda)" )
	for k, v in pairs(player.GetAll()) do
		v:SetPos(Vector(-74,-4359,-355))
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
	new:SetPos(Vector(-74,-4359,-355))
	new:Spawn()
	for k, v in pairs(ents.GetAll()) do
		if v:GetName() == "rank_counter" then
			v:Fire("add",3,0)
		end
	end
end

function skip_trains()
	PrintMessage( HUD_PRINTCENTER, "Skipped Trial #16 (The Train Trial)" )
	for k, v in pairs(ents.GetAll()) do
		if v:GetName() == "rank_counter" then
			v:Fire("add",3,0)
		end
		if v:GetPos() == Vector(-1771.54,-4378,-360.55) then
			v:Fire("Trigger",0,0)
		end
		if v:GetName() == "trial_c_keybox" then
			v:SetPos(Vector(-1771.54,-4378,-360.55))
		end
	end
end

function skip_masterkey()
	PrintMessage( HUD_PRINTCENTER, "Skipped Trial #17 (The Master Key), you fucking noobs!" )
	for k, v in pairs(player.GetAll()) do
		v:SetPos(Vector(1696,253,-255))
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
	new:SetPos(Vector(1696,253,-255))
	new:Spawn()
	for k, v in pairs(ents.GetAll()) do
		if v:GetName() == "rank_counter" then
			v:Fire("add",3,0)
		end
		if v:GetPos() == Vector(1698,408.1,-258) then
			v:Fire("Trigger",0,0)
		end
		if v:GetName() == "trial_d_bust" then
			v:SetPos(Vector(1698,408.1,-258))
		end
	end
end

function skip_code()
	PrintMessage( HUD_PRINTCENTER, "Skipped the code" )
	for k, v in pairs(ents.GetAll()) do
		if v:GetName() == "rank_counter" then
			v:Fire("add",3,0)
		end
		if v:GetName() == "trial_d_math" then
			v:Fire("SetValue",220,0)
		end
	end
end

function skip_void()
	PrintMessage( HUD_PRINTCENTER, "Skipped Trial #19 (Into the Void)" )
	for k, v in pairs(player.GetAll()) do
		v:SetPos(Vector(2142,1931,-265))
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
	new:SetPos(Vector(2142,1931,-265))
	new:Spawn()
	for k, v in pairs(ents.GetAll()) do
		if v:GetName() == "rank_counter" then
			v:Fire("add",3,0)
		end
	end
end

function skip_maze()
	PrintMessage( HUD_PRINTCENTER, "Skipped the maze" )
	for k, v in pairs(player.GetAll()) do
		v:SetPos(Vector(2560.8,3055.2,-266))
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
	new:SetPos(Vector(2560.8,3055.2,-266))
	new:Spawn()
	for k, v in pairs(ents.GetAll()) do
		if v:GetName() == "rank_counter" then
			v:Fire("add",3,0)
		end
	end
end

function skip_barrels()
	PrintMessage( HUD_PRINTCENTER, "Skipped Trial #20 (Barrels Of Fun)" )
	for k, v in pairs(ents.GetAll()) do
		if v:GetName() == "rank_counter" then
			v:Fire("add",3,0)
		end
		if v:GetName() == "trial_f_pass" then
			v:Fire("Trigger",0,0)
		end
	end
end

function skip_building()
	PrintMessage( HUD_PRINTCENTER, "Skipped Trial #21 (Building with Boxes)" )
	for k, v in pairs(ents.GetAll()) do
		if v:GetName() == "rank_counter" then
			v:Fire("add",3,0)
		end
		if v:GetName() == "trial_g_exit" then
			v:Fire("Open",0,0)
		end
	end
end

function skip_bat()
	PrintMessage( HUD_PRINTCENTER, "Opened the Battery Door" )
	for k, v in pairs(ents.GetAll()) do
		if v:GetName() == "rank_counter" then
			v:Fire("add",3,0)
		end
		if v:GetName() == "trial_h_counter" then
			v:Fire("Add",3,0)
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
		if v:GetName() == "intro_relay_end" then
			v:Fire("trigger","",0)
		end
		if string.lower(string.sub(v:GetName(), 1, 5)) == "on" == "intro" then
			v:Remove()
		end
		if v:GetName() == "prelude_constraint" then
			v:Fire("break","",0)
		end
		if v:GetName() == "trial_h_clip" then
			v:Remove()
		end
		if v:GetName() == "trial_h_clip" then
			v:Remove()
		end
		if v:GetName() == "trial_h_entrance" then
			v:Remove()
		end
		if v:GetName() == "game_cp1" then
			v:Remove()
		end
		if v:GetName() == "intro_equip" then
			v:Remove()
		end
		if v:GetName() == "intro_relay_end" then
			v:Remove()
		end
		if v:GetName() == "prelude_stripper" then
			v:Remove()
		end
		if v:GetClass() == "info_player_start" or v:GetClass() == "info_player_coop_disabled" or v:GetClass() == "info_player_coop" or v:GetClass() == "info_player_deathmatch" then
			if v:GetName() ~= "game_cp2" then
				local new = ents.Create("info_player_coop_disabled")
				new:SetPos(v:GetPos())
				new:SetAngles(v:GetAngles())
				new:Spawn()
				new:SetName(v:GetName())
				v:Remove()
			else
				local new = ents.Create("info_player_coop")
				new:SetPos(v:GetPos())
				new:SetAngles(v:GetAngles())
				new:Spawn()
				new:SetName(v:GetName())
				v:Remove()
			end
		end
	end
	
	timer.Simple(3,function()
		for k, v in pairs(ents.GetAll()) do
			if string.lower(string.sub(v:GetName(), 1, 5)) == "intro" then
				v:Remove()
			end
		end
		for k, v in pairs(ents.GetAll()) do
			if v:GetClass() == "info_player_start" or v:GetClass() == "info_player_coop_disabled" or v:GetClass() == "info_player_coop" or v:GetClass() == "info_player_deathmatch" then
				if v:GetName() ~= "game_cp2" then
					local new = ents.Create("info_player_coop_disabled")
					new:SetPos(v:GetPos())
					new:SetAngles(v:GetAngles())
					new:Spawn()
					new:SetName(v:GetName())
					v:Remove()
				else
					local new = ents.Create("info_player_coop")
					new:SetPos(v:GetPos())
					new:SetAngles(v:GetAngles())
					new:Spawn()
					new:SetName(v:GetName())
					v:Remove()
				end
			end
		end
	end)
	
	//Create some patches:
	new_patch("Open the first door (Explode It)",open_door)
	new_patch("Open the keypad door",open_keycard)
	new_patch("Skip Trial #14 (Dive Dive Dive)",skip_dive)
	new_patch("Skip Trial #15 (Mines and Soda)",skip_mines)
	new_patch("Skip Trial #16 (The Train Trial)",skip_trains)
	new_patch("Skip Trial #17 (The Master Key) (Makes you a fucking noob)",skip_masterkey)
	new_patch("Skip the Code",skip_code)
	new_patch("Skip Trial #19 (Into the Void)",skip_void)
	new_patch("Skip the Maze",skip_maze)
	new_patch("Skip Trial #20 (Barrels Of Fun)",skip_barrels)
	new_patch("Skip Trial #21 (Building with Boxes)",skip_building)
	new_patch("Open the Battery Door",skip_bat)
	
	Spawn_Coop = true
end
