local vmheight = 450
local vmwidth = 200
local vm = ObjectiveTrackerFrame

-- quest name colors by class 
local r, g, b = 103/255, 103/255, 103/255
local class = select(2, UnitClass("player"))
local colour = CUSTOM_CLASS_COLORS and CUSTOM_CLASS_COLORS[class] or RAID_CLASS_COLORS[class]

hooksecurefunc(QUEST_TRACKER_MODULE, "SetBlockHeader", function(_, block)
		block.HeaderText:SetFont(STANDARD_TEXT_FONT, 15)
        block.HeaderText:SetShadowOffset(0, 0)
        block.HeaderText:SetShadowColor(0, 0, 0, 1)
        block.HeaderText:SetTextColor(colour.r, colour.g, colour.b)
        block.HeaderText:SetJustifyH("Left")
        block.HeaderText:SetWidth(vmwidth)
local heightcheck = block.HeaderText:GetNumLines()      
        if heightcheck==2 then
            local height = block:GetHeight()     
            block:SetHeight(height + 2)
        end
end)

local function hoverquest(_, block)
        block.HeaderText:SetTextColor(colour.r, colour.g, colour.b)
end
hooksecurefunc(QUEST_TRACKER_MODULE, "OnBlockHeaderEnter", hoverquest)  
hooksecurefunc(QUEST_TRACKER_MODULE, "OnBlockHeaderLeave", hoverquest)


hooksecurefunc(ACHIEVEMENT_TRACKER_MODULE, "SetBlockHeader", function(_, block)
    local trackedAchievements = {GetTrackedAchievements()}
    
    for i = 1, #trackedAchievements do
	    local achieveID = trackedAchievements[i]
	    local _, achievementName, _, completed, _, _, _, description, _, icon, _, _, wasEarnedByMe = GetAchievementInfo(achieveID)
        local showAchievement = true
        
	    if wasEarnedByMe then
		    showAchievement = false
	    elseif displayOnlyArena then
		    if GetAchievementCategory(achieveID)~=ARENA_CATEGORY then
			    showAchievement = false
		    end
	    end
	    
        if showAchievement then
            block.HeaderText:SetFont(STANDARD_TEXT_FONT, 15)
            block.HeaderText:SetShadowOffset(0, 0)
            block.HeaderText:SetShadowColor(0, 0, 0, 1)
            block.HeaderText:SetTextColor(colour.r, colour.g, colour.b)
            block.HeaderText:SetJustifyH("Left")
            block.HeaderText:SetWidth(vmwidth)
        end
    end
end)
  
local function hoverachieve(_, block)
        block.HeaderText:SetTextColor(colour.r, colour.g, colour.b)
    end
  
hooksecurefunc(ACHIEVEMENT_TRACKER_MODULE, "OnBlockHeaderEnter", hoverachieve)
hooksecurefunc(ACHIEVEMENT_TRACKER_MODULE, "OnBlockHeaderLeave", hoverachieve)

 ----- quest lv -----
local QuestLevelPatch = {}
function SetBlockHeader_hook()
for i = 1, GetNumQuestWatches() do
	local questID, title, questLogIndex, numObjectives, requiredMoney, isComplete, startEvent, isAutoComplete, failureTime, timeElapsed, questType, isTask, isStory, isOnMap, hasLocalPOI = GetQuestWatchInfo(i)
	if ( not questID ) then
		break
	end
	local oldBlock = QUEST_TRACKER_MODULE:GetExistingBlock(questID)
	if oldBlock then
		local oldHeight = QUEST_TRACKER_MODULE:SetStringText(oldBlock.HeaderText, title, nil, OBJECTIVE_TRACKER_COLOR["Header"])
		local questLevel = select(2, GetQuestLogTitle(questLogIndex))
		local newTitle = title
		if questLevel ~= 120 then
			newTitle = "["..questLevel.."] "..title
		end
			newTitle = string.gsub(newTitle, "，奥迪尔", "")
			newTitle = string.gsub(newTitle, "，奥迪尔", "")
		local newHeight = QUEST_TRACKER_MODULE:SetStringText(oldBlock.HeaderText, newTitle, nil, OBJECTIVE_TRACKER_COLOR["Header"])
	end

end
end
hooksecurefunc(QUEST_TRACKER_MODULE, "Update", SetBlockHeader_hook)
function QuestInfo_hook(template, parentFrame, acceptButton, material, mapView)
local elementsTable = template.elements
for i = 1, #elementsTable, 3 do
	if elementsTable[i] == QuestInfo_ShowTitle then
		if QuestInfoFrame.questLog then
			local questLogIndex = GetQuestLogSelection()
			local level = select(2, GetQuestLogTitle(questLogIndex))
			--local newTitle = "["..level.."] "..QuestInfoTitleHeader:GetText()
			--QuestInfoTitleHeader:SetText(newTitle)
		end
	end
end
end
hooksecurefunc("QuestInfo_Display", QuestInfo_hook)
