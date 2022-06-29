RegisterNetEvent("magent:client:abilities")
AddEventHandler("magent:client:abilities", function(data, grade)
    _cM.Abilities = data
    _cM.playerGrade = grade

    if _cM.Abilities == true then
        Keys.Register(_Config.Control, _Config.Control, (_Text.DescKeyMenu):format(_Text.JobName), function()
            _cM.OpenMenuCrea()
        end)
    end
        
    while _cM.Abilities do
        Interval = 1500
        local dist = GetEntityCoords(GetPlayerPed(-1), false)
        if #(dist - _Config.Action.position) < 2.0 then
            Interval = 1
            while not ESX do
                Wait(1)
            end
            ESX.ShowHelpNotification((_Text.TextAction):format(_Config.Action.KeyImput))
            DrawMarker(20, _Config.Action.position, 0.0, 0.0, 0.0, 180.0, 0.0, 0.0, 0.5, 0.3, 0.5, 204, 66, 80, 155, true, true, p19, true) 
            if IsControlJustPressed(1, _Keys[_Config.Action.Key]) then
                _cM.OpenMainMenu()
            end
        end
        Wait(Interval)
    end
end)