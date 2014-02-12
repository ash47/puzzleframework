function patch_elevator()
	PrintMessage( HUD_PRINTCENTER, "Dropped Lift" )
	for k, v in pairs(ents.GetAll()) do
		if v:GetPos() == Vector(1680,-744,552) then
			v:Fire("Break","",0)
		end
		if v:GetName() == "rank_counter" then
			v:Fire("add",3,0)
		end
	end
end

function skip_jumping()
	PrintMessage( HUD_PRINTCENTER, "Skipped 'Making You Jump'" )
	for k, v in pairs(player.GetAll()) do
		v:SetPos(Vector(2190.35,-290.23,-831))
	end
	for k, v in pairs(ents.GetAll()) do
		if v:GetName() == "rank_counter" then
			v:Fire("add",3,0)
		end
	end
end

function skip_squares()
	PrintMessage( HUD_PRINTCENTER, "Skipped 'Surreal Squares'" )
	for k, v in pairs(player.GetAll()) do
		v:SetPos(Vector(2913,-490,-704))
	end
	for k, v in pairs(ents.GetAll()) do
		if v:GetName() == "rank_counter" then
			v:Fire("add",3,0)
		end
	end
end

function skip_maze()
	PrintMessage( HUD_PRINTCENTER, "Skipped 'Water Maze'" )
	for k, v in pairs(player.GetAll()) do
		v:SetPos(Vector(4360.35,-920.75,-1151))
	end
	for k, v in pairs(ents.GetAll()) do
		if v:GetName() == "rank_counter" then
			v:Fire("add",3,0)
		end
	end
end

function skip_crusher()
	PrintMessage( HUD_PRINTCENTER, "Skipped 'The Crusher'" )
	for k, v in pairs(player.GetAll()) do
		v:SetPos(Vector(5385,94.69,-831))
	end
	for k, v in pairs(ents.GetAll()) do
		if v:GetName() == "rank_counter" then
			v:Fire("add",3,0)
		end
	end
end

function skip_columns()
	PrintMessage( HUD_PRINTCENTER, "Skipped 'Columns'" )
	for k, v in pairs(player.GetAll()) do
		v:SetPos(Vector(6705.44,1526.33,-832))
	end
	for k, v in pairs(ents.GetAll()) do
		if v:GetName() == "rank_counter" then
			v:Fire("add",3,0)
		end
	end
end

function skip_calc()
	PrintMessage( HUD_PRINTCENTER, "Skipped 'Calculated Demise'" )
	for k, v in pairs(ents.GetAll()) do
		if v:GetName() == "trial_h_counter" then
			v:Fire("add",100,0)
		end
		if v:GetName() == "rank_counter" then
			v:Fire("add",3,0)
		end
	end
	
end

function skip_combine()
	PrintMessage( HUD_PRINTCENTER, "Skipped 'The Combine Climb'" )
	for k, v in pairs(player.GetAll()) do
		v:SetPos(Vector(7092.08,3142.33,-1615))
	end
	for k, v in pairs(ents.GetAll()) do
		if v:GetName() == "rank_counter" then
			v:Fire("add",3,0)
		end
	end
end

function map_patch()
	//Map gives weapons, none needed:
	puzzle_spawn_weapons = {"weapon_crowbar"}
	
	for k, v in pairs(ents.GetAll()) do
		if v:GetName() == "game_cp0" then
			v:Remove()
		end
		if v:GetName() == "game_script" then
			v:Remove()
		end
		if v:GetClass() == "npc_helicopterz" then
			v:Remove()
		end
		if v:GetClass() == "npc_combinedropship" then
			v:Remove()
		end
		if v:GetName() == "intro_gman" then
			v:Remove()
		end
	end
	timer.Simple(3,function()
		for k, v in pairs(ents.GetAll()) do
			if string.lower(string.sub(v:GetName(), 1, 5)) == "intro" then
				v:Remove()
			end
		end
	end)
	
	//Create some patches:
	new_patch("Drop the lift (At The Start)",patch_elevator)
	new_patch("Skip Trial #1 (Making You Jump)",skip_jumping)
	new_patch("Skip Trial #2 (Surreal Squares)",skip_squares)
	new_patch("Skip Trial #3 (Water Maze)",skip_maze)
	new_patch("Skip Trial #4 (The Crusher)",skip_crusher)
	new_patch("Skip Trial #5 (Columns)",skip_columns)
	new_patch("Skip Trial #6 (Calculated Demise)",skip_calc)
	new_patch("Skip Trial #7 (The Combine Climb)",skip_combine)
	
	Spawn_Coop = true
end
