if SERVER then return end

-- Store old HP:
oldhp = 100

function GM:HUDPaint()
	if hud_timer then
		if CurTime()<hud_timer then
			draw.RoundedBox(1,ScrW()/2-hud_width/2-4,8,hud_width+8,hud_height+8,Color(255,255,255,150))
			draw.DrawText(hud_text.."\n"..math.Round(hud_timer-CurTime()),"ScoreboardText",ScrW()/2,12,Color(0,0,0,255),TEXT_ALIGN_CENTER)
		end
	end
	
	-- Health Plugin:
	ply = LocalPlayer()
	
	if not ply:IsValid() then return end
	
	if ply:Health()<100 then
		hurt = math.min(1,1-ply:Health()/100)
		-- Have we been hurt:
		if oldhp>ply:Health() then
			justhurt = 0.5
		end
		
		local tab = {}
		tab[ "$pp_colour_addr" ] = hurt
		tab[ "$pp_colour_addg" ] = 0
		tab[ "$pp_colour_addb" ] = 0
		tab[ "$pp_colour_brightness" ] = 0
		tab[ "$pp_colour_contrast" ] = 1
		tab[ "$pp_colour_colour" ] = 1
		tab[ "$pp_colour_mulr" ] = 0
		tab[ "$pp_colour_mulg" ] = 0
		tab[ "$pp_colour_mulb" ] = 0
		DrawColorModify( tab )
	end
	
	-- Draw player's name that we are looking at:
	local tr = ply:GetEyeTrace()
	
	if tr.Entity and tr.Entity:IsPlayer() then
		draw.DrawText(tr.Entity:Nick(), "PlayerHudText", ScrW() / 2, ScrH()/2, team.GetColor(tr.Entity:Team()),TEXT_ALIGN_CENTER)
	end
	
	-- Store our old health:
	oldhp = ply:Health()
end

function GM:HUDDrawTargetID()
	return true
end
