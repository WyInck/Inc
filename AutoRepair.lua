--auto repair
local AutoRepair = true 
local g = CreateFrame("Frame") 
g:RegisterEvent("MERCHANT_SHOW") 
g:SetScript("OnEvent", function()     
   if(AutoRepair==true and CanMerchantRepair()) then 
           local cost = GetRepairAllCost() 
      if cost > 0 then 
         local money = GetMoney() 
         if IsInGuild() then 
            local guildMoney = GetGuildBankWithdrawMoney() 
            if guildMoney > GetGuildBankMoney() then 
               guildMoney = GetGuildBankMoney() 
            end 
            if guildMoney > cost and CanGuildBankRepair() then 
               RepairAllItems(1) 
               print(format("|cff44CCFF公会修理花费:|r  |cffffcc00%.1f金|r", cost * 0.0001)) 
               return 
            end 
         end 
         if money > cost then 
               RepairAllItems() 
               print(format("|cff44CCFF修理花费:|r  |cffffcc00%.1f金|r", cost * 0.0001)) 
         else 
            print("Go farm newbie.") 
         end 
      end 
end 
end)
