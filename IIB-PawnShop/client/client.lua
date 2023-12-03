local QBCore = exports['qb-core']:GetCoreObject()
local registeredZones = {}
local registeredPolys = {}
local registeredPeds = {}

Citizen.CreateThread(function()
    for k,v in pairs(Config.Stores) do
        local poly = lib.zones.poly({
            points = v.polyData,
            thickness = 4,
            debug = false,
            inside = inside,
            onEnter = onEnter,
            onExit = onExit,
            name = k
        })
        table.insert(registeredPolys, poly)
    end
end)

function zoneRemove()
    for k,v in pairs(registeredZones) do
        exports['qb-target']:RemoveZone(v)
        registeredZones = {}
    end
    for k,v in pairs(registeredPeds) do
        exports['qb-target']:RemoveTargetEntity(v)
        DeletePed(v)
        registeredPeds = {}
    end
end

function onEnter(self)
    zoneInit(self.name)
end

function onExit(self)
    zoneRemove()
end
 
function inside(self)

end

function zoneInit(zoneName)
    for k,v in pairs(Config.Stores) do
        if zoneName == k then
            local storeName = k
            for i,x in pairs(v.trayLocations) do
                local trayName = storeName..' Tray '.. i
                table.insert(registeredZones, trayName)

                exports['qb-target']:AddBoxZone(trayName, vector3(x.xyz), 1.0, 1.0, { -- The name has to be unique, the coords a vector3 as shown and the 1.5 is the radius which has to be a float value
                        name = trayName, -- This is the name of the zone recognized by PolyZone, this has to be unique so it doesn't mess up with other zones
                        debugPoly = false, -- This is for enabling/disabling the drawing of the box, it accepts only a boolean value (true or false), when true it will draw the polyzone in green
                        minZ = x.z -0.5, -- This is the bottom of the boxzone, this can be different from the Z value in the coords, this has to be a float value
                        maxZ = x.z +0.5,
                        heading = x.w
                    },
                    {
                        options = { -- This is your options table, in this table all the options will be specified for the target to accept
                            { -- This is the first table with options, you can make as many options inside the options table as you want
                                num = 1, -- This is the position number of your option in the list of options in the qb-target context menu (OPTIONAL)
                                icon = 'fas fa-box', -- This is the icon that will display next to this trigger option
                                label = 'View '..trayName, -- This is the label of this option which you would be able to click on to trigger everything, this has to be a string
                                targeticon = 'fas fa-gem', -- This is the icon of the target itself, the icon changes to this when it turns blue on this specific option, this is OPTIONAL
                                action = function(entity) -- This is the action it has to perform, this REPLACES the event and this is OPTIONAL 
                                    openStorage(trayName)
                                end,
                                canInteract = function(entity, distance, data) -- This will check if you can interact with it, this won't show up if it returns false, this is OPTIONAL
                                    return true
                                end,
                            },
                        },
                        distance = 2.5, -- This is the distance for you to be at for the target to turn blue, this is in GTA units and has to be a float value
                    }
                )
            end

            local stashName = storeName..' Stash'
            table.insert(registeredZones, stashName)
            exports['qb-target']:AddBoxZone(stashName, vector3(v.stashLocation.xyz), 1.0, 1.0, { -- The name has to be unique, the coords a vector3 as shown and the 1.5 is the radius which has to be a float value
                    name = stashName, -- This is the name of the zone recognized by PolyZone, this has to be unique so it doesn't mess up with other zones
                    debugPoly = false, -- This is for enabling/disabling the drawing of the box, it accepts only a boolean value (true or false), when true it will draw the polyzone in green
                    minZ = v.stashLocation.z -0.5, -- This is the bottom of the boxzone, this can be different from the Z value in the coords, this has to be a float value
                    maxZ = v.stashLocation.z +0.5,
                    heading = v.stashLocation.w
                },
                {
                    options = { -- This is your options table, in this table all the options will be specified for the target to accept
                        { -- This is the first table with options, you can make as many options inside the options table as you want
                            num = 1, -- This is the position number of your option in the list of options in the qb-target context menu (OPTIONAL)
                            icon = 'fas fa-magnifying-glass', -- This is the icon that will display next to this trigger option
                            label = 'View '..stashName, -- This is the label of this option which you would be able to click on to trigger everything, this has to be a string
                            targeticon = 'fas fa-box', -- This is the icon of the target itself, the icon changes to this when it turns blue on this specific option, this is OPTIONAL
                            action = function(entity) -- This is the action it has to perform, this REPLACES the event and this is OPTIONAL 
                                openStorage(stashName)
                            end,
                            canInteract = function(entity, distance, data) -- This will check if you can interact with it, this won't show up if it returns false, this is OPTIONAL
                                return true
                            end,
                            job = v.job
                        },
                    },
                    distance = 2.5, -- This is the distance for you to be at for the target to turn blue, this is in GTA units and has to be a float value
                }
            )

            lib.requestModel('u_m_y_gunvend_01',500)
            local ped = CreatePed(1, 'u_m_y_gunvend_01', v.pedLocation.xyz, v.pedLocation.w, false, true)
            FreezeEntityPosition(ped, true)
            SetEntityInvincible(ped, true)
            SetBlockingOfNonTemporaryEvents(ped, true)

            table.insert(registeredPeds, ped)
            exports['qb-target']:AddTargetEntity(ped, {
                    options = { -- This is your options table, in this table all the options will be specified for the target to accept
                        { -- This is the first table with options, you can make as many options inside the options table as you want
                            num = 1, -- This is the position number of your option in the list of options in the qb-target context menu (OPTIONAL)
                            icon = 'fas fa-money-bill', -- This is the icon that will display next to this trigger option
                            label = 'Talk To The Pawn Broker?', -- This is the label of this option which you would be able to click on to trigger everything, this has to be a string
                            targeticon = 'fas fa-comments-dollar', -- This is the icon of the target itself, the icon changes to this when it turns blue on this specific option, this is OPTIONAL
                            action = function(entity) -- This is the action it has to perform, this REPLACES the event and this is OPTIONAL 
                                openSellMenu()
                            end,
                            canInteract = function(entity, distance, data) -- This will check if you can interact with it, this won't show up if it returns false, this is OPTIONAL
                                return true
                            end,
                        },
                    },
                    distance = 2.5, -- This is the distance for you to be at for the target to turn blue, this is in GTA units and has to be a float value
                }
            )
        end
    end
end

function openSellMenu()
    QBCore.Functions.TriggerCallback('IIB-PawnShop:server:getInv', function(inventory)
        local PlyInv = inventory
        local pawnMenu = {
            {
                header = "Pawn Shop Salesman",
                isMenuHeader = true,
            }
        }
        for _, v in pairs(PlyInv) do
            for i = 1, #Config.SellItems do
                if v.name == Config.SellItems[i].item then
                    pawnMenu[#pawnMenu + 1] = {
                        header = QBCore.Shared.Items[v.name].label,
                        txt = 'We Are Paying $'..Config.SellItems[i].price..' For This Item.',
                        params = {
                            event = 'IIB-PawnShop:client:pawnitems',
                            args = {
                                label = QBCore.Shared.Items[v.name].label,
                                price = Config.SellItems[i].price,
                                name = v.name,
                                amount = v.amount
                            }
                        }
                    }
                end
            end
        end
        exports['qb-menu']:openMenu(pawnMenu)
    end)
end

RegisterNetEvent('IIB-PawnShop:client:pawnitems', function(item)
    local sellingItem = exports['qb-input']:ShowInput({
        header = 'Pawn Shop Salesman',
        submitText = 'Sell Items',
        inputs = {
            {
                type = 'number',
                isRequired = false,
                name = 'amount',
                text = 'You currently have '.. item.amount..' of this item'
            }
        }
    })
    if sellingItem then
        if not sellingItem.amount then
            return
        end

        if tonumber(sellingItem.amount) > 0 then
            TriggerServerEvent('IIB-PawnShop:server:sellPawnItems', item.name, sellingItem.amount, item.price)
        else
            QBCore.Functions.Notify('Selling a negative?', 'error')
        end
    end
end)

function openStorage(name)
    TriggerServerEvent("inventory:server:OpenInventory", "stash", name, {
        maxweight = 4000000,
        slots = 100,
    })
    TriggerEvent("inventory:client:SetCurrentStash", name)
end

AddEventHandler('onResourceStop', function(resourceName)
    if resourceName == 'IIB-PawnShop' then
        for k,v in pairs(registeredZones) do
            exports['qb-target']:RemoveZone(v)
            registeredZones = {}
        end
        for k,v in pairs(registeredPolys) do
            local zone = v
            zone:remove()
        end
        for k,v in pairs(registeredPeds) do
            exports['qb-target']:RemoveTargetEntity(v)
            DeletePed(v)
            registeredPeds = {}
        end
    end
end)