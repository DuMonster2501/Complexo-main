fx_version "bodacious"
game "gta5"

ui_page "ui/build/index.html"
files {
	"ui/build/*",
	"ui/build/**/*",
	"ui/build/**/**/*"
}

client_scripts {
	"@vrp/lib/utils.lua",
	"client-side/*"
}

server_scripts {
	"@vrp/lib/utils.lua",
	"server-side/*"
}