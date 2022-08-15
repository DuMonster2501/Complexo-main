client_script "@vrp/lib/lib.lua" --Para remover esta pendencia de todos scripts, execute no console o comando "uninstall"

fx_version 'adamant'
game 'gta5'

client_scripts {
    '@vrp/lib/utils.lua',
	'shared/shared_utils.lua',
	'translations.lua',
    'src/RMenu.lua',
    'src/menu/RageUI.lua',
    'src/menu/Menu.lua',
    'src/menu/MenuController.lua',
    'src/components/*.lua',
    'src/menu/elements/*.lua',
    'src/menu/items/*.lua',
    'src/menu/panels/*.lua',
    'src/menu/panels/*.lua',
    'src/menu/windows/*.lua',
    'config.lua',
    'client/cl_main.lua'
}

server_scripts {
    '@vrp/lib/utils.lua',
	'shared/shared_utils.lua',
	'translations.lua',
    'config.lua',
    'server/sv_main.lua'
}              