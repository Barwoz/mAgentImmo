fx_version 'cerulean'
game 'gta5'

name "mAgentImmo"
description "FiveM resource realestate agent"
author "Barwoz, LQuatre"
version "1.0.0"

server_scripts {
	'@mysql-async/lib/MySQL.lua',
}

shared_scripts {
	'config/*.lua',
	'language/*.lua',
	'language/**/*.lua',
	'main/shared/*.lua',

	'property/config.lua',
}

server_scripts {
	'server.lua',
}

client_scripts {
	'RageUI/RMenu.lua',
    'RageUI/menu/RageUI.lua',
    'RageUI/menu/Menu.lua',
    'RageUI/menu/MenuController.lua',
    'RageUI/components/*.lua',
    'RageUI/menu/elements/*.lua',
    'RageUI/menu/items/*.lua',
    'RageUI/menu/panels/*.lua',
    'RageUI/menu/windows/*.lua',
}

client_scripts {
	'main/client/*.lua',
	'function/client/*.lua',
	'function/client/**/*.lua',
	'event-client/*.lua',

	'instance/client.lua',
	'property/cPM.lua',
	'property/Menu/*.lua',
	'property/client.lua',
}
