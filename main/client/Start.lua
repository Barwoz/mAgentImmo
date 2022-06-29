ESX = nil

CreateThread(function()
    while ESX == nil do
        TriggerEvent(_Config.getInitFramework, function(obj) ESX = obj end)
        Wait(0)
    end
    while (not (NetworkIsPlayerActive(PlayerId()))) do
        Wait(5000)
    end
    Wait(4000)
    TriggerServerEvent("m:server:playerLoaded")
end)