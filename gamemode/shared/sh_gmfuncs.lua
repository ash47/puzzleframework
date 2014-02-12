--[[
shared/sh_gmfuncs.lua

 - Shared gamemode functions that don't fit elsewhere
]]--

hook.Add("ShouldCollide","playerCollisions", function(ent1, ent2)
	if (ent1:IsPlayer() and ent2:IsPlayer()) then
		return false
	end 
end)
