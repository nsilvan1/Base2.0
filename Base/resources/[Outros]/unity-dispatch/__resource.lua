resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

ui_page "index.html"

client_scripts {
	'@vrp/lib/utils.lua',
	'hansolo/*.lua'
}

files {
	"index.html"
}

server_scripts {
	'@vrp/lib/utils.lua',
	'skywalker.lua'
} 

