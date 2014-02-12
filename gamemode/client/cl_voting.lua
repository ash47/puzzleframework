if SERVER then return end

--[[
client/cl_voting.lua

 - Voting
]]--

-- Toggle cursor stuff:
function GM:OnContextMenuOpen()
	gui.EnableScreenClicker(true)
end

function GM:OnContextMenuClose()
	gui.EnableScreenClicker(false)
end

-- List of active vote panels:
_ActivePolls = _ActivePolls or {}

-- A vote has been created:
net.Receive("Vote", function(len)
	local id = net.ReadInt(16)
	local EndTime = CurTime()+net.ReadInt(8)
	local question = net.ReadString()
	
	VoteCreatePanel(id, EndTime, question)
end)

-- A vote has ended:
net.Receive("VoteEnd", function(len)
	local id = net.ReadInt(16)
	
	if _ActivePolls[id] then
		_ActivePolls[id]:Remove()
	end
end)

-- Send our vote:
function VoteDo(id, vote)
	net.Start("Vote")
	net.WriteInt(id, 16)
	net.WriteInt(vote, 2)
	net.SendToServer()
end

-- Create a new vote panel:
function VoteCreatePanel(id, EndTime, question)
	-- Workout where to place it:
	local x = 50
	local y = 50
	
	local broken = true
	
	while broken do
		broken = false
		for k,v in pairs(_ActivePolls) do
			if x == v.x and y == v.y then
				// Move onto next pos:
				y = y + 240 + 50
				
				if y+320 > ScrH() then
					y = 50
					x = x + 320 + 50
				end
				
				broken = true
				break
			end
		end
	end
		
	-- Create a vote panel:
	local votepanel = vgui.Create("DFrame")
	votepanel:SetPos(x,y)
	votepanel:SetSize(320, 240)
	votepanel:SetTitle("Vote:")
	votepanel:SetDeleteOnClose(true)
	
	-- Store key info:
	votepanel.id = id
	votepanel.EndTime = EndTime
	votepanel.question = question
	votepanel.x = x
	votepanel.y = y
	
	-- Do the timer:
	votepanel.Think = function()
		votepanel:SetTitle("Hold 'C' to vote ("..math.max(math.ceil(votepanel.EndTime-CurTime()), 1).."):")
	end
	
	-- Create the text field:
	local q = vgui.Create("DLabel", votepanel)
	q:SetPos(4, 30)
	q:SetWrap(true)
	q:SetAutoStretchVertical(true)
	q:SetWide(312)
	q:SetText(question)
	q:SetFont("VoteFont")
	
	-- Yes:
	local btn = vgui.Create("DButton", votepanel)
	btn:SetText("Yes")
	btn:SetSize(110, 25)
	btn:SetPos(46, 207)
	btn.DoClick = function()
		-- Send our vote:
		VoteDo(id, 1)
		
		-- Close the panel:
		votepanel:Remove()
	end

	-- No:
	local btn = vgui.Create("DButton", votepanel)
	btn:SetText("No")
	btn:SetSize(110, 25)
	btn:SetPos(164, 207)
	btn.DoClick = function()
		-- Send our vote:
		VoteDo(id, 0)
		
		-- Close the panel:
		votepanel:Remove()
	end
	
	_ActivePolls[id] = votepanel
end
