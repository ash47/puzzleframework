function patch_puz1()
	PrintMessage( HUD_PRINTCENTER, "Skipped World 1-1" )
	for k, v in pairs(ents.GetAll()) do
		if v:GetName() == "puzzle1_number_done" then
			v:Fire("Enable","",0)
		end
		if v:GetName() == "puzzle1_number" then
			v:Fire("Disable","",0)
		end
		if v:GetName() == "puzzles_done" then
			v:Fire("Add","1",0)
		end
		if v:GetPos() == Vector(13244,9616,1608) then
			v:Remove()
		end
	end
end

function patch_puz2()
	PrintMessage( HUD_PRINTCENTER, "Skipped World 1-2" )
	for k, v in pairs(ents.GetAll()) do
		if v:GetName() == "puzzle2_number_done" then
			v:Fire("Enable","",0)
		end
		if v:GetName() == "puzzle2_number" then
			v:Fire("Disable","",0)
		end
		if v:GetName() == "puzzles_done" then
			v:Fire("Add","1",0)
		end
		if v:GetPos() == Vector(6067.5,-784,-432) then
			v:Remove()
		end
	end
end

function patch_puz3()
	PrintMessage( HUD_PRINTCENTER, "Skipped World 1-3" )
	for k, v in pairs(ents.GetAll()) do
		if v:GetName() == "puzzle3_number_done" then
			v:Fire("Enable","",0)
		end
		if v:GetName() == "puzzle3_number" then
			v:Fire("Disable","",0)
		end
		if v:GetName() == "puzzles_done" then
			v:Fire("Add","1",0)
		end
		if v:GetPos() == Vector(4288,-9472,1156) then
			v:Remove()
		end
	end
end

function patch_puz4()
	PrintMessage( HUD_PRINTCENTER, "Skipped World 1-4" )
	for k, v in pairs(ents.GetAll()) do
		if v:GetName() == "puzzle4_number_done" then
			v:Fire("Enable","",0)
		end
		if v:GetName() == "puzzle4_number" then
			v:Fire("Disable","",0)
		end
		if v:GetName() == "puzzles_done" then
			v:Fire("Add","1",0)
		end
		if v:GetPos() == Vector(12288,-5508,-1944) then
			v:Remove()
		end
	end
end

function patch_puz5()
	PrintMessage( HUD_PRINTCENTER, "Skipped World 1-5" )
	for k, v in pairs(ents.GetAll()) do
		if v:GetName() == "puzzle5_number_done" then
			v:Fire("Enable","",0)
		end
		if v:GetName() == "puzzle5_number" then
			v:Fire("Disable","",0)
		end
		if v:GetName() == "puzzles_done" then
			v:Fire("Add","1",0)
		end
		if v:GetPos() == Vector(-9984,-10496,5976) then
			v:Remove()
		end
	end
end

function patch_puz6()
	PrintMessage( HUD_PRINTCENTER, "Skipped World 1-6" )
	for k, v in pairs(ents.GetAll()) do
		if v:GetName() == "puzzle6_number_done" then
			v:Fire("Enable","",0)
		end
		if v:GetName() == "puzzle6_number" then
			v:Fire("Disable","",0)
		end
		if v:GetName() == "puzzles_done" then
			v:Fire("Add","1",0)
		end
		if v:GetPos() == Vector(-7444,9428,176) then
			v:Remove()
		end
	end
end

function map_patch()
	-- Map gives weapons, none needed:
	puzzle_spawn_weapons = {}
	
	-- Create some patches:
	new_patch("Skip World 1-1",patch_puz1)
	new_patch("Skip World 1-2",patch_puz2)
	new_patch("Skip World 1-3",patch_puz3)
	new_patch("Skip World 1-4",patch_puz4)
	new_patch("Skip World 1-5",patch_puz5)
	new_patch("Skip World 1-6",patch_puz6)
	
	for k, v in pairs(ents.GetAll()) do
		if v:GetPos() == Vector(-9912,-10992,5604) then
			v:Remove()
		end
		if v:GetPos() == Vector(-10336,-10744,5764) then
			v:Remove()
		end
	end
	
	-- Create some entities to keep track of score:
	NewTracker("puzzle1_text")
	NewTracker("puzzle2_text")
	NewTracker("puzzle3_text")
	NewTracker("puzzle4_text")
	NewTracker("puzzle5_text")
	NewTracker("puzzle6_text")
end
