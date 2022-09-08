-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
src = {}
Tunnel.bindInterface("vrp_shop_vip",src)
vCLIENT = Tunnel.getInterface("vrp_shop_vip")
local inventory = module("vrp","cfg/inventory")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local carrosvip1 = {} 
local carrosvip2 = {} 
local carrosvip3 = {}
local motosvip = {}
local adicionaisvip = {}
local pacotesvip = {}


--
-- SE NÃO SOUBER O QUE ESTÁ FAZENDO NÃO MEXA EM NADA!
--
-- SE NÃO SOUBER O QUE ESTÁ FAZENDO NÃO MEXA EM NADA!
--
-- SE NÃO SOUBER O QUE ESTÁ FAZENDO NÃO MEXA EM NADA!
--
-- SE NÃO SOUBER O QUE ESTÁ FAZENDO NÃO MEXA EM NADA!
--

-----------------------------------------------------------------------------------------------------------------------------------------
-- SYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	for k,v in pairs(vRP.vehicleGlobal()) do 
		if v.tipo == "carrosvip1" then
			local vehicle = vRP.query("creative/get_estoque",{ vehicle = k })
			if vehicle[1] ~= nil then
				local bau = inventory.chestweight[k] or 50
				table.insert(carrosvip1,{ k = k, nome = v.name, price = v.price2, chest = parseInt(bau), stock = parseInt(vehicle[1].quantidade)})
			end
		end
		if v.tipo == "carrosvip2" then
			local vehicle = vRP.query("creative/get_estoque",{ vehicle = k })
			if vehicle[1] ~= nil then
				local bau = inventory.chestweight[k] or 50
				table.insert(carrosvip2,{ k = k, nome = v.name, price = v.price2, chest = parseInt(bau), stock = parseInt(vehicle[1].quantidade)})
			end
		end
		if v.tipo == "carrosvip3" then
			local vehicle = vRP.query("creative/get_estoque",{ vehicle = k })
			if vehicle[1] ~= nil then
				local bau = inventory.chestweight[k] or 50
				table.insert(carrosvip3,{ k = k, nome = v.name, price = v.price2, chest = parseInt(bau), stock = parseInt(vehicle[1].quantidade)})
			end
		end
		if v.tipo == "motosvip" then
			local vehicle = vRP.query("creative/get_estoque",{ vehicle = k })
			if vehicle[1] ~= nil then
				local bau = inventory.chestweight[k] or 50
				table.insert(motosvip,{ k = k, nome = v.name, price = v.price2, chest = parseInt(bau), stock = parseInt(vehicle[1].quantidade)})
			end
		end
		if v.tipo == "adicionaisvip" then
			table.insert(adicionaisvip,{ k = k, nome = v.name, price = v.price2})
		end
		if v.tipo == "pkgvips" then
			table.insert(pacotesvip,{ k = k, nome = v.name, price = v.price2})
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEVEHICLES
-----------------------------------------------------------------------------------------------------------------------------------------
function src.updateVehicles(vname,vehtype)
	if vehtype == "carrosvip1" then
		for k,v in pairs(carrosvip1) do
			if v.k == vname then
				table.remove(carrosvip1,k)
				local vehicle = vRP.query("creative/get_estoque",{ vehicle = vname })
				if vehicle[1] ~= nil then
					local bau = inventory.chestweight[vname] or 50
					table.insert(carrosvip1,{ k = vname, nome = vRP.vehicleName(vname), price = (vRP.vehiclePrice2(vname)), chest = parseInt(bau), stock = parseInt(vehicle[1].quantidade)})
				end
			end
		end
	elseif vehtype == "carrosvip2" then
		for k,v in pairs(carrosvip2) do
			if v.k == vname then
				table.remove(carrosvip2,k)
				local vehicle = vRP.query("creative/get_estoque",{ vehicle = vname })
				if vehicle[1] ~= nil then
					local bau = inventory.chestweight[vname] or 50
					table.insert(carrosvip2,{ k = vname, nome = vRP.vehicleName(vname), price = vRP.vehiclePrice2(vname), chest = parseInt(bau), stock = parseInt(vehicle[1].quantidade)})
				end
			end
		end
	elseif vehtype == "carrosvip3" then
		for k,v in pairs(carrosvip3) do
			if v.k == vname then
				table.remove(carrosvip3,k)
				local vehicle = vRP.query("creative/get_estoque",{ vehicle = vname })
				if vehicle[1] ~= nil then
					local bau = inventory.chestweight[vname] or 50
					table.insert(carrosvip3,{ k = vname, nome = vRP.vehicleName(vname), price = vRP.vehiclePrice2(vname), chest = parseInt(bau), stock = parseInt(vehicle[1].quantidade)})
				end
			end
		end
	elseif vehtype == "motosvip" then
		for k,v in pairs(motosvip) do
			if v.k == vname then
				table.remove(motosvip,k)
				local vehicle = vRP.query("creative/get_estoque",{ vehicle = vname })
				if vehicle[1] ~= nil then
					local bau = inventory.chestweight[vname] or 50
					table.insert(motosvip,{ k = vname, nome = vRP.vehicleName(vname), price = vRP.vehiclePrice2(vname), chest = parseInt(bau), stock = parseInt(vehicle[1].quantidade)})
				end
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CARROS VIP 1
-----------------------------------------------------------------------------------------------------------------------------------------
function src.CarrosVip1()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		return carrosvip1
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CARROS VIP 2
-----------------------------------------------------------------------------------------------------------------------------------------
function src.CarrosVip2()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		return carrosvip2
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CARROS VIP 3
-----------------------------------------------------------------------------------------------------------------------------------------
function src.CarrosVip3()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		return carrosvip3
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- MOTOS VIP
-----------------------------------------------------------------------------------------------------------------------------------------
function src.MotosVip()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		return motosvip
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADICIONAIS VIP
-----------------------------------------------------------------------------------------------------------------------------------------
function src.AdicionaisVip()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		return adicionaisvip
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PACOTES VIP
-----------------------------------------------------------------------------------------------------------------------------------------
function src.PacotesVip()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		return pacotesvip
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VENDAS
-----------------------------------------------------------------------------------------------------------------------------------------
function src.PossuidosVip()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local veiculos = {}
		local vehicle = vRP.query("creative/get_vehicle",{ user_id = parseInt(user_id) })
		for k,v in pairs(vehicle) do
			if vRP.vehicleType(v.vehicle) == "carrosvip1" then
				local bau = inventory.chestweight[v.vehicle] or 50
				table.insert(veiculos,{ k = v.vehicle, nome = vRP.vehicleName(v.vehicle), price = parseInt(vRP.vehiclePrice(v.vehicle)), chest = parseInt(bau)})
			end
			if vRP.vehicleType(v.vehicle) == "carrosvip2" then
				local bau = inventory.chestweight[v.vehicle] or 50
				table.insert(veiculos,{ k = v.vehicle, nome = vRP.vehicleName(v.vehicle), price = parseInt(vRP.vehiclePrice(v.vehicle)), chest = parseInt(bau)})
			end
			if vRP.vehicleType(v.vehicle) == "carrosvip3" then
				local bau = inventory.chestweight[v.vehicle] or 50
				table.insert(veiculos,{ k = v.vehicle, nome = vRP.vehicleName(v.vehicle), price = parseInt(vRP.vehiclePrice(v.vehicle)), chest = parseInt(bau)})
			end
			if vRP.vehicleType(v.vehicle) == "motosvip" then
				local bau = inventory.chestweight[v.vehicle] or 50
				table.insert(veiculos,{ k = v.vehicle, nome = vRP.vehicleName(v.vehicle), price = parseInt(vRP.vehiclePrice(v.vehicle)), chest = parseInt(bau)})
			end
		end
		return veiculos
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUYSHOP
-----------------------------------------------------------------------------------------------------------------------------------------
function src.buyShop(name)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.vehicleType(name) == "adicionaisvip" then
			if name == "valemansao" then
				if vRP.tryPaymentCoin(user_id,parseInt(vRP.vehiclePrice2(name))) then
					vRP.giveInventoryItem(user_id,"valemansao",1)
					TriggerClientEvent("Notify",source,"sucesso","Você comprou <b> 1x "..vRP.vehicleName(name).."</b> por <b> "..vRP.format(parseInt(vRP.vehiclePrice2(name))).." Moedas</b>.",10000)
				else
					TriggerClientEvent("Notify",source,"negado","Moedas Insuficiente.",10000)
				end
			elseif name == "valefone" then
				if vRP.tryPaymentCoin(user_id,parseInt(vRP.vehiclePrice2(name))) then
					vRP.giveInventoryItem(user_id,"valefone",1)
					TriggerClientEvent("Notify",source,"sucesso","Você comprou <b> 1x "..vRP.vehicleName(name).."</b> por <b> "..vRP.format(parseInt(vRP.vehiclePrice2(name))).." Moedas</b>.",10000)
				else
					TriggerClientEvent("Notify",source,"negado","Moedas Insuficiente.",10000)
				end
			elseif name == "valeplaca" then
				if vRP.tryPaymentCoin(user_id,parseInt(vRP.vehiclePrice2(name))) then
					vRP.giveInventoryItem(user_id,"valeplaca",1)
					TriggerClientEvent("Notify",source,"sucesso","Você comprou <b> 1x "..vRP.vehicleName(name).."</b> por <b> "..vRP.format(parseInt(vRP.vehiclePrice2(name))).." Moedas</b>.",10000)
				else
					TriggerClientEvent("Notify",source,"negado","Moedas Insuficiente.",10000)
				end
			else
				if vRP.tryPaymentCoin(user_id,parseInt(vRP.vehiclePrice2(name))) then
					vRP.giveBankMoney(user_id,parseInt(vRP.vehiclePrice(name)))
					TriggerClientEvent("Notify",source,"sucesso","Você comprou $ <b>"..vRP.format(parseInt(vRP.vehiclePrice(name))).." Dólares</b> por <b> "..vRP.format(parseInt(vRP.vehiclePrice2(name))).." Moedas</b>.",10000)
				end
			end

--
-- DAQUI PARA BAIXO VOCÊ PODE CONFIGURAR OS ITENS QUE CADA VIP VÃO DAR. ITENS | CARROS | DINHEIRO |

-- PARA DAR UM CARRO: vRP.execute("creative/add_vehicle",{ user_id = parseInt(user_id), vehicle = "NOMESPAWN", ipva = os.time() })
-- PARA DAR ITEM: vRP.giveInventoryItem(user_id,"NOMEITEM",QUANTIDADE)
-- PARA DAR DINHEIRO: vRP.giveBankMoney(user_id,parseInt(QUANTIDADE))

-- PARA ADICIONAR ESSES COMANDOS BASTA COLOCALOS ABAIXO DE vRP.insertNewVip NO VIP QUE DESEJA.
--


		elseif vRP.vehicleType(name) == "pkgvips" then
			if name == "pacoteVip1" then 
				if not vRP.getVipActive(user_id) then
					if vRP.tryPaymentCoin(user_id,parseInt(vRP.vehiclePrice2(name))) then
						vRP.addUserGroup(user_id,"Standard")
						vRP.insertNewVip(user_id,"Standard")
						vRP.execute("creative/add_vehicle",{ user_id = parseInt(user_id), vehicle = "amggtr", ipva = os.time() })
						vRP.giveBankMoney(user_id,parseInt(100000))
						TriggerClientEvent("Notify",source,"sucesso","Você se tornou <b>VIP STANDARD</b> por <b> "..vRP.format(parseInt(vRP.vehiclePrice2(name))).." Moedas</b>.",10000)
					else
						TriggerClientEvent("Notify",source,"negado","Moedas Insuficiente.",10000)
					end
				else
					TriggerClientEvent("Notify",source,"importante","Você já possuí um VIP ativo",10000)
				end
			elseif name == "pacoteVip2" then
				if not vRP.getVipActive(user_id) then
					if vRP.tryPaymentCoin(user_id,parseInt(vRP.vehiclePrice2(name))) then
						vRP.addUserGroup(user_id,"Premium")
						vRP.insertNewVip(user_id,"Premium")
						vRP.execute("creative/add_vehicle",{ user_id = parseInt(user_id), vehicle = "amggtr", ipva = os.time() })
						vRP.execute("creative/add_vehicle",{ user_id = parseInt(user_id), vehicle = "19ftype", ipva = os.time() }) -- 19ftype
						vRP.giveBankMoney(user_id,parseInt(200000))
						vRP.giveInventoryItem(user_id,"valemansao",2)
						TriggerClientEvent("Notify",source,"sucesso","Você se tornou <b>VIP PREMIUM</b> por <b> "..vRP.format(parseInt(vRP.vehiclePrice2(name))).." Moedas</b>.",10000)
					else
						TriggerClientEvent("Notify",source,"negado","Moedas Insuficiente.",10000)
					end
				else
					TriggerClientEvent("Notify",source,"importante","Você já possuí um VIP ativo",10000)
				end
			elseif name == "pacoteVip3" then
				if not vRP.getVipActive(user_id) then
					if vRP.tryPaymentCoin(user_id,parseInt(vRP.vehiclePrice2(name))) then
						vRP.addUserGroup(user_id,"Elite")
						vRP.insertNewVip(user_id,"Elite")
						vRP.execute("creative/add_vehicle",{ user_id = parseInt(user_id), vehicle = "amggtr", ipva = os.time() })
						vRP.execute("creative/add_vehicle",{ user_id = parseInt(user_id), vehicle = "19ftype", ipva = os.time() })
						vRP.execute("creative/add_vehicle",{ user_id = parseInt(user_id), vehicle = "porsche992", ipva = os.time() })
						vRP.execute("creative/add_vehicle",{ user_id = parseInt(user_id), vehicle = "yzfr6", ipva = os.time() })
						vRP.giveBankMoney(user_id,parseInt(350000))
						vRP.giveInventoryItem(user_id,"valemansao",2)
						vRP.giveInventoryItem(user_id,"valefone",1)
						TriggerClientEvent("Notify",source,"sucesso","Você se tornou <b>VIP ELITE</b> por <b> "..vRP.format(parseInt(vRP.vehiclePrice2(name))).." Moedas</b>.",10000)
					else
						TriggerClientEvent("Notify",source,"negado","Moedas Insuficiente.",10000)
					end
				else
					TriggerClientEvent("Notify",source,"importante","Você já possuí um VIP ativo",10000)
				end
			else
				if not vRP.getVipActive(user_id) then
					if vRP.tryPaymentCoin(user_id,parseInt(vRP.vehiclePrice2(name))) then
						vRP.addUserGroup(user_id,"Ultimate")
						vRP.insertNewVip(user_id,"Ultimate")
						vRP.execute("creative/add_vehicle",{ user_id = parseInt(user_id), vehicle = "amggtr", ipva = os.time() })
						vRP.execute("creative/add_vehicle",{ user_id = parseInt(user_id), vehicle = "19ftype", ipva = os.time() })
						vRP.execute("creative/add_vehicle",{ user_id = parseInt(user_id), vehicle = "porsche992", ipva = os.time() })
						vRP.execute("creative/add_vehicle",{ user_id = parseInt(user_id), vehicle = "yzfr6", ipva = os.time() })
						vRP.execute("creative/add_vehicle",{ user_id = parseInt(user_id), vehicle = "lamborghinihuracan", ipva = os.time() })
						vRP.execute("creative/add_vehicle",{ user_id = parseInt(user_id), vehicle = "swift2", ipva = os.time() })
						vRP.giveBankMoney(user_id,parseInt(550000))
						vRP.giveInventoryItem(user_id,"valemansao",2)
						vRP.giveInventoryItem(user_id,"valefone",1)
						vRP.giveInventoryItem(user_id,"valeplaca",1)

						TriggerClientEvent("Notify",source,"sucesso","Você se tornou <b>VIP ULTIMATE</b> por <b> "..vRP.format(parseInt(vRP.vehiclePrice2(name))).." Moedas</b>.",10000)
					else
						TriggerClientEvent("Notify",source,"negado","Moedas Insuficiente.",10000)
					end
				else
					TriggerClientEvent("Notify",source,"importante","Você já possuí um VIP ativo",10000)
				end
			end
		else
			if not src.checkVagasGaragem(user_id,0) then
				TriggerClientEvent("Notify",source,"importante","Atingiu o número máximo de veículos em sua garagem.",8000)
				return
			end

			local vehicle = vRP.query("creative/get_vehicles",{ user_id = parseInt(user_id), vehicle = name })
			if vehicle[1] then
				TriggerClientEvent("Notify",source,"importante","Você já possui um <b>"..vRP.vehicleName(name).."</b> em sua garagem.",10000)
				return
			else
				local rows2 = vRP.query("creative/get_estoque",{ vehicle = name })
				if parseInt(rows2[1].quantidade) <= 0 then
					TriggerClientEvent("Notify",source,"aviso","Estoque de <b>"..vRP.vehicleName(name).."</b> indisponivel.",8000)
					return
				end
				if vRP.tryPaymentCoin(user_id,vRP.vehiclePrice2(name)*1) then
					vRP.execute("creative/set_estoque",{ vehicle = name, quantidade = parseInt(rows2[1].quantidade) - 1 })
					vRP.execute("creative/add_vehicle",{ user_id = parseInt(user_id), vehicle = name, ipva = os.time() })
					TriggerClientEvent("Notify",source,"sucesso","Você comprou um <b>"..vRP.vehicleName(name).."</b> por <b> "..vRP.format(parseInt(vRP.vehiclePrice2(name)*1)).." moedas</b>.",10000)
					src.updateVehicles(name,vRP.vehicleType(name))
					if vRP.vehicleType(name) == "carrosvip1" then
						TriggerClientEvent('shopvip:Update',source,'updateCarrosvip1')
					elseif vRP.vehicleType(name) == "carrosvip2" then
						TriggerClientEvent('shopvip:Update',source,'updateCarrosvip2')
					elseif vRP.vehicleType(name) == "carrosvip3" then
						TriggerClientEvent('shopvip:Update',source,'updateCarrosvip3')
					elseif vRP.vehicleType(name) == "motosvip" then
						TriggerClientEvent('shopvip:Update',source,'updateMotosvip')
					end
				else
					TriggerClientEvent("Notify",source,"negado","Moedas Insuficiente.",10000)
				end
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SELLSHOP
-----------------------------------------------------------------------------------------------------------------------------------------
function src.sellShop(name)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local vehicle = vRP.query("creative/get_vehicles",{ user_id = parseInt(user_id), vehicle = name })
		local rows2 = vRP.query("creative/get_estoque",{ vehicle = name })
		if vehicle[1] then
			vRP.execute("creative/rem_vehicle",{ user_id = parseInt(user_id), vehicle = name })
			vRP.execute("creative/rem_srv_data",{ dkey = "custom:u"..parseInt(user_id).."veh_"..name })
			vRP.execute("creative/rem_srv_data",{ dkey = "chest:u"..parseInt(user_id).."veh_"..name })
			vRP.execute("creative/set_estoque",{ vehicle = name, quantidade = parseInt(rows2[1].quantidade) + 1 })
			vRP.giveBankMoney(user_id,parseInt(vRP.vehiclePrice(name)))
			TriggerClientEvent("Notify",source,"sucesso","Você vendeu um <b>"..vRP.vehicleName(name).."</b> por <b>$"..vRP.format(parseInt(vRP.vehiclePrice(name)*1)).." dólares</b>.",10000)
			src.updateVehicles(name,vRP.vehicleType(name))
			TriggerClientEvent('dealership:Update',source,'updatePossuidosvip')
		end
	end
end

function src.permissao()
    local source = source
    local user_id = vRP.getUserId(source)
    return
end

function src.checkVagasGaragem(user_id,index)
	local source = vRP.getUserSource(user_id)
	local maxvehs = vRP.query("creative/con_maxvehs",{ user_id = user_id })
	local maxgars = vRP.query("creative/get_users",{ user_id = user_id })
	
	local adicional;
	if vRP.hasPermission(user_id,"ceo.permissao") then
		adicional = 20 
	elseif vRP.hasPermission(user_id,"admin.permissao") then
		adicional = 5
	elseif vRP.hasPermission(user_id,"mod.permissao") then
		adicional = 2
    else
        adicional = 0;
    end

	if vRP.hasPermission(user_id,"bronze.permissao") then
		adicional = adicional + 2
	elseif vRP.hasPermission(user_id,"prata.permissao") then
		adicional = adicional + 5
	elseif vRP.hasPermission(user_id,"ouro.permissao") then
		adicional = adicional + 999
	elseif vRP.hasPermission(user_id,"platina.permissao") then
		adicional = adicional + 999
    else
        adicional = adicional + 0;
    end
	
	if index == 1 then
		return parseInt(maxgars[1].garagem) + adicional
	end

	if index == 2 then
		return (parseInt(maxgars[1].garagem) + adicional) - parseInt(maxvehs[1].qtd)
	end

	if parseInt(maxvehs[1].qtd) < (parseInt(maxgars[1].garagem) + adicional) then
		return true
	else
		return false
	end
end