local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback('IIB-PawnShop:server:getInv', function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)
    local inventory = Player.PlayerData.items
    return cb(inventory)
end)

RegisterNetEvent("IIB-PawnShop:server:sellPawnItems", function(itemName, itemAmount, itemPrice)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local totalPrice = (tonumber(itemAmount) * itemPrice)
    if Player.Functions.RemoveItem(itemName, tonumber(itemAmount)) then
        Player.Functions.AddMoney("cash", totalPrice)
        TriggerClientEvent("QBCore:Notify", src, 'You have sold '.. itemAmount.. ' x '.. itemName..' for $'..totalPrice, 'success')
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[itemName], 'remove')
    else
        TriggerClientEvent("QBCore:Notify", src, 'You do not have this amount of the item you are selling', "error")
    end
end)
