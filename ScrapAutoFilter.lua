-- Scrap
local Scrap = CreateFrame("Frame") 
	Scrap:SetScript("OnEvent", function(...) 
	for bag = 0, 4 do 
		for slot = 1, GetContainerNumSlots(bag) do 
        	local link = GetContainerItemLink(bag, slot) 
			if link then
				local quality = select(3, GetItemInfo(link))
				if quality then
					if  quality < 3 then 
					-- the quality of the scrap item '< 3', its the green done
						UseContainerItem(bag, slot) 
					end 
				end
			end
        end 
   	 end 
end) 
Scrap:RegisterEvent("SCRAPPING_MACHINE_PENDING_ITEM_CHANGED")
Scrap:RegisterEvent("SCRAPPING_MACHINE_SCRAPPING_FINISHED")
--Scrap:RegisterEvent("BAG_OPEN")

