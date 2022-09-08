fx_version "bodacious"
game "gta5"


this_is_a_map 'yes'


client_scripts {
	"@vrp/lib/utils.lua",
	"admin/client.lua",
	"emergencyblips/client.lua",
	"hospital/client.lua",
	"player/client.lua",
	"/puxararma/configpuxararma.lua",
	"/puxararma/clientpuxararma.lua",
	"policia/client.lua",
	"animacoes/tiodan_cl.lua",
	"itemdrop/client.lua",


	"yaga_antcl/client.lua",
	"yaga_antcl/config.lua"


}
server_scripts {
	"@vrp/lib/utils.lua",
	"admin/server.lua",
	"emergencyblips/server.lua",
	"hospital/server.lua",
	"player/server.lua",
	"/puxararma/configpuxararma.lua",
	"policia/server.lua",
	"animacoes/tiodan_sv.lua",
	"itemdrop/server.lua",

	"yaga_antcl/server.lua",
	"yaga_antcl/config.lua"

}