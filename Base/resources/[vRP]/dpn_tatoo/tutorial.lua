-- alguns clientes me reclamaram que ao sair da loja de roupas por ex as tataugens sumiam,
-- para arrumar esse bug coloque a seguinte linha no código seguindo o tutorial

-- CLIENT.LUA
-- Pesquise o código abaixo:
	vRP.setCustomization...

-- Após achar esse código, coloque o código abaixo em baixo dele.

	TriggerServerEvent('dpn_tattoo:setPedClient')
-------------------------------------------------------------------------

-- SERVER.LUA
-- Pesquise o código abaixo:

	vRPclient._setCustomization... 

-- Após achar esse código, coloque o código abaixo em baixo dele.

	TriggerEvent('dpn_tattoo:setPedServer',source)
-------------------------------------------------------------------------





