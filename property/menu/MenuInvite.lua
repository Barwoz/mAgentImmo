function _cPM.MenuInvite(property, owner)
    if _cPM.playersInArea then 
        if _cPM.playersInArea[1] ~= nil then 
            for k,v in pairs(_cPM.playersInArea) do
                if v.id ~= GetPlayerServerId(PlayerId()) then
                    RageUI.Button(v.name, nil, {RightLabel = "→→"}, true, {
                        onSelected = function()
                            TriggerEvent('instance:invite', 'property', v.id, {property = property.name, owner = owner})
                            ESX.ShowNotification((_Text.you_invited):format(v.name))
                        end
                    })
                end
            end
        else
            RageUI.Separator()
            RageUI.Separator(_Text.NoPlayer)
            RageUI.Separator()
        end
    end
end

