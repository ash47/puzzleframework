function patch_puz1()
	PrintMessage( HUD_PRINTCENTER, "Skipped puzzle #1" )
	for k, v in pairs(ents.GetAll()) do
		if v:GetName() == "tube_glass" then
			v:Fire("Break","",0)
		end
		if v:GetName() == "light1" then
			v:Fire("TurnOn","",0)
		end
	end
end

function patch_puz2()
	PrintMessage( HUD_PRINTCENTER, "Skipped puzzle #2" )
	for k, v in pairs(ents.GetAll()) do
		if v:GetName() == "tube_glass2" then
			v:Fire("Break","",0)
		end
		if v:GetName() == "light2" then
			v:Fire("TurnOn","",0)
		end
	end
end

function patch_puz3()
	PrintMessage( HUD_PRINTCENTER, "Skipped puzzle #3" )
	for k, v in pairs(ents.GetAll()) do
		if v:GetName() == "tube_glass3" then
			v:Fire("Break","",0)
		end
		if v:GetName() == "light3" then
			v:Fire("TurnOn","",0)
		end
	end
end

function patch_puz4()
	PrintMessage( HUD_PRINTCENTER, "Skipped puzzle #4" )
	for k, v in pairs(ents.GetAll()) do
		if v:GetName() == "tube_glass4" then
			v:Fire("Break","",0)
		end
		if v:GetName() == "light4" then
			v:Fire("TurnOn","",0)
		end
	end
end

function patch_puz5()
	PrintMessage( HUD_PRINTCENTER, "Skipped puzzle #5" )
	for k, v in pairs(ents.GetAll()) do
		if v:GetName() == "tube_glass5" then
			v:Fire("Break","",0)
		end
		if v:GetName() == "light5" then
			v:Fire("TurnOn","",0)
		end
	end
end

function patch_puz6()
	PrintMessage( HUD_PRINTCENTER, "Skipped puzzle #6" )
	for k, v in pairs(ents.GetAll()) do
		if v:GetName() == "tube_glass6" then
			v:Fire("Break","",0)
		end
		if v:GetName() == "light6" then
			v:Fire("TurnOn","",0)
		end
	end
end

function patch_puz7()
	PrintMessage( HUD_PRINTCENTER, "Skipped puzzle #7" )
	for k, v in pairs(ents.GetAll()) do
		if v:GetName() == "tube_glass7" then
			v:Fire("Break","",0)
		end
		if v:GetName() == "light7" then
			v:Fire("TurnOn","",0)
		end
	end
end

function map_patch()
	//Map gives weapons, none needed:
	puzzle_spawn_weapons = {}
	
	//Fix the engrish:
	for k, v in pairs(ents.GetAll()) do
		if v:GetName() == "level_1" then
			v:SetKeyValue("message","Puzzle #1 Completed!")
		end
		if v:GetName() == "level_2" then
			v:SetKeyValue("message","Puzzle #2 Completed!")
		end
		if v:GetName() == "level_3" then
			v:SetKeyValue("message","Puzzle #3 Completed!")
		end
		if v:GetName() == "level_4" then
			v:SetKeyValue("message","Puzzle #4 Completed!")
		end
		if v:GetName() == "level_5" then
			v:SetKeyValue("message","Puzzle #5 Completed!")
		end
		if v:GetName() == "level_6" then
			v:SetKeyValue("message","Puzzle #6 Completed!")
		end
		if v:GetName() == "level_7" then
			v:SetKeyValue("message","Puzzle #7 Completed!")
		end
		
		//Annoying text:
		if v:GetName() == "thething" then
			v:Remove()
		end
		if v:GetName() == "client_spectate_join" then
			v:Remove()
		end
		if v:GetName() == "SoulKiller" then
			v:Remove()
		end
		if v:GetName() == "D@SoLe" then
			v:Remove()
		end
		if v:GetName() == "D@SoLe2" then
			v:Remove()
		end
	end
	
	//Create some patches:
	new_patch("Skip Puzzle #1",patch_puz1)
	new_patch("Skip Puzzle #2",patch_puz2)
	new_patch("Skip Puzzle #3",patch_puz3)
	new_patch("Skip Puzzle #4",patch_puz4)
	new_patch("Skip Puzzle #5",patch_puz5)
	new_patch("Skip Puzzle #6",patch_puz6)
	new_patch("Skip Puzzle #7",patch_puz7)
	
	//Create some entities to keep track of score:
	NewTracker("level_1")
	NewTracker("level_2")
	NewTracker("level_3")
	NewTracker("level_4")
	NewTracker("level_5")
	NewTracker("level_6")
	NewTracker("level_7")
end
