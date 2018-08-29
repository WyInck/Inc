--auto sell junk
local f = CreateFrame("Frame") 
f:SetScript("OnEvent", function(...) 
   local c = 0 
   for b = 0, 4 do 
      for s = 1,GetContainerNumSlots(b) do 
         local l = GetContainerItemLink(b, s) 
         if l and select(3, GetItemInfo(l)) == 0 then
         -- the quality of sell item, 0 = junk
            local p = select(11, GetItemInfo(l)) * select(2, GetContainerItemInfo(b, s)) 
            if p > 0 then 
               UseContainerItem(b, s) 
               PickupMerchantItem() 
               c = c + p 
            end 
         end 
      end 
   end 
   if c > 0 then 
      local g, s, c = math.floor(c/10000) or 0, math.floor((c%10000)/100) or 0, c%100 
      DEFAULT_CHAT_FRAME:AddMessage("|cff44CCFF售卖垃圾: |r".." |cffffcc00"..g.."金".." |cffffcc00"..s.."银".." |cffffcc00"..c.."铜")
   end 
end) 
f:RegisterEvent("MERCHANT_SHOW")
