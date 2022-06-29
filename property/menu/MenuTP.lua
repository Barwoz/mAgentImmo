function _cPM.MenuTP(property)
    if PropertyIsOwned(property) then
        RageUI.Button(_Text.EnterToProperty, nil, {RightLabel = "→→"}, true, {
            onSelected = function()
                TriggerEvent('instance:create', 'property', {property = property.name, owner = ESX.GetPlayerData().identifier})
                _cPM:isMenuTPOpen()
            end
        })
    else
        RageUI.Button(_Text.VisitProperty, nil, {RightLabel = "→→"}, true, {
            onSelected = function()
                TriggerEvent('instance:create', 'property', {property = property.name, owner = ESX.GetPlayerData().identifier})
                _cPM:isMenuTPOpen()
            end
        })
    end
end