function _cPM.MenuRemove(property, owner)
    ESX.TriggerServerCallback('m:getPropertyItems', function(item)
        itemsP = {}
        itemsP = item
    end, owner)

    print('1 : '..ESX.DumpTable(itemsP))

    for k,v in pairs(itemsP or {}) do 
        print('2 : '..ESX.DumpTable(itemsP))
        if v.count >= 1 then
            RageUI.Button(v.label, nil, {RightLabel = v.count}, true, {
                onSelected = function()
                    local nbRemove = _TextInput('Combien voulez-vous en prendre ?', '', 3)
                    TriggerServerEvent('esx_property:getItem', owner, 'item_standard', v.name, tonumber(nbRemove))
                end
            })
        end
    end
end