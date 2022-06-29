function _cPM.MenuCoffre(property, owner)
    RageUI.Button(_Text.InviteTitle, nil, {RightLabel = "→→"}, true, {
        onSelected = function()
            if property.isSingle then
                entering = property.entering
            else
                entering = GetGateway(property).entering
            end
            ESX.TriggerServerCallback("m:server:GetPlayerInArea", function(pInZone)
                _cPM.playersInArea = pInZone
            end, entering, 10.0)
        end
    }, _SubMenuCoffre.Invite)
    RageUI.Button(_Text.DepositObjectTitle, nil, {RightLabel = "→→"}, true, {}, _SubMenuCoffre.DepositObject)
    RageUI.Button(_Text.RemoveObjectTitle, nil, {RightLabel = "→→"}, true, {}, _SubMenuCoffre.RemoveObject)
end