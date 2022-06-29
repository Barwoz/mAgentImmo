_cM = {
    -- MENU

    MenuMainOpen = false,
    isMenuMainOpen = function(self)
        if not self.MenuMainOpen then
            self.MenuMainOpen = true    
            RageUI.Visible(_MenuMain, self.MenuMainOpen)
        else
            self.MenuMainOpen = false
            RageUI.Visible(_MenuMain, self.MenuMainOpen)
        end
        return self.MenuMainOpen
    end,

    -- 

    MenuCreaOpen = false,
    isMenuCreaOpen = function(self)
        if not self.MenuCreaOpen then
            self.MenuCreaOpen = true    
            RageUI.Visible(_MenuCrea, self.MenuCreaOpen)
            _cM.Property = {}
        else
            self.MenuCreaOpen = false
            RageUI.Visible(_MenuCrea, self.MenuCreaOpen)
        end
        return self.MenuCreaOpen
    end,

    --

    ThisCanNotBeSale = "",

    --

    Index = {
        ["Title"] = 1,
        ["Announcement"] = 1,
        ["Checked"] = false,
    },

    Item = {
        ["Title"] = {
            {
                Name = "Petit Appartement", 
                Function = function()
                    if _cM.Index["Checked"] then
                        SetEntityCoords(GetPlayerPed(-1), 265.6031, -1002.9244, -99.0086)
                    end
                    _cM.Property.ipl = '[]'
                    _cM.Property.inside = '{"x":265.307,"y":-1002.802,"z":-101.008}'
                    _cM.Property.exit = '{"x":266.0773,"y":-1007.3900,"z":-101.008}'
                    _cM.Property.isSingle = 1
                    _cM.Property.isRoom = 1
                    _cM.Property.isGateway = 0    
                end
            },
            {
                Name = "Moyen Appartement", 
                Function = function()
                    if _cM.Index["Checked"] then
                        SetEntityCoords(GetPlayerPed(-1), -616.8566, 59.3575, 98.2000)
                    end
                    _cM.Property.ipl = '[]'
                    _cM.Property.inside = '{"x":265.307,"y":-1002.802,"z":-101.008}'
                    _cM.Property.exit = '{"x":266.0773,"y":-1007.3900,"z":-101.008}'
                    _cM.Property.isSingle = 1
                    _cM.Property.isRoom = 1
                    _cM.Property.isGateway = 0      
                end
            },
            {
                Name = "Grand Appartement",
                Function = function()
                    if _cM.Index["Checked"] then
                        SetEntityCoords(GetPlayerPed(-1), -777.89, 317.10, 176.80)
                    end
                    _cM.Property.ipl = '["apa_v_mp_h_01_a"]'
                    _cM.Property.inside = '{"x":-777.89,"y":317.10,"z":176.80}'
                    _cM.Property.exit = '{"x":-777.89,"y":317.10,"z":176.80}'
                    _cM.Property.isSingle = 1
                    _cM.Property.isRoom = 1
                    _cM.Property.isGateway = 0
                end
            },
            {
                Name = "Grand Appartement Bis",
                Function = function()
                    if _cM.Index["Checked"] then
                        SetEntityCoords(GetPlayerPed(-1), -1459.1700, -520.5855, 56.9247) 
                    end 
                    _cM.Property.ipl = '[]'
                    _cM.Property.inside = '{"x":-1459.17,"y":-520.58,"z":54.929}'
                    _cM.Property.exit = '{"x":-1451.6394,"y":-523.5562,"z":55.9290}'
                    _cM.Property.isSingle = 1
                    _cM.Property.isRoom = 1
                    _cM.Property.isGateway = 0
                end
            },
            {
                Name = "Grande Maison",
                Function = function()
                    if _cM.Index["Checked"] then
                        SetEntityCoords(GetPlayerPed(-1), -674.4503, 595.6156, 145.3796)
                    end
                    _cM.Property.ipl = '[]'
                    _cM.Property.inside = '{"x":-680.6088,"y":590.5321,"z":145.39}'
                    _cM.Property.exit = '{"x":-681.6273,"y":591.9663,"z":144.3930}'			
                    _cM.Property.isSingle = 1
                    _cM.Property.isRoom = 1
                    _cM.Property.isGateway = 0
                end
            },
            {
                Name = "Hotel",
                Function = function()
                    if _cM.Index["Checked"] then
                        SetEntityCoords(GetPlayerPed(-1), 151.0994, -1007.8073, -98.9999)
                    end
                    _cM.Property.ipl = '["hei_hw1_blimp_interior_v_motel_mp_milo_"]'
                    _cM.Property.inside = '{"x":151.45,"y":-1007.57,"z":-98.9999}'
                    _cM.Property.exit = '{"x":151.3258,"y":-1007.7642,"z":-100.0000}'
                    _cM.Property.isSingle = 1
                    _cM.Property.isRoom = 1
                    _cM.Property.isGateway = 0
                end
            },
            {
                Name = "Grand Entrepot",
                Function = function()
                    if _cM.Index["Checked"] then
                        SetEntityCoords(GetPlayerPed(-1), 1026.8707, -3099.8710, -38.9998)
                    end
                    _cM.Property.ipl = '[]'
                    _cM.Property.inside = '{"x":1026.5056,"y":-3099.8320,"z":-38.9998}'
                    _cM.Property.exit   = '{"x":998.1795"y":-3091.9169,"z":-39.9999}'
                    _cM.Property.isSingle = 1
                    _cM.Property.isRoom = 1
                    _cM.Property.isGateway = 0
                end
            },
            {
                Name = "Moyen Entrepot", 
                Function = function()
                    if _cM.Index["Checked"] then
                        SetEntityCoords(GetPlayerPed(-1), 1072.8447, -3100.0390, -38.9999)
                    end
                    _cM.Property.ipl = '[]'
                    _cM.Property.inside = '{"x":1048.5067,"y":-3097.0817,"z":-38.9999}'
                    _cM.Property.exit   = '{"x":1072.5505,"y":-3102.5522,"z":-39.9999}'
                    _cM.Property.isSingle = 1
                    _cM.Property.isRoom = 1
                    _cM.Property.isGateway = 0
                end
            },
            {
                Name = "Petit Entrepot",
                Function = function()
                    if _cM.Index["Checked"] then
                        SetEntityCoords(GetPlayerPed(-1), 1104.7231, -3100.0690, -38.9999)
                    end
                    _cM.Property.ipl = '[]'
                    _cM.Property.inside = '{"x":1088.1834,"y":-3099.3547,"z":-38.9999}'
                    _cM.Property.exit   = '{"x":1104.6102,"y":-3099.4333,"z":-39.9999}'
                    _cM.Property.isSingle = 1
                    _cM.Property.isRoom = 1
                end
            },
            {
                Name = "Sous-Marin",
                Function = function()
                    if _cM.Index["Checked"] then
                        SetEntityCoords(GetPlayerPed(-1), 514.33, 4886.18, -62.59)
                    end
                    _cM.Property.ipl = '[]'
                    _cM.Property.inside = '{"x":514.3687,"y":4885.9448,"z":-62.590}'
                    _cM.Property.exit = '{"x":514.292,"y":4887.785,"z":-62.590}'				
                    _cM.Property.isSingle = 1
                    _cM.Property.isRoom = 1
                    _cM.Property.isGateway = 0
                end
            },
            {
                Name = "Salle de Psy",
                Function = function()
                    if _cM.Index["Checked"] then
                        SetEntityCoords(GetPlayerPed(-1), -1902.603, -573.016, 19.09)
                    end
                    _cM.Property.ipl = '[]'
                    _cM.Property.inside = '{"x":-1902.603,"y":-573.016,"z":19.09}'
                    _cM.Property.exit = '{"x":-1902.236,"y":-572.634,"z":19.09}'				
                    _cM.Property.isSingle = 1
                    _cM.Property.isRoom = 1
                    _cM.Property.isGateway = 0
                end
            },
            {
                Name = "Grand Garage",
                Function = function()
                    if _cM.Index["Checked"] then
                        SetEntityCoords(GetPlayerPed(-1), -1520.95, -3002.184, -82.207)
                    end
                    _cM.Property.ipl = '[]'
                    _cM.Property.inside = '{"x":-1520.95,"y":-3002.184,"z":-82.207}'
                    _cM.Property.exit = '{"x":-1520.808,"y":-2978.501,"z":-80.453}'				
                    _cM.Property.isSingle = 1
                    _cM.Property.isRoom = 1
                    _cM.Property.isGateway = 0 
                end
            },
            {
                Name = "Grande Maison Bis",
                Function = function()
                    if _cM.Index["Checked"] then
                        SetEntityCoords(GetPlayerPed(-1), -174.284, 497.640, 137.663)
                    end
                    _cM.Property.ipl = '[]'
                    _cM.Property.inside = '{"x":-173.977,"y":496.7333,"z":137.666}'
                    _cM.Property.exit = '{"x":-174.284,"y":497.640,"z":137.663}'				
                    _cM.Property.isSingle = 1
                    _cM.Property.isRoom = 1
                    _cM.Property.isGateway = 0
                end
            },
            {
                Name = "~r~Retour~s~",
                Function = function()
                    if _cM.Index["Checked"] then
                        SetEntityCoords(GetPlayerPed(-1), _cM.Property.BackBos)
                    end
                end
            }
        },
    },
}