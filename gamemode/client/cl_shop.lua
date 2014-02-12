--[[
client/cl_shop.lua

 - Shop related stuff
]]--

ShopOwned = ShopOwned or {}
ShopEquipped = ShopEquipped or {}
Money = Money or 0

net.Receive("inv", function(len)
	ShopOwned = {}
	
	while(len>0) do
		-- Remove len:
		len = len-16
		
		-- Store id:
		ShopOwned[net.ReadInt(16)] = true
	end
	
	-- Update menu:
	if Menu and Menu:IsValid() then
		ShowMenu(Menu.tabs:GetActiveTab():GetPanel().num)
	end
end)

net.Receive("invE", function(len)
	ShopEquipped = {}
	
	while(len>0) do
		-- Remove len:
		len = len-16
		
		-- Store id:
		ShopEquipped[net.ReadInt(16)] = true
	end
	
	-- Update menu:
	if Menu and Menu:IsValid() then
		ShowMenu(Menu.tabs:GetActiveTab():GetPanel().num)
	end
end)

-- Server sent us our money:
net.Receive("money", function(len)
	Money = net.ReadInt(16)
end)
