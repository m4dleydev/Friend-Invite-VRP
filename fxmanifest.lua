fx_version "cerulean"

description "Welcome Invite"
author "Madley"
version '1.0.0'

lua54 'yes'

games {
  "gta5",
}

ui_page 'interface/build/index.html'

shared_script {
	"config.lua",
	"build/**/*"
}

client_script {
	'@vrp/lib/utils.lua',
	'@vrp/lib/Tools.lua',
	"core/client/**/*"
}

server_script {
	'@vrp/lib/utils.lua',
	'@vrp/lib/Tools.lua',
	"core/server/**/*"
}


files {
	'interface/build/index.html',
	'interface/build/**/*',
}