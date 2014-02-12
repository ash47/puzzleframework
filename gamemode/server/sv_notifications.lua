--[[
server/sv_notifications.lua

 - Send notifications to the client
]]--

local meta = FindMetaTable("Player")

function meta:Notify(msgtype, len, msg)
	Notify(self, msgtype, len, msg)
end

function Notify(ply, msgtype, len, msg)
	if not ply:IsValid() then return end
	
	net.Start("Notify")
	net.WriteString(msg)
	net.WriteInt(msgtype, 4)
	net.WriteInt(len, 8)
	net.Send(ply)
end

function NotifyAll(msgtype, len, msg)
	net.Start("Notify")
	net.WriteString(msg)
	net.WriteInt(msgtype, 4)
	net.WriteInt(len, 8)
	net.Broadcast()
end
