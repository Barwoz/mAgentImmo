function _cM.GestionMenu()
    for k,v in pairs (Config.Properties) do
        RageUI.Button(v.id.." | "..v.label, nil, { RightLabel = "→→" }, true, {
            onSelected = function()
                _cM.PropertyId = v.id
                _cM.PropertySelected = v

                if Config.OwnedProperties[1] ~= nil then
                    for l,m in pairs(Config.OwnedProperties) do
                        if m.name ~= "" then
                            if v.name == m.name then
                                _cM.ThisCanNotBeSale = "CanNot"
                                _cM.PropertyOwner = m.owner
                            else
                                _cM.ThisCanNotBeSale = "Can"
                            end
                        end
                    end
                else
                    _cM.ThisCanNotBeSale = "Can"
                end
            end
        }, _SubMenu.GestionBis)
    end
end