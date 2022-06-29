function _cM.GestionBisMenu()
    RageUI.Separator((_Text.PropertyId):format(_cM.PropertyId))
    if _cM.PropertySelected then
        RageUI.Separator((_Text.PropertyLabel):format(_cM.PropertySelected.label))
        RageUI.Separator((_Text.PropertyPrice):format(_cM.PropertySelected.price))
        _cM.LineMenu()
        RageUI.Button(_Text.DeleteProperty, nil, {RightLabel = "→→"}, true, {
            onSelected = function()
                TriggerServerEvent("esx_property:RemoveProperty", _cM.PropertyId)
            end
        }, _SubMenu.Gestion)
        if _cM.ThisCanNotBeSale ~= "" then
            if _cM.ThisCanNotBeSale == "CanNot" then
                RageUI.Button(_Text.DeletePropertyOwner, nil, {RightLabel = "→→"}, true, {
                    onSelected = function()
                        TriggerServerEvent("esx_property:removeOwnedProperty", _cM.PropertySelected.name, _cM.PropertyOwner)
                    end
                }, _SubMenu.Gestion)
            elseif _cM.ThisCanNotBeSale == "Can" then
                RageUI.Button(_Text.SellProperty, nil, {RightLabel = "→→"}, true, {
                    onSelected = function()
                        local closestPlayer, closestPlayerDistance = ESX.Game.GetClosestPlayer()
                        if closestPlayer == -1 or closestPlayerDistance > 3.0 then
                            return (ESX.ShowNotification(_Text.NoProximityPlayer))
                        end
                        local player = ESX.TriggerServerCallback("m:server:GetPlayerIdentifier", function(player)
                            local identifier = player
                            TriggerServerEvent("m:server:setPropertyOwned", _cM.PropertySelected.name, _cM.PropertySelected.price, false, identifier)
                        end, GetPlayerServerId(closestPlayer))   

                        TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_realestateagent', ('realestateagent'), _cM.PropertySelected.price)
                        Wait(100)
                        ESX.ShowNotification("~r~Vous avez bien envoyer la facture")         
                    end
                }, _SubMenu.Gestion)
            end
        end
    end
end