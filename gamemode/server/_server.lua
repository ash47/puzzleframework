--[[
server/_server.lua

 - Load server files
 ]]--

-- Load our server side files:
include("sv_data.lua")				-- Database Stuff
include("sv_map_controller.lua")	-- Map Rotation / Management
include("sv_notifications.lua")		-- Notification related tasks
include("sv_weapons.lua")			-- Weapon Spawn control / management
include("sv_patches.lua")			-- Map patches (make maps run better)
include("sv_gmfuncs.lua")			-- Gamemode functions that don't fit elsewhere
include("sv_player.lua")			-- Player related code, spawning etc
include("sv_health.lua")			-- Health Recharging
include("sv_admin.lua")				-- Admin related commands
include("sv_chat.lua")				-- Chat related stuff
include("sv_savestates.lua")		-- Save States
include("sv_network_vars.lua")		-- Network Vars
include("sv_menu.lua")				-- Menu related stuff
include("sv_voting.lua")			-- Voting API
include("sv_shop.lua")				-- Shop
