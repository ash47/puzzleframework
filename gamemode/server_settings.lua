--[[
server_settings.lua

 - Server Settings
 - Vote Settings
]]--

_settings = {}

_settings.VotePassPercent = 0.5	-- Vote pass percent
_settings.VotePassPlus = 1		-- How many people OVER this number must be counted
-- Default:  For a vote to pass: 50% of people plus 1 extra need to vote YES
_settings.VoteDefaultTime = 30	-- How long a vote should last by default

-- Default question to ask:
_settings.VoteDefaultQuestion = "Vote yes, or no:"

-- If no one votes, do we count this as a pass (true), or a fail (false):
_settings.VoteDefaultFavor = false

-- What will happen if a callback isn't used:
_settings.VoteDefaultCallback = function(args)
	if args.votesTotal > 0 then
		NotifyAll(0, 10, "Poll results: "..(args.votesYes/args.votesTotal*100).."% voted yes!")
	else
		NotifyAll(0, 10, "No one voted...")
	end
end

-- Default player character:
_settings.ModelDefault = "models/player/group01/male_01.mdl"
