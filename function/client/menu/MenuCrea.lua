function _cM.MenuCrea()
    if (not _cM.Property.name) then
        RageUI.Button(_Text.NameOfPropertiesCreate, nil, {RightLabel = "→→"}, true, {
            onSelected = function()
                _cM.Property.name = _TextInput("Définir le nom :", "", 20)
            end
        })    
    else 
        RageUI.Button(_Text.NameOfPropertiesCreate, nil, {RightLabel = "~y~".._cM.Property.name}, true, {
            onSelected = function()
                _cM.Property.name = _TextInput("Définir le nom :", "", 20)
            end
        })    
    end

    if (not _cM.Property.label) then
        RageUI.Button(_Text.LabelOfPropertiesCreate, nil, {RightLabel = "→→"}, true, {
            onSelected = function()
                _cM.Property.label = _TextInput("Définir le label:", "", 20)
            end
        })   
    else 
        RageUI.Button(_Text.LabelOfPropertiesCreate, nil, {RightLabel = "~y~".._cM.Property.label}, true, {
            onSelected = function()
                _cM.Property.label = _TextInput("Définir le label:", "", 20)
            end
        })  
    end

    if (not _cM.Property.price) then 
        RageUI.Button(_Text.PriceOfPropertiesCreate, nil, {RightLabel = "→→"}, true, {
            onSelected = function()
                _cM.Property.price = _TextInput("Définir le prix:", "", 7)
            end
        })
    else
        RageUI.Button(_Text.PriceOfPropertiesCreate, nil, {RightLabel = "~y~".._cM.Property.price.."~s~$"}, true, {
            onSelected = function()
                _cM.Property.price = _TextInput("Définir le prix:", "", 7)
            end
        })
    end

    if (not _cM.Property.entering) then
        RageUI.Button(_Text.EnteringOfPropertiesCreate, nil, {RightLabel = "→→"}, true, {
            onSelected = function()
                local pos = GetEntityCoords(PlayerPedId())
                local PlayerCoord = {x = ESX.Math.Round(pos.x, 4), y = ESX.Math.Round(pos.y, 4), z = ESX.Math.Round(pos.z-1, 4)}
                _cM.Property.entering = json.encode(PlayerCoord)
            end
        })
    else 
        RageUI.Button(_Text.EnteringOfPropertiesCreate, nil, {RightLabel = "~y~".._cM.Property.entering}, true, {
            onSelected = function()
                local pos = GetEntityCoords(PlayerPedId())
                local PlayerCoord = {x = ESX.Math.Round(pos.x, 4), y = ESX.Math.Round(pos.y, 4), z = ESX.Math.Round(pos.z-1, 4)}
                _cM.Property.entering = json.encode(PlayerCoord)
            end
        })
    end

    if (not _cM.Property.outside) then
        RageUI.Button(_Text.OutsideOfPropertiesCreate, nil, {RightLabel = "→→"}, true, {
            onSelected = function()
                local pos = GetEntityCoords(PlayerPedId())
                local PlayerCoord = {x = ESX.Math.Round(pos.x, 4), y = ESX.Math.Round(pos.y, 4), z = ESX.Math.Round(pos.z-1, 4)}
                _cM.Property.outside = json.encode(PlayerCoord)
            end
        })
    else 
        RageUI.Button(_Text.OutsideOfPropertiesCreate, nil, {RightLabel = "~y~".._cM.Property.outside}, true, {
            onSelected = function()
                local pos = GetEntityCoords(PlayerPedId())
                local PlayerCoord = {x = ESX.Math.Round(pos.x, 4), y = ESX.Math.Round(pos.y, 4), z = ESX.Math.Round(pos.z-1, 4)}
                _cM.Property.outside = json.encode(PlayerCoord)
            end
        })
    end

    if (not _cM.Property.roommenu) then
        RageUI.Button(_Text.RoomOfPropertiesCreate, nil, {RightLabel = "→→"}, true, {
            onSelected = function()
                local pos = GetEntityCoords(PlayerPedId())
                local PlayerCoord = {x = ESX.Math.Round(pos.x, 4), y = ESX.Math.Round(pos.y, 4), z = ESX.Math.Round(pos.z-1, 4)}
                _cM.Property.roommenu = json.encode(PlayerCoord)
            end
        })
    else 
        RageUI.Button(_Text.RoomOfPropertiesCreate, nil, {RightLabel = "~y~".._cM.Property.roommenu}, true, {
            onSelected = function()
                local pos = GetEntityCoords(PlayerPedId())
                local PlayerCoord = {x = ESX.Math.Round(pos.x, 4), y = ESX.Math.Round(pos.y, 4), z = ESX.Math.Round(pos.z-1, 4)}
                _cM.Property.roommenu = json.encode(PlayerCoord)
            end
        })
    end

    _cM.LineMenu()
    RageUI.Checkbox(_Text.ViewProperties, nil, _cM.Index["Checked"], {}, {
        onChecked = function()
            _cM.Index["Checked"] = true
        end,
        onUnChecked = function()
            _cM.Index["Checked"] = false
        end
    })

    RageUI.List(_Text.InsideProperties, _cM.Item["Title"], _cM.Index["Title"], nil, {}, true, {
        onListChange = function(Index)
            _cM.Index["Title"] = Index
        end,
        onSelected = function(Index)
            if not _cM.Property.BackBos then 
                if (Index ~= #_cM.Item["Title"]) then
                    _cM.Property.BackBos = GetEntityCoords(PlayerPedId())
                end
            end
            _cM.Item["Title"][Index].Function()
        end
    })
    _cM.LineMenu()
    RageUI.Button(_Text.ValideCreateProperties, nil, {Color = {BackgroundColor = {0, 255, 0, 50}}, RightLabel = "→→"}, true, {
        onSelected = function()
            TriggerServerEvent("m:server:saveProperty", _cM.Property)
        end
    })
    RageUI.Button(_Text.AnnulCreateProperties, nil, {Color = {BackgroundColor = {255, 0, 0, 50}}, RightLabel = "→→"}, true, {})
end