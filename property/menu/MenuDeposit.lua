function _cPM.MenuDeposit(property, owner)
    ESX.PlayerData = ESX.GetPlayerData()
    for k, v in pairs(ESX.PlayerData.inventory) do
        if v.count >= 1 then
            RageUI.Button(v.label, nil, {RightLabel = v.count}, true, {
                onSelected = function()
                    local nbDeposit = _TextInput('Combien voulez-vous en déposer ?', '', 3)
                    TriggerServerEvent('esx_property:putItem', owner, 'item_standard', v.name, tonumber(nbDeposit))
                end
            })
        end
    end
end