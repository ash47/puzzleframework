--[[
server/sv_health.lua

 - Health Recharging
]]--

-- Modified health engine:
function StartRechargeHP(ply)
	if not ply:IsValid() then return end
	timer.Create("HP"..ply:EntIndex(),0.1,0,function()
		RechargeHP(ply,ply:EntIndex())
	end)
end

function RechargeHP(ply,fallback)
	if not ply:IsValid() then timer.Destroy("Start"..fallback) timer.Destroy("HP"..ply:EntIndex()) return end
	ply:SetHealth(ply:Health()+5)
	if ply:Health()>=100 then
		ply:SetHealth(100)
		timer.Destroy("Start"..ply:EntIndex())
		timer.Destroy("HP"..ply:EntIndex())
	end
end

function GM:EntityTakeDamage(ent, inflictor, attacker, amount)
	if ent:IsPlayer() then
		timer.Create("Start"..ent:EntIndex(),3,1,function()
			StartRechargeHP(ent)
		end)
		timer.Destroy("HP"..ent:EntIndex())
	end 
end