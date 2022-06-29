_cPM = {
    -- MENU

    MenuOpenTP = false,
    isMenuTPOpen = function(self)
        if not self.MenuOpenTP then
            self.MenuOpenTP = true    
            RageUI.Visible(_MenuTP, self.MenuOpenTP)
        else
            self.MenuOpenTP = false
            RageUI.Visible(_MenuTP, self.MenuOpenTP)
        end
        return self.MenuOpenTP
    end,

-----
    
    MenuOpenCoffre = false,
    isMenuCoffreOpen = function(self)
        if not self.MenuOpenCoffre then
            self.MenuOpenCoffre = true    
            RageUI.Visible(_MenuCoffre, self.MenuOpenCoffre)
        else
            self.MenuOpenCoffre = false
            RageUI.Visible(_MenuCoffre, self.MenuOpenCoffre)
        end
        return self.MenuOpenCoffre
    end,

}