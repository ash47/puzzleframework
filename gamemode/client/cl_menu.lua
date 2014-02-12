if SERVER then return end

--[[
client/cl_menu.lua

 - The client menu
]]--

function ShowMenu(tab)
	local xpos = ScrW()/2-320
	local ypos = ScrH()/2-240
	
	-- Delete old menu:
	if Menu and Menu:IsValid() then
		xpos, ypos = Menu:GetPos()
		Menu:Close()
	end
	
	-- Create the main menu:
	local m = vgui.Create("DFrame")
	m:SetPos(xpos,ypos)
	m:SetSize(640, 480)
	m:SetTitle("Player Menu")
	m:SetVisible(true)
	m:SetDraggable(true)
	m:ShowCloseButton(true)
	m:SetDeleteOnClose(true)
	m:MakePopup()
	
	-- Store M:
	Menu = m
	
	m.Thinka = m.Think
	m.Think = function(self)
		-- Normal Thinking:
		self:Thinka()
		
		local keys = {KEY_F1, KEY_F2, KEY_F3, KEY_F4}
		local p = false
		
		for k,v in pairs(keys) do
			-- Does the tab exist:
			if self.Tabs.Sheets[k] then
				-- Are we pressing the F-Key:
				if input.IsKeyDown(v) then
					-- Pressed is true:
					p = true
					
					-- If not pressed:
					if not self._pressed then
						-- Do we close or change tabs:
						if self.tabs:GetActiveTab() == self.Tabs.Sheets[k].Tab then
							self:Close()
						else
							self.tabs:SetActiveTab(self.Tabs.Sheets[k].Tab)
						end
					end
				end
			end
		end
		
		self._pressed = p
	end
	
	-- Create the tabs:
	local tabs = vgui.Create("DPropertySheet", m)
	tabs:SetPos(4, 26)
	tabs:SetSize(632, 450)
	
	-- Store tabs:
	m.tabs = tabs
	
	-- Main tab
	local tabMain = vgui.Create("DPanel")
	
	--[[
	Buttons:
	]]--
	
	-- I'm Stuck!
	local btn = vgui.Create( "DButton", tabMain )
	btn:SetText( "I'm Stuck!" )
	btn:SetPos( 8, 348 )
	btn:SetSize( 110, 25 )
	btn.DoClick = function ()
		RunConsoleCommand("kill")
	end
	
	-- Suicide
	local btn = vgui.Create( "DButton", tabMain )
	btn:SetText( "Suicide" )
	btn:SetPos( 126, 348 )
	btn:SetSize( 110, 25 )
	btn.DoClick = function ()
		RunConsoleCommand("kill")
	end
	
	-- Vote Next Map
	local btn = vgui.Create( "DButton", tabMain )
	btn:SetText( "Vote Next Map" )
	btn:SetPos( 8, 381 )
	btn:SetSize( 110, 25 )
	btn.DoClick = function ()
		net.Start("nextmap")
		net.SendToServer()
	end
	
	-- Vote New Map
	local btn = vgui.Create( "DButton", tabMain )
	btn:SetText( "Vote New Map" )
	btn:SetPos( 126, 381 )
	btn:SetSize( 110, 25 )
	btn.DoClick = function ()
	end
	
	-- Close Menu
	local btn = vgui.Create( "DButton", tabMain )
	btn:SetText( "Close" )
	btn:SetPos( 498, 381 )
	btn:SetSize( 110, 25 )
	btn.DoClick = function ()
		m:Close()
	end
	
	--[[
	Save state section:
	]]--
	
	-- Ensure we have a list of save states:
	if not SaveStates then
		SaveStates = {}
		SelectedSaveSate = 1
		SelectedSaver = false
		TotalSaveStates = 1
		table.insert(SaveStates,{"1) Default", TotalSaveStates})
	end
	
	local tabSaves = vgui.Create("DPanel", tabMain)
	tabSaves:SetPos(8, 8)
	tabSaves:SetSize(270, 332)
	
	local l = vgui.Create("DLabel", tabSaves)
	l:SetText("Save States")
	l:SetPos(4, 4)
	l:SetTextColor(Color(255, 255, 255))
	l:SetFont("MenuHeader")
	l:SizeToContents()
	
	-- Build the Save list:
	local saveList = BuildSaveList(tabSaves)
	
	-- New Slot:
	local btn = vgui.Create( "DButton", tabSaves )
	btn:SetText( "New Slot" )
	btn:SetPos( 156, 38 )
	btn:SetSize( 110, 25 )
	btn.DoClick = function ()
		local k = #SaveStates+1
		local a = saveList:AddLine((k)..") New State")
		a._id = k
		
		-- If there are no slots:
		if k == 1 then
			SelectedSaveSate = 1
			saveList:SelectItem(a)
			SelectedSaver = a
		end
		TotalSaveStates = TotalSaveStates+1
		table.insert(SaveStates,{(k)..") New State", TotalSaveStates})
	end
	
	-- Remove Slot:
	local btn = vgui.Create( "DButton", tabSaves )
	btn:SetText( "Remove Slot" )
	btn:SetPos( 156, 69 )
	btn:SetSize( 110, 25 )
	btn.DoClick = function ()
		-- Remove the selected slot:
		table.remove(SaveStates, SelectedSaveSate)
		
		-- Rebuild the save list:
		saveList:Remove()
		saveList = BuildSaveList(tabSaves)
	end
	
	-- Rename Slot:
	local btn = vgui.Create( "DButton", tabSaves )
	btn:SetText( "Rename Slot" )
	btn:SetPos( 156, 100 )
	btn:SetSize( 110, 25 )
	btn.DoClick = function ()
		if #SaveStates > 0 then
			-- Request text, and change it:
			GetTextInput("Rename Save State", "Enter a new name for this save state:", SaveStates[SelectedSaveSate][1], function(txt)
				-- Store the change:
				SaveStates[SelectedSaveSate][1] = txt
				
				-- Rebuild the save list:
				saveList:Remove()
				saveList = BuildSaveList(tabSaves)
			end)
		end
	end
	
	-- Load State:
	local btn = vgui.Create( "DButton", tabSaves )
	btn:SetText( "Load State" )
	btn:SetPos( 156, 272 )
	btn:SetSize( 110, 25 )
	btn.DoClick = function ()
		RunConsoleCommand("_getpos",SaveStates[SelectedSaveSate][2])
	end
	
	-- Save State:
	local btn = vgui.Create( "DButton", tabSaves )
	btn:SetText( "Save State" )
	btn:SetPos( 156, 303 )
	btn:SetSize( 110, 25 )
	btn.DoClick = function ()
		RunConsoleCommand("_savepos",SaveStates[SelectedSaveSate][2])
	end
	
	--[[
	Player Section:
	]]--
	local tabPlayer = vgui.Create("DPanel", tabMain)
	tabPlayer:SetPos(290, 8)
	tabPlayer:SetSize(318, 332)
	
	local playerList = BuildPlayerList(tabPlayer)
	
	-- Vote Kick:
	local btn = vgui.Create( "DButton", tabPlayer )
	btn:SetText( "Vote Kick" )
	btn:SetPos( 204, 38 )
	btn:SetSize( 110, 25 )
	btn.DoClick = function ()
		-- Request to kick a player:
		if SelectedPlayer and SelectedPlayer:IsValid() then
			-- They can't go to themselves:
			if LocalPlayer() ~= SelectedPlayer then
				GetTextInput("Kick a player", "Enter a reason to convince the other players to kick "..SelectedPlayer:Nick(), "No reason.", function(txt)
					-- No reason given:
					if txt == "No reason." then
						Notify("What a great reason...", 1, 5)
						return
					end
					
					-- Too short
					if string.len(txt) < 10 then
						Notify("Try being more descriptive.", 1, 5)
						return
					end
					
					-- Send the request:
					net.Start("kick")
					net.WriteEntity(SelectedPlayer)
					net.WriteString(txt)
					net.SendToServer()
				end)
			else
				Notify("You want to kick yourself?", 1, 5)
			end
		end
	end
	
	-- Vote Ban:
	local btn = vgui.Create( "DButton", tabPlayer )
	btn:SetText( "Vote Ban" )
	btn:SetPos( 204, 69 )
	btn:SetSize( 110, 25 )
	btn.DoClick = function ()
		-- Request to kick a player:
		if SelectedPlayer and SelectedPlayer:IsValid() then
			-- They can't go to themselves:
			if LocalPlayer() ~= SelectedPlayer then
				GetTextInput("Ban a player", "Enter a reason to convince the other players to BAN "..SelectedPlayer:Nick(), "No reason.", function(txt)
					-- No reason given:
					if txt == "No reason." then
						Notify("What a great reason...", 1, 5)
						return
					end
					
					-- Too short
					if string.len(txt) < 10 then
						Notify("Try being more descriptive.", 1, 5)
						return
					end
					
					-- Send the request:
					net.Start("ban")
					net.WriteEntity(SelectedPlayer)
					net.WriteString(txt)
					net.SendToServer()
				end)
			else
				Notify("You want to ban yourself?", 1, 5)
			end
		end
	end
	
	-- Toggle Mute:
	local btn = vgui.Create( "DButton", tabPlayer )
	btn:SetText( "Toggle Mute" )
	btn:SetPos( 204, 100 )
	btn:SetSize( 110, 25 )
	btn.DoClick = function ()
		-- Toggle the mute:
		if SelectedPlayer and SelectedPlayer:IsValid() then
			SelectedPlayer:SetMuted(not SelectedPlayer:IsMuted())
			
			-- Rebuild the player list:
			playerList:Remove()
			playerList = BuildPlayerList(tabPlayer)
		end
	end
	
	-- Goto:
	local btn = vgui.Create( "DButton", tabPlayer )
	btn:SetText( "Goto" )
	btn:SetPos( 204, 131 )
	btn:SetSize( 110, 25 )
	btn.DoClick = function ()
		-- Request to goto a player:
		if SelectedPlayer and SelectedPlayer:IsValid() then
			-- They can't go to themselves:
			if LocalPlayer() ~= SelectedPlayer then
				-- Tell the server:
				net.Start("goto")
				net.WriteEntity(SelectedPlayer)
				net.SendToServer()
			else
				Notify("Try going to someone else...", 1, 5)
			end
		end
	end
	
	--[[
	Welcome Tab:
	]]--
	
	-- Main tab
	local tabWelcome = vgui.Create("DPanel")
	
	local tabWelcomeA = vgui.Create("DPanelList", tabWelcome)
	tabWelcomeA:EnableHorizontal(false)
	tabWelcomeA:EnableVerticalScrollbar(true)
	tabWelcomeA:SetPos(4,4)
	tabWelcomeA:SetSize(608, 371)
	
	for k,v in pairs(Welcome) do
		-- Create a category:
		local category = vgui.Create("DCollapsibleCategory")
		category:SetExpanded(false)
		category:SetLabel(v[1])
		
		-- Create a list to store the text:
		txtList = vgui.Create("DPanelList")
		txtList:SetAutoSize(true)
		txtList:SetSpacing(5)
		txtList:EnableHorizontal(false)
		txtList:EnableVerticalScrollbar(false)
		
		-- Allow free scrolling:
		txtList.OnMouseWheeled = nil
		
		-- Fill the category with said list:
		category:SetContents(txtList)
		
		-- Fill the list with text:
		for k2,v2 in pairs(v) do
			if k2 != 1 then
				local txt = vgui.Create("DLabel")
				txt:SetText(v2)
				txt:SetWrap(true)
				txt:SetDark(true)
				txt:SetAutoStretchVertical(true)
				txtList:AddItem(txt)
			end
		end
		
		-- Add to the menu:
		tabWelcomeA:AddItem(category)
		
		-- Lazy way to expand first category:
		if k == 1 then
			category:SetExpanded(true)
		end
	end
	
	-- Close Button
		local btn = vgui.Create("DButton", tabWelcome)
		btn:SetText("Close")
		btn:SetPos(498, 381)
		btn:SetSize(110, 25)
		btn.DoClick = function()
			m:Close()
		end
	
	--[[
	Customise Section
	]]--
	local tabCustom = vgui.Create("DPanel")
	
	-- Close Button
	local btn = vgui.Create("DButton", tabCustom)
	btn:SetText("Close")
	btn:SetPos(498, 381)
	btn:SetSize(110, 25)
	btn.DoClick = function()
		m:Close()
	end
	
	-- Model Preview:
	local preview = vgui.Create("DModelPanel", tabCustom)
	preview:SetPos(340,-20)
	preview:SetSize(380, 380)
	preview:SetModel("")
	preview:SetFOV(80)
	preview:SetVisible(false)
	
	-- Store
	tabCustom.previewModel = preview
	
	-- Texture Preview:
	local preview = vgui.Create("DPanel", tabCustom)
	preview:SetPos(452,32)
	preview:SetSize(160, 160)
	preview.SetMaterial = function(self, mat)
		self.mat = mat
		self.tex = surface.GetTextureID(self.mat);
	end
	
	preview:SetVisible(false)
	preview.Paint = function(self)
		local w, h = self:GetSize()
		surface.SetDrawColor(0, 0, 0, 255);
		surface.DrawRect(0, 0, w, h)
		surface.SetDrawColor(255, 255, 255, 255);
		surface.SetTexture(self.tex);
		surface.DrawTexturedRect(0, 0, w, h)
	end
	
	-- Store
	tabCustom.previewMaterial = preview
	
	-- Custom tabs:
	local ctabs = vgui.Create("DPropertySheet", tabCustom)
	ctabs:SetPos(8, 8)
	ctabs:SetSize(440, 398)
	ctabs.Lists = {}
	
	local oldtab = ""
	
	ctabs.Think = function()
		-- Grab the active tab:
		ActiveStoreTab = ctabs:GetActiveTab():GetPanel().num
		
		-- Do the update:
		if oldtab ~= ActiveStoreTab then
			local sl = ctabs.Lists[ActiveStoreTab]
			sl.Set(sl:GetLine(sl:GetSelectedLine() or 1))
		end
		
		-- Store old tab:
		oldtab = ActiveStoreTab
	end
	
	SelectedShopItem = SelectedShopItem or {}
	
	for k,v in pairs(Shop) do
		-- Build it:
		local sec = vgui.Create("DPanel")
		sec.num = k
		
		-- Store selected item:
		SelectedShopItem[k] = SelectedShopItem[k] or 1
		
		-- Unlock / Equip button
		local btn = vgui.Create("DButton", sec)
		btn:SetText("??? Profit")
		btn:SetPos(157, 333)
		btn:SetSize(110, 25)
		btn:SetVisible(false)
		btn.DoClick = function()
			net.Start("shop")
			net.WriteInt(SelectedShopItem[k], 16)
			net.SendToServer()
		end
		
		-- Store it:
		sec.btn = btn
		
		local secList = vgui.Create( "DListView", sec)
		secList:SetPos(4, 4)
		secList:SetSize(416, 325)
		secList:AddColumn("Name")
		secList:AddColumn("Cost")
		secList:AddColumn("Donor Cost")
		secList:AddColumn("Owned")
		secList:AddColumn("Equipped")
		secList:SetMultiSelect(false)
		ctabs.Lists[k] = secList
		
		secList.Set = function(line)
			-- Clear the selection:
			secList:ClearSelection()
			
			-- Select this line:
			secList:SelectItem(line)
			
			-- Update in memory, which line is selected:
			SelectedShopItem[k] = line._id
			
			-- Disable all previews:
			tabCustom.previewModel:SetVisible(false)
			tabCustom.previewMaterial:SetVisible(false)
			
			-- Update preview:
			local s = Shop[ShopR[line._id]].items[line._id]
			if s.sort == ShopSortModel then
				-- Update model preview:
				tabCustom.previewModel:SetVisible(true)
				tabCustom.previewModel:SetModel(s.model)
			end
			
			if s.sort == ShopSortMaterial then
				-- Update model preview:
				tabCustom.previewMaterial:SetVisible(true)
				tabCustom.previewMaterial:SetMaterial(s.material)
			end
			
			-- Update the button:
			btn:SetVisible(true)
			
			if ShopOwned[line._id] then
				if ShopEquipped[line._id] then
					btn:SetText("Unequip")
				else
					btn:SetText("Equip")
				end
			else
				btn:SetText("Unlock")
			end
		end
		
		secList.OnClickLine = function(parent, line, isselected)
			secList.Set(line)
		end
		
		-- Add all the states:
		for kk, vv in pairs(v.items) do
			local otxt = "No"
			local etxt = "No"
			
			if ShopOwned[vv.id] then
				otxt = "Yes"
				
				if ShopEquipped[vv.id] then
					etxt = "Yes"
				end
			end
			
			local a = secList:AddLine(vv.name, vv.cost, vv.donorcost, otxt, etxt)
			a._id = vv.id
			
			-- Reselect line:
			if vv.id == SelectedShopItem[k] then
				secList.Set(a)
			end
		end
		
		local st = ctabs:AddSheet(k, sec, v.icon, false, false, v.des)
		
		-- Change tab:
		if(k == ActiveStoreTab) then
			ctabs:SetActiveTab(st.Tab)
			
			-- Lazy fix for preview:
			timer.Simple(0, function()
				secList.Set(secList:GetLine(secList:GetSelectedLine()))
			end)
		end
	end
	
	-- Money:
	local l = vgui.Create("DLabel", tabCustom)
	l:SetText("$"..Money)
	l:SetPos(26, 376)
	l:SetDark(true)
	l:SizeToContents()
	
	--[[
	Map Help Section
	]]--
	
	local tabHelp
	
	if Patches then
		tabHelp = vgui.Create("DPanel")
		
		local helpList = vgui.Create( "DListView", tabHelp)
		helpList:SetPos(4, 4)
		helpList:SetSize(608, 374)
		helpList:AddColumn("Title")
		helpList:SetMultiSelect(false)
		
		helpList.OnClickLine = function(parent, line, isselected)
			-- Clear the selection:
			helpList:ClearSelection()
			
			-- Select this line:
			helpList:SelectItem(line)
			
			-- Update in memory, which line is selected:
			SelectedHelp = line._id
		end
		
		for k,v in pairs(Patches) do
			-- Add the player to the list:
			local a = helpList:AddLine(v)
			a._id = k
			
			-- If that player was selected:
			if k == SelectedHelp then
				-- Clear the selection:
				helpList:ClearSelection()
				
				-- Select this line:
				helpList:SelectItem(a)
			end
		end
		
		-- Call Vote button:
		local btn = vgui.Create("DButton", tabHelp)
		btn:SetText("Call Vote")
		btn:SetSize(110, 25)
		btn:SetPos( 6, 383 )
		btn.DoClick = function()
			if SelectedHelp and SelectedHelp>0 then
				GetTextInput("Why?", "Why do you want to activate '"..Patches[SelectedHelp].."':", "It's too hard.", function(txt)
					-- Send the request:
					net.Start("patches")
					net.WriteInt(SelectedHelp, 16)
					net.WriteString(txt)
					net.SendToServer()
				end)
			end
		end
		
		-- Close Button
		local btn = vgui.Create("DButton", tabHelp)
		btn:SetText("Close")
		btn:SetPos(498, 381)
		btn:SetSize(110, 25)
		btn.DoClick = function()
			m:Close()
		end
	end
	
	
	-- Add the tabs:
	m.Tabs = {}
	m.Tabs.Sheets = {}
	m.Tabs.Sheets[1] = tabs:AddSheet( "Welcome", tabWelcome, "gui/silkicons/application_view_detail", false, false, "Useful Info" )
	m.Tabs.Sheets[2] = tabs:AddSheet( "Main", tabMain, "gui/silkicons/user", false, false, "Useful Stuff" )
	m.Tabs.Sheets[3] = tabs:AddSheet( "Customise", tabCustom, "gui/silkicons/user", false, false, "Customise your character" )
	
	-- Store ids:
	tabWelcome.num = 1
	tabMain.num = 2
	tabCustom.num = 3
	
	-- Conditional tab:
	if Patches then
		m.Tabs.Sheets[4] = tabs:AddSheet( "Map Help", tabHelp, "gui/silkicons/wrench", false, false, "Stuck? Get helphere!" )
		tabHelp.num = 4
	end
	
	-- Assign the tabs id:
	for k,v in pairs(m.Tabs.Sheets) do
		v.num = k
	end
	
	-- Reset pressed status:
	m._pressed = true
	
	-- Set the active tab:
	if m.Tabs.Sheets[tab] then
		tabs:SetActiveTab(m.Tabs.Sheets[tab].Tab)
	end
end

-- Open the menu:
net.Receive("Menu", function(len)
	ShowMenu(net.ReadInt(4))
end)

-- Builds the save list:
function BuildSaveList(tabSaves)
	local saveList = vgui.Create( "DListView", tabSaves)
	saveList:SetPos(4, 28)
	saveList:SetSize(148, 300)
	saveList:AddColumn("Name")
	saveList:SetMultiSelect(false)
	
	saveList.OnClickLine = function(parent, line, isselected)
		-- Clear the selection:
		saveList:ClearSelection()
		
		-- Select this line:
		saveList:SelectItem(line)
		
		-- Update in memory, which line is selected:
		SelectedSaveSate = line._id
	end
	
	if SelectedSaveSate > #SaveStates or SelectedSaveSate == 0 then
		SelectedSaveSate = #SaveStates
	end
	
	-- Add all the states:
	for k, v in pairs(SaveStates) do
		local a = saveList:AddLine(v[1])
		a._id = k
		if k == SelectedSaveSate then
			saveList:ClearSelection()
			saveList:SelectItem(a)
			SelectedSaver = a
		end
	end
	
	return saveList
end

function BuildPlayerList(tabPlayer)
	local l = vgui.Create("DLabel", tabPlayer)
	l:SetText("Player Options")
	l:SetPos(4, 4)
	l:SetTextColor(Color(255, 255, 255))
	l:SetFont("MenuHeader")
	l:SizeToContents()
	
	local playerList = vgui.Create( "DListView", tabPlayer)
	playerList:SetPos(4, 28)
	playerList:SetSize(196, 300)
	playerList:AddColumn("Player")
	playerList:SetMultiSelect(false)
	
	playerList.OnClickLine = function(parent, line, isselected)
		-- Clear the selection:
		playerList:ClearSelection()
		
		-- Select this line:
		playerList:SelectItem(line)
		
		-- Update in memory, which line is selected:
		SelectedPlayer = line._id
	end
	
	for k,v in pairs(player.GetAll()) do
		local prefix = ""
		if v:IsMuted() then
			prefix = "(Muted) "
		end
		
		-- Add the player to the list:
		local a = playerList:AddLine(prefix..v:Nick())
		a._id = v
		
		-- If that player was selected:
		if v == SelectedPlayer then
			-- Clear the selection:
			playerList:ClearSelection()
			
			-- Select this line:
			playerList:SelectItem(a)
		end
	end
	
	return playerList
end

-- Request Text:
function GetTextInput(title, question, def, callback)
	local Window = vgui.Create( "DFrame" )
	Window:SetTitle( title )
	Window:SetDraggable( false )
	Window:ShowCloseButton( false )
	Window:SetBackgroundBlur( true )
	Window:SetDrawOnTop( true )
	
	local InnerPanel = vgui.Create( "DPanel", Window )
	InnerPanel:SetPaintBackground(false)
	local Text = vgui.Create( "DLabel", InnerPanel )
	Text:SetText( question )
	Text:SizeToContents()
	Text:SetContentAlignment( 5 )
	Text:SetTextColor( color_white )
		
	local TextEntry = vgui.Create( "DTextEntry", InnerPanel )
	TextEntry:SetText(def)
	function TextEntry:OnFocusChanged(changed)
		self:RequestFocus()
		self:SelectAllText(true)
	end
	
	local ButtonPanel = vgui.Create( "DPanel", Window )
	ButtonPanel:SetTall( 30 )
		
	local btn = vgui.Create( "DButton", ButtonPanel )
	btn:SetText("OK")
	btn:SizeToContents()
	btn:SetTall( 20 )
	btn:SetWide( btn:GetWide() + 20 )
	btn:SetPos( 5, 5 )
	btn.DoClick = function()
		Window:Close()
		callback(TextEntry:GetValue())
	end
	
	local btn2 = vgui.Create( "DButton", ButtonPanel )
	btn2:SetText("Cancel")
	btn2:SizeToContents()
	btn2:SetTall( 20 )
	btn2:SetWide( btn2:GetWide() + 20 )
	btn2:SetPos( 5+btn:GetWide()+5, 5 )
	btn2.DoClick = function()
		Window:Close()
	end
	
	ButtonPanel:SetWide( btn:GetWide()+btn2:GetWide()+15 )
	
	local w, h = Text:GetSize()
	w = math.max( w, 400 ) 
	
	Window:SetSize( w + 50, h + 25 + 75 + 10 )
	Window:Center()
	
	InnerPanel:StretchToParent( 5, 25, 5, 45 )
	
	Text:StretchToParent( 5, 5, 5, 35 )	
	
	TextEntry:StretchToParent( 5, nil, 5, nil )
	TextEntry:AlignBottom( 5 )
	
	TextEntry:RequestFocus()
	
	ButtonPanel:CenterHorizontal()
	ButtonPanel:AlignBottom( 8 )
	
	Window:MakePopup()
	Window:DoModal()
end

-- Which tab is active:
ActiveStoreTab = ActiveStoreTab or 1
