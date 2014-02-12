--[[
server/sv_network_vars.lua

 - Network Vars
]]--

-- Server ==> Client || Client ==> Server

// Usermessages:
util.AddNetworkString("Notify")			-- Send a notification			|| N/A
util.AddNetworkString("Menu")			-- Open the menu				|| N/A
util.AddNetworkString("Vote")			-- A poll has been created		|| Sending our vote value
util.AddNetworkString("VoteEnd")		-- A poll has ended				|| N/A
util.AddNetworkString("goto")			-- N/A							|| A player wants to goto another player
util.AddNetworkString("kick")			-- N/A							|| A player wants to kick another
util.AddNetworkString("ban")			-- N/A							|| A player wants to BAN another
util.AddNetworkString("nextmap")		-- N/A							|| A player wants to vote to go to the next map
util.AddNetworkString("patches")		-- Sending patches				|| N/A
util.AddNetworkString("shop")			-- N/A							|| Wants to unlock / equip an item
util.AddNetworkString("inv")			-- Sending players inventory	|| N/A
util.AddNetworkString("invE")			-- Sending equipped items		|| N/A
util.AddNetworkString("money")			-- Sending money				|| N/A
util.AddNetworkString("newPlayer")		-- Someone new has joined		|| N/A
