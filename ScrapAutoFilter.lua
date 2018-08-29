-- Scrap
local 	Scrap = CreateFrame("Frame") 
		Scrap:SetScript("OnEvent", function(...) 
	for b = 0, 4 do 
		for s = 1,GetContainerNumSlots(b) do 
        local l = GetContainerItemLink(b, s) 
			if l and select(3, GetItemInfo(l)) < 3 then
      -- the quality of the scrap item '< 3', its the green done
               UseContainerItem(b, s) 
            end 
        end 
    end 
end) 
Scrap:RegisterEvent("SCRAPPING_MACHINE_PENDING_ITEM_CHANGED")
Scrap:RegisterEvent("SCRAPPING_MACHINE_SCRAPPING_FINISHED")
