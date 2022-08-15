fx_version 'adamant'
game 'gta5'
description 'VNS Casino Slot Games'
version '1.1.0'


server_scripts {
    '@vrp/lib/utils.lua',
    -- '@es_extended/locale.lua',
    'locales/*.lua',
	'config.lua',
	'server.lua'
}

client_scripts {
    '@vrp/lib/utils.lua',
    -- '@es_extended/locale.lua',
    'locales/*.lua',
	'config.lua',
	'client.lua',
}

-- dependency 'es_extended'