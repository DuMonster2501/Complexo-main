
fx_version "bodacious"
game "gta5"
ui_page 'web-side/html/index.html'
client_scripts {
	"@vrp/lib/utils.lua",
	"client-side/*"
}
server_scripts {
	"@vrp/lib/utils.lua",
	"server-side/*"
}
files {
	'web-side/**/*.html',
	'web-side/**/*.js',
	'web-side/**/*.css',
}