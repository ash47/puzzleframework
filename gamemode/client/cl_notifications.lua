if SERVER then return end

--[[
client/cl_notifications.lua

 - Client Side notifications
]]--

function Notify(txt,icon,time)
	notification.AddLegacy(txt, icon, time)
	surface.PlaySound("ambient/water/drip" .. math.random(1, 4) .. ".wav")
end

net.Receive("Notify", function(len)
	local txt = net.ReadString()
	Notify(txt, net.ReadInt(4), net.ReadInt(8))
	
	-- Log to client console
	print(txt)
end)

net.Receive("newPlayer", function(len)
	local ply = net.ReadEntity()
	local lvl = net.ReadInt(16)
	ply.lvl = lvl
	
	-- Grr:
	if not ply:IsValid() then return end
	
	if ply ~= LocalPlayer() then
		chat.AddText(Color(255,255,255), "Player ",team.GetColor(ply:Team()),ply:Nick(),Color(255,255,255)," (Level "..lvl..") has entered the game.")
	else
		chat.AddText(Color(255,255,255), "Welcome to the server! You are Level "..lvl.."!")
	end
	
	surface.PlaySound("ambient/water/drip" .. math.random(1, 4) .. ".wav")
end)
