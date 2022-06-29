while not _Text do
    Wait(1)
end

_MenuTP = RageUI.CreateMenu((_Text.MenuTitle):format(_Text.JobName), _Text.JobName)
_MenuTP.Closed = function()
    _cPM.MenuOpenTP = false
end
_MenuTP:SetRectangleBanner(_Config.Color[1][1], _Config.Color[1][2], _Config.Color[1][3], _Config.Color[1][4])
_MenuTP:DisplayGlare(false)

-----

_MenuCoffre = RageUI.CreateMenu((_Text.MenuTitle):format(_Text.JobName), _Text.JobName)
_MenuCoffre.Closed = function()
    _cPM.MenuOpenCoffre = false
end
_MenuCoffre:SetRectangleBanner(_Config.Color[1][1], _Config.Color[1][2], _Config.Color[1][3], _Config.Color[1][4])
_MenuCoffre:DisplayGlare(false)
_SubMenuCoffre = {}
for k,v in pairs(_Config.MenuCoffre) do
    _SubMenuCoffre[k] = RageUI.CreateSubMenu(_MenuCoffre, (_Text.MenuTitle):format(_Text.JobName), v)
    _SubMenuCoffre[k]:SetRectangleBanner(_Config.Color[1][1], _Config.Color[1][2], _Config.Color[1][3], _Config.Color[1][4])
    _SubMenuCoffre[k]:DisplayGlare(false)
end
