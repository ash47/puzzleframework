if SERVER then return end

--[[
cl_init.lua

 - Client side entry point
]]--

-- Load the shared content:
include("shared/_shared.lua")

-- Load the gamemode:
include("client/_client.lua")
