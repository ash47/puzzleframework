--[[
server/sv_voting.lua

 - Sexy Voting API
]]--

_ActivePolls = {}
TotalPolls = 0

-- Create a vote:
function VoteCreate(args)
	-- Set default values:
	args.time = args.time or 			_settings.VoteDefaultTime
	args.passrate = args.passrate or	_settings.VotePassPercent
	args.passextra = args.passextra or	_settings.VotePassPlus
	args.callback = args.callback or	_settings.VoteDefaultCallback
	args.question = args.question or	_settings.VoteDefaultQuestion
	args.default = args.default or		_settings.VoteDefaultFavor
	
	-- Build storage for votes:
	args.votesYes = args.votesYes or 0			-- Total yes
	args.votesNo = args.votesNo or 0			-- Total no
	args.votesTotal = args.votesTotal or 0		-- Total number of votes so far
	args.votesPlayers = args.votesPlayers or {}	-- List of players who have voted
	
	-- Set the total polls up:
	TotalPolls = TotalPolls+1
	
	-- Store our index:
	args.id = TotalPolls
	
	-- Store the vote:
	_ActivePolls[args.id] = args
	
	-- Build a timeout timer:
	timer.Create("Poll-"..args.id, args.time, 1, function()
		-- End the vote:
		VoteEnd(args.id)
	end)
	
	-- Tell everyone there is a vote:
	net.Start("Vote")
	net.WriteInt(args.id, 16)		-- ID of the vote
	net.WriteInt(args.time, 8)		-- How long the vote goes for
	net.WriteString(args.question)	-- The question being asked
	
	-- Check if it's a private vote:
	if args.private then
		net.Send(args.private)
	else
		net.Broadcast()
	end
end

-- Ends a vote:
function VoteEnd(num, force)
	-- Ensure our timer is gone:
	timer.Remove("Poll-"..num)
	
	-- Grab a copy of args:
	local args = _ActivePolls[num]
	
	-- Validate:
	if not args then
		print("VoteEnd was called with an INVALID poll ID!")
		return
	end
	
	-- Tell all the client to hide the vote:
	net.Start("VoteEnd")
	net.WriteInt(num, 16)
	net.Broadcast()
	
	-- Check if anyone voted:
	if args.votesTotal == 0 then
		args.passed = args.default
	else
		-- Decide the pass percentage:
		local pass = math.min(args.passrate + args.passextra/args.votesTotal, 1)
		
		-- Check if we met that percent:
		if args.votesYes/args.votesTotal >= pass then
			args.passed = true
		else
			args.passed = false
		end
	end
	
	-- Set it to force if there is a value for it:
	args.passed = args.passed or force
	
	-- Run the callback:
	args.callback(args)
	
	-- Delete args:
	_ActivePolls[num] = nil
	args = nil
end

-- Checks if a vote has passed:
function VoteCheck(num)
	-- Grab a copy of args:
	local args = _ActivePolls[num]
	
	-- Something went wrong:
	if not args then return end
	
	-- Ensure there are players in:
	if #player.GetAll() == 0 then return end
	
	-- Grab the total number of players:
	local totalPlayers = #player.GetAll()
	
	-- Enable private quick ending:
	if args.private then
		totalPlayers = #args.private
	end
	
	-- Grab the pass rate if everyone was to vote:
	local pass = math.min(args.passrate + args.passextra/totalPlayers, 1)
	
	-- Check the percentage:
	if args.votesTotal == totalPlayers then
		-- End the vote:
		VoteEnd(num)
	elseif args.votesYes/totalPlayers >= pass then
		-- Force yes:
		VoteEnd(num, true)
	elseif args.votesNo/totalPlayers > (1-pass) then
		-- Force no:
		VoteEnd(num, false)
	end
end

net.Receive("Vote", function(len, ply)
	local id = net.ReadInt(16)
	local vote = net.ReadInt(2)
	
	-- Only accept valid votes:
	if vote ~= 0 and vote ~= 1 then return end
	
	-- Ensure the poll exists:
	if not _ActivePolls[id] then return end
	
	-- Has the player already voted:
	if _ActivePolls[id].votesPlayers[ply] then return end
	
	-- Check if it's a private vote:
	if _ActivePolls[id].private then
		-- Stop players from voting if they aren't in it:
		if not table.HasValue(_ActivePolls[id].private, ply) then return end
	end
	
	-- Store that they have voted:
	_ActivePolls[id].votesPlayers[ply] = vote
	_ActivePolls[id].votesTotal = _ActivePolls[id].votesTotal+1
	
	-- Add their vote:
	if vote == 1  then
		_ActivePolls[id].votesYes = _ActivePolls[id].votesYes+1
	else
		_ActivePolls[id].votesNo = _ActivePolls[id].votesNo+1
	end
	
	-- Check if the vote has passed:
	VoteCheck(id)
end)
