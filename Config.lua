-----config.lua-----
-- short reload '/rl'   
SlashCmdList['RELOAD'] = function() ReloadUI() end
SLASH_RELOAD1 = '/rl'
-- raid tools button
local 	wm = CompactRaidFrameManagerDisplayFrameLeaderOptionsRaidWorldMarkerButton 
		wm:SetParent("CompactRaidFrameContainer") 
		wm:ClearAllPoints() 
		wm:SetSize(24, 24)
		wm:SetPoint("TOPLEFT", CompactRaidFrameContainer, "TOPLEFT", -25, 0) 
		wm:StopMovingOrSizing()
local 	wmmenuFrame = CreateFrame("Frame", "wmRightClickMenu", wm, "UIDropDownMenuTemplate") 
		wmRightClickMenu:SetPoint("BOTTOM", wm, "BOTTOM", -2, -2)
		wmRightClickMenu:Hide()
local 	wmmenuList = { 
		{text = "就位确认", 
		 func = function() DoReadyCheck() end}, 
		{text = "职责确认", 
		 func = function() InitiateRolePoll() end}, 
		{text = "转化为团队", 
		 func = function() ConvertToRaid() end}, 
		{text = "转化为小队", 
		 func = function() ConvertToParty() end}, 
		}
		wm:SetScript('OnMouseUp', function(self, button) 		 
			if 		(button=="RightButton") then 
					EasyMenu(wmmenuList, wmmenuFrame) 
			end 
		end)



--  隐藏宠物，队友，战场旗手，竞技场框体状态文字
hooksecurefunc("TextStatusBar_UpdateTextString", function(textStatusBar) 
   local name = textStatusBar:GetName() 
    if (name == "PartyMemberFrame1HealthBar" 
        or name == "PartyMemberFrame2HealthBar" 
        or name == "PartyMemberFrame3HealthBar" 
        or name == "PartyMemberFrame4HealthBar" 
        or name == "PartyMemberFrame1ManaBar" 
        or name == "PartyMemberFrame2ManaBar" 
        or name == "PartyMemberFrame3ManaBar" 
        or name == "PartyMemberFrame4ManaBar" 
        or name == "ArenaEnemyFrame1HealthBar" 
        or name == "ArenaEnemyFrame2HealthBar" 
        or name == "ArenaEnemyFrame3HealthBar" 
        or name == "ArenaEnemyFrame4HealthBar" 
        or name == "ArenaEnemyFrame1ManaBar" 
        or name == "ArenaEnemyFrame2ManaBar" 
        or name == "ArenaEnemyFrame3ManaBar" 
        or name == "ArenaEnemyFrame4ManaBar" 
        or name == "PetFrameHealthBar" 
        or name == "PetFrameManaBar") then 
        textStatusBar.TextString:Hide() 
        if (textStatusBar.LeftText) then textStatusBar.LeftText:Hide() end 
        if (textStatusBar.RightText) then textStatusBar.RightText:Hide() end 
    end 
end)

--  显示LUA错误，1开 
SetCVar("scriptErrors", 1)

-- 施法条隐藏
--CastingBarFrame:UnregisterAllEvents() 
--CastingBarFrame.Show = function() end 
--CastingBarFrame:Hide()

-- TalkingHeadFrame隐藏
local f = CreateFrame("Frame")
--Main function
function f:OnEvent(event, addon)
--Check if the talkinghead addon is being loaded
	if addon == "Blizzard_TalkingHeadUI" then
		hooksecurefunc("TalkingHeadFrame_PlayCurrent", function()
--Query subzone text when the talkinghead plays
	zoneName = GetSubZoneText();
--If we are not doing withered training, suppress the talkinghead
			if zoneName ~= "Temple of Fal'adora" and zoneName ~= "Falanaar Tunnels" and zoneName ~= "Shattered Locus" then
				TalkingHeadFrame_CloseImmediately()
			end
		end)
				self:UnregisterEvent(event)
	end
end
				f:RegisterEvent("ADDON_LOADED")
				f:SetScript("OnEvent", f.OnEvent)
-- 快速删除
hooksecurefunc(StaticPopupDialogs["DELETE_GOOD_ITEM"],"OnShow",function(boxEditor) boxEditor.editBox:SetText(DELETE_ITEM_CONFIRM_STRING) end)

-- 头像框体隐藏
TargetFrame:UnregisterAllEvents()
TargetFrame:Hide()
PlayerFrame:UnregisterAllEvents()
PlayerFrame:Hide()
-- 拾取框体隐藏
LootFrame:UnregisterAllEvents()
LootFrame:Hide()
-- 姿态条
