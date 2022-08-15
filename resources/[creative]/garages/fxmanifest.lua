fx_version "bodacious"
game "gta5"

ui_page "web-side/index.html"

client_scripts {
	"@vrp/lib/utils.lua",
	"client-side/client.lua"
}

server_scripts {
	"@vrp/lib/utils.lua",
	"server-side/server.lua"
}

files {
	"web-side/*",
	"web-side/css/*",
	"web-side/js/*"
}