while not _Text do
    Wait(1)
end

_MenuMain = RageUI.CreateMenu((_Text.MenuTitle):format(_Text.JobName), _Text.JobName)
_MenuMain.Closed = function()
    _cM.MenuMainOpen = false
end
_MenuMain:SetRectangleBanner(_Config.Color[1][1], _Config.Color[1][2], _Config.Color[1][3], _Config.Color[1][4])
_MenuMain:DisplayGlare(false)
_SubMenu = {}
for k,v in pairs(_Config.Menu) do 
    _SubMenu[k] = RageUI.CreateSubMenu(_MenuMain, (_Text.MenuTitle):format(_Text.JobName), v)
    _SubMenu[k]:SetRectangleBanner(_Config.Color[1][1], _Config.Color[1][2], _Config.Color[1][3], _Config.Color[1][4])
    _SubMenu[k]:DisplayGlare(false)
end

_MenuCrea = RageUI.CreateMenu((_Text.MenuTitle):format(_Text.JobName), _Text.CreateMenu)
_MenuCrea.Closed = function()
    _cM.MenuCreaOpen = false
end
_MenuCrea:SetRectangleBanner(_Config.Color[1][1], _Config.Color[1][2], _Config.Color[1][3], _Config.Color[1][4])
_MenuCrea:DisplayGlare(false)