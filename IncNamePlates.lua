--IncNameplates
hooksecurefunc("CompactUnitFrame_OnUpdate", function(frame)
if C_NamePlate.GetNamePlateForUnit(frame.unit) ~= C_NamePlate.GetNamePlateForUnit("player") and not UnitIsPlayer(frame.unit) and not CompactUnitFrame_IsTapDenied(frame) then
   local threat = UnitThreatSituation("player", frame.unit) or 0
   local reaction = UnitReaction(frame.unit, "player")
   local name = UnitName(frame.unit)
   local colorC = _G["RAID_CLASS_COLORS"][select(2, UnitClass("player"))]
    if name == "爆炸物" then
	-- this's the new name of fel explosives in 8.0
      r, g, b = 0.8, 0, 1
	  -- special unit, pink red
	  elseif name == "戈霍恩之嗣" then
		-- this's new buff among the enemies in 8.0 10m+, Spawn of G'huun
      r, g, b = 0.8, 0, 1
	  -- special unit
	  elseif UnitIsUnit(frame.displayedUnit, "target") then
      r, g, b = colorC.r, colorC.g, colorC.b
	  -- target unit, class's colors
    elseif threat == 3 then
r, g, b = 0, 1, 1
      -- ur threat, sky blue
    elseif threat == 2 and GetSpecializationRole(GetSpecialization()) == "TANK" then
r, g, b = 1, 0.2, 1
      -- ur threat is lessing
    elseif threat == 2 then
r, g, b = 1, 0.2, 1
      -- ur threat is more than tank bt lessing
    elseif threat == 1 then
r, g, b = 1, 0.5, 0
      -- high threat, orange
	  elseif reaction == 4 then
r, g, b = 1, 1, 0
else
r, g, b = 1, 0, 0
      -- others, red
end
frame.healthBar:SetStatusBarColor(r, g, b, 1)
end
end) 
