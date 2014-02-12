if SERVER then return end

--[[
client/cl_fonts.lua

 - Fonts
]]--

-- Menu Header
surface.CreateFont("MenuHeader", {
	size = 24,
	weight = 0,
	antialias = false,
	shadow = true,
	font = "coolvetica"
})

-- Vote Font
surface.CreateFont("VoteFont", {
	size = 16,
	weight = 0,
	antialias = false,
	shadow = false,
	font = "arial"
})

-- Middle of the screen, player's name font:
surface.CreateFont("PlayerHudText", {
	size = 32,
	weight = 0,
	antialias = false,
	shadow = true,
	font = "coolvetica"
})
