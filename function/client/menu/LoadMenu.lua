function _cM.LoadMainMenu()
    CreateThread(function()
        while _cM.MenuMainOpen do
            Wait(1)
            RageUI.IsVisible(_MenuMain, function()
                _cM.LineMenu()
                _cM.ActionMenu()
                _cM.LineMenu()
            end)
            RageUI.IsVisible(_SubMenu.Gestion, function()
                _cM.LineMenu()
                _cM.GestionMenu()
            end)
            RageUI.IsVisible(_SubMenu.GestionBis, function()
                _cM.LineMenu()
                _cM.GestionBisMenu()
                _cM.LineMenu()
            end)
        end
    end)
end

function _cM.LoadMenuCrea()
    CreateThread(function()
        while _cM.MenuCreaOpen do
            Wait(1)
            RageUI.IsVisible(_MenuCrea, function()
                _cM.LineMenu()
                _cM.MenuCrea()
                _cM.LineMenu()
            end)
        end
    end)
end