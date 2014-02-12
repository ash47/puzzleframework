function patch_puz1()
	PrintMessage( HUD_PRINTCENTER, "Skipped puzzle #1" )
	for k, v in pairs(ents.GetAll()) do
		if v:GetName() == "door1" then
			v:Fire("Break","",0)
		end
		if v:GetName() == "light1" then
			v:Fire("TurnOn","",0)
		end
		if v:GetName() == "fire1" then
			//v:Fire("StartFire","",0)
		end
	end
end

function patch_puz2()
	PrintMessage( HUD_PRINTCENTER, "Skipped puzzle #2" )
	for k, v in pairs(ents.GetAll()) do
		if v:GetName() == "door2" then
			v:Fire("Break","",0)
		end
		if v:GetName() == "light2" then
			v:Fire("TurnOn","",0)
		end
		if v:GetName() == "fire2" then
			//v:Fire("StartFire","",0)
		end
		if v:GetName() == "push2" then
			v:Fire("Disable","",0)
		end
	end
end

function patch_puz3()
	PrintMessage( HUD_PRINTCENTER, "Skipped puzzle #3" )
	for k, v in pairs(ents.GetAll()) do
		if v:GetName() == "door3" then
			v:Fire("Break","",0)
		end
		if v:GetName() == "light3" then
			v:Fire("TurnOn","",0)
		end
		if v:GetName() == "fire3" then
			//v:Fire("StartFire","",0)
		end
		if v:GetName() == "push3" then
			v:Fire("Disable","",0)
		end
	end
end

function patch_puz4()
	PrintMessage( HUD_PRINTCENTER, "Skipped puzzle #4" )
	for k, v in pairs(ents.GetAll()) do
		if v:GetName() == "door4" then
			v:Fire("Break","",0)
		end
		if v:GetName() == "light4" then
			v:Fire("TurnOn","",0)
		end
		if v:GetName() == "fire4" then
			//v:Fire("StartFire","",0)
		end
		if v:GetName() == "push4" then
			v:Fire("Disable","",0)
		end
	end
end

function patch_puz5()
	PrintMessage( HUD_PRINTCENTER, "Skipped puzzle #5" )
	for k, v in pairs(ents.GetAll()) do
		if v:GetName() == "door5" then
			v:Fire("Break","",0)
		end
		if v:GetName() == "light5" then
			v:Fire("TurnOn","",0)
		end
		if v:GetName() == "fire5" then
			//v:Fire("StartFire","",0)
		end
		if v:GetName() == "push5" then
			v:Fire("Disable","",0)
		end
	end
end

function patch_puz6()
	PrintMessage( HUD_PRINTCENTER, "Skipped puzzle #6" )
	for k, v in pairs(ents.GetAll()) do
		if v:GetName() == "door6" then
			v:Fire("Break","",0)
		end
		if v:GetName() == "light6" then
			v:Fire("TurnOn","",0)
		end
		if v:GetName() == "fire6" then
			//v:Fire("StartFire","",0)
		end
		if v:GetName() == "push6" then
			v:Fire("Disable","",0)
		end
	end
end

function patch_puz7()
	PrintMessage( HUD_PRINTCENTER, "Skipped puzzle #7" )
	for k, v in pairs(ents.GetAll()) do
		if v:GetName() == "door7" then
			v:Fire("Break","",0)
		end
		if v:GetName() == "light7" then
			v:Fire("TurnOn","",0)
		end
		if v:GetName() == "fire7" then
			//v:Fire("StartFire","",0)
		end
		if v:GetName() == "push7" then
			v:Fire("Disable","",0)
		end
	end
end

function map_patch()
	//Map gives weapons, none needed:
	puzzle_spawn_weapons = {}
	
	//Fix the engrish:
	for k, v in pairs(ents.GetAll()) do
		if v:GetName() == "txt1" then
			v:SetKeyValue("message","Puzzle #1 Completed!")
		end
		if v:GetName() == "txt2" then
			v:SetKeyValue("message","Puzzle #2 Completed!")
		end
		if v:GetName() == "txt3" then
			v:SetKeyValue("message","Puzzle #3 Completed!")
		end
		if v:GetName() == "txt4" then
			v:SetKeyValue("message","Puzzle #4 Completed!")
		end
		if v:GetName() == "txt5" then
			v:SetKeyValue("message","Puzzle #5 Completed!")
		end
		if v:GetName() == "txt6" then
			v:SetKeyValue("message","Puzzle #6 Completed!")
		end
		if v:GetName() == "txt7" then
			v:SetKeyValue("message","Puzzle #7 Completed!")
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
	NewTracker("txt1")
	NewTracker("txt2")
	NewTracker("txt3")
	NewTracker("txt4")
	NewTracker("txt5")
	NewTracker("txt6")
	NewTracker("txt7")
end
