function _cM.OpenMainMenu()
    if _cM:isMenuMainOpen() then 
        _cM.LoadMainMenu()
    end
end

function _cM.OpenMenuCrea()
    if _cM:isMenuCreaOpen() then
        _cM.LoadMenuCrea()
    end
end