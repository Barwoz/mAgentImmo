function _cM.ActionMenu()
    RageUI.Button(_Text.GestionTitle, nil, {RightLabel = "→→"}, true, {}, _SubMenu.Gestion)
    if _cM.playerGrade == "boss" then
        RageUI.Button(_Text.BossTitle, nil, {RightLabel = "→→"}, true, {
            onSelected = function()
                _cM.BossMenu()
                _cM:isMenuMainOpen()
            end
        })
    end
end