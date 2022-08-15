fx_version "bodacious"
game "gta5"

client_scripts {
	"@vrp/lib/utils.lua",
	"@PolyZone/client.lua",
	"client-side/*"
}

server_scripts {
	"@vrp/lib/utils.lua",
	"server-side/*"
}

files {
	"web-side/*",
	"web-side/**/*"
}