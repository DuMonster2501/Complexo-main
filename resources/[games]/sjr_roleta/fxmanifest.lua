version '1.0.2'
author 'freamee'
decription 'Aquiver rulett'

client_scripts {
    '@vrp/lib/utils.lua',
    'config.lua',
    'translations.lua',
    'shared/shared_utils.lua',
    'client/cl_main.lua'
}

server_scripts {
    '@vrp/lib/utils.lua',
    'config.lua',
    'translations.lua',
    'shared/shared_utils.lua',
    'server/sv_main.lua'
}

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/js/*.js',
    'html/DEP/*.js',
    'html/img/**',
    'html/ProximaNova.woff'
}

game 'gta5'
fx_version 'adamant'
