local QBCore = exports['qb-core']:GetCoreObject()

if Config.Inventory == 'qs-inventory' then 
    RegisterCommand("anchorboat", function(source, args, rawCommand)
        local plyPed = PlayerPedId()
        local plyCoords = GetEntityCoords(plyPed)

        if IsPedInAnyBoat(plyPed) then
            local boat = GetVehiclePedIsIn(plyPed, false)

            if GetEntitySpeed(boat) >= 5 then
                QBCore.Functions.Notify("You're going too fast for the anchor to hook on!", "error")
                
                return
            end

            local aq = exports['qs-inventory']:Search('boatanchor')

            if aq <= 0 then
                QBCore.Functions.Notify("You don't have any anchors, please check your pockets.", "error")
                return
            end

            if IsBoatAnchoredAndFrozen(boat) then
                SetBoatAnchor(boat, false)
                SetBoatFrozenWhenAnchored(boat, false)
                QBCore.Functions.Progressbar("DetatchingAnchor", "Detatching Anchor...", 3000, false, true)
                QBCore.Functions.Notify("Anchor Detached!", "success")
              

                
            else
                SetBoatAnchor(boat, true)
                SetBoatFrozenWhenAnchored(boat, true)

                QBCore.Functions.Progressbar("AttatchingAnchor", "Attaching Anchor...", 3000, false, true)
                QBCore.Functions.Notify("Anchor Attached!", "success")     
              
            end
        else
            QBCore.Functions.Notify("You Are Not In A Boat!", "error")
          
        end
    end, false)
elseif Config.Inventory == 'qb-inventory' then 
    RegisterCommand("anchorboat", function(source, args, rawCommand)
        local player = source 
        local playerData = QBCore.Functions.GetPlayerData(player)
        if playerData and playerData.items then
            local hasItem = false
            for _, item in pairs(playerData.items) do
                if item.name == "boatanchor" then 
                    hasItem = true
                    break
                end
            end
        
            if not hasItem then
                QBCore.Functions.Notify("You don't have any anchors, please check your pockets.", "error")
                return
            else
                local plyPed = PlayerPedId()
                local plyCoords = GetEntityCoords(plyPed)
            
                if IsPedInAnyBoat(plyPed) then
                    local boat = GetVehiclePedIsIn(plyPed, false)
            
                    if GetEntitySpeed(boat) >= 5 then
                        QBCore.Functions.Notify("You're going too fast for the anchor to hook on!", "error")
                      
                        return
                    end
            
                    
                    if IsBoatAnchoredAndFrozen(boat) then
                        SetBoatAnchor(boat, false)
                        SetBoatFrozenWhenAnchored(boat, false)
                        QBCore.Functions.Progressbar("DetatchingAnchor", "Detatching Anchor...", 3000, false, true)
                        QBCore.Functions.Notify("Anchor Detached!", "success")
                  
                    else
                        SetBoatAnchor(boat, true)
                        SetBoatFrozenWhenAnchored(boat, true)
            
                        QBCore.Functions.Progressbar("AttatchingAnchor", "Attaching Anchor...", 3000, false, true)
                        QBCore.Functions.Notify("Anchor Attached!", "success")   
                      
                    end
                else
                    QBCore.Functions.Notify("You Are Not In A Boat!", "error")
                    
                end
            end
        end
    end, false)
else 
  wrn('Please Check Your Config.Inventory Located At Editable/Config.lua. Your Inventory Has not been set correctly.')
end 

