--IncNameplates
hooksecurefunc("CompactUnitFrame_OnUpdate", function(frame)
    if C_NamePlate.GetNamePlateForUnit(frame.unit) ~= C_NamePlate.GetNamePlateForUnit("player") and not UnitIsPlayer(frame.unit) and not CompactUnitFrame_IsTapDenied(frame) then
		local threat = UnitThreatSituation("player", frame.unit) or 0
        local reaction = UnitReaction(frame.unit, "player")
        local name = UnitName(frame.unit)
		local ghuun = false
		for i = 1, 40 do 
			local spellID = {select(10, UnitBuff(frame.unit, i))}
			for _, v in pairs(spellID) do
				if v == 277242 then 
					ghuun = true
				end
			end
		end
            --local colorC = _G["RAID_CLASS_COLORS"][select(2, UnitClass("player"))]
            if name == "爆炸物" or 'Explosives' then
                  r, g, b = 0.8, 0, 1
	            -- 特殊单位，紫红
	        elseif name == "戈霍恩之嗣" or "Spawn of G'huun" then
                  r, g, b = 0.8, 0, 1
	            -- 特殊单位，紫红
	        elseif ghuun == true then
                  r, g, b = 1, 1, 1
	            -- 特殊单位，白色, 带共生BUFF的怪。
            elseif threat == 3 then
                  r, g, b = 0, 1, 1
                  -- 仇恨最高，天蓝
            elseif threat == 2 and GetSpecializationRole(GetSpecialization()) == "TANK" then
                  r, g, b = 1, 0.2, 1
                  -- 坦克职责仇恨不稳（坦克仇恨正在减少），紫红
            elseif threat == 2 then
                  r, g, b = 1, 0.2, 1
                  -- 非坦克职责仇恨不稳（仇恨大于坦克且正在减少），粉色
            elseif threat == 1 then
                  r, g, b = 1, 0.5, 0
                  -- 仇恨较高，橙色
	      elseif reaction == 4 then
                  r, g, b = 1, 1, 0
	            -- 仇恨中立，黄色
            else
                  r, g, b = 1, 0, 0
                  -- 其他，红色
            end
    frame.healthBar:SetStatusBarColor(r, g, b, 1)
	end
end) 
