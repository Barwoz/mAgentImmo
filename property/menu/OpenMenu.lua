function _cPM.OpenMenuTP(property)
    if _cPM:isMenuTPOpen() then
        _cPM.LoadMenuTP(property)
    end
end

function _cPM.OpenMenuCoffre(property, owner)
    if _cPM:isMenuCoffreOpen() then
        _cPM.LoadMenuCoffre(property, owner)
    end
end