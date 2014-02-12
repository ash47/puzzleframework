if SERVER then return end

--[[
client/cl_patches.lua
]]--
net.Receive("patches", function(len)
	Patches = {}
	
	while len > 0 do
		local str = net.ReadString()
		len = len - (string.len(str)+1)*8
		
		-- Store it:
		table.insert(Patches, str)
	end
end)
