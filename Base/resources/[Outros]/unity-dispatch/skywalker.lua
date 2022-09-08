--[ vRP ]-------------------------------------------------------------------------------------------

local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

--[ CONNECTION ]------------------------------------------------------------------------------------

misc = {}
Tunnel.bindInterface("unity-dispatch",misc)

--[ SEARCH TRASH | THREAD ]-------------------------------------------------------------------------

local timers = {}
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		for k,v in pairs(timers) do
			if v > 0 then
				timers[k] = v - 1
			end
		end
	end
end)

--[ SEARCH TRASH | FUNCTION ]-----------------------------------------------------------------------

function misc.amount()
	local source = source
	if amount[source] == nil then
		amount[source] = math.random(1,2)
	end
end

function misc.amountMoney()
	local source = source
	if amountMoney[source] == nil then
		amountMoney[source] = math.random(30,150)
	end
end

function misc.searchTrash(id)
	misc.amount()
	misc.amountMoney()

	local source = source
	local user_id = vRP.getUserId(source)
	local chance = math.random(1,1000)

	if user_id then
		if timers[id] == 0 or not timers[id] then
			if chance >= 985 then
				if vRP.getInventoryWeight(user_id) + vRP.getItemWeight(pagamento)*amountMoney[source] <= vRP.getInventoryMaxWeight(user_id) then
					TriggerClientEvent("unity-dispatch:trashAnim",source)
					pagamento = "dinheiro"
					timers[id] = 600
					return true
				else
					TriggerClientEvent("Notify",source,"negado","Sua mochila está <b>cheia</b>.")
					return false
				end
			elseif chance >= 930 and chance <= 984 then
				if vRP.getInventoryWeight(user_id) + vRP.getItemWeight(pagamento)*amount[source] <= vRP.getInventoryMaxWeight(user_id) then
					TriggerClientEvent("unity-dispatch:trashAnim",source)
					pagamento = itens[math.random(3)].item
					timers[id] = 600
					return true
				else
					TriggerClientEvent("Notify",source,"negado","Sua mochila está <b>cheia</b>.")
					return false
				end
			elseif chance >= 850 and chance <= 929 then
				if vRP.getInventoryWeight(user_id) + vRP.getItemWeight(pagamento)*amount[source] <= vRP.getInventoryMaxWeight(user_id) then
					TriggerClientEvent("unity-dispatch:trashAnim",source)
					pagamento = roupas[math.random(2)].item
					timers[id] = 600
					return true
				else
					TriggerClientEvent("Notify",source,"negado","Sua mochila está <b>cheia</b>.")
					return false
				end
			elseif chance >= 700 and chance <= 849 then
				if vRP.getInventoryWeight(user_id) + vRP.getItemWeight(pagamento)*amount[source] <= vRP.getInventoryMaxWeight(user_id) then
					TriggerClientEvent("unity-dispatch:trashAnim",source)
					pagamento = comidas[math.random(2)].item
					timers[id] = 600
					return true
				else
					TriggerClientEvent("Notify",source,"negado","Sua mochila está <b>cheia</b>.")
					return false
				end
			elseif chance >= 450 and chance <= 699 then
				TriggerClientEvent("unity-dispatch:trashAnim",source)
				pagamento = "rato"
				timers[id] = 600	
				return true
			else
				TriggerClientEvent("unity-dispatch:trashAnim",source)
				pagamento = ""
				timers[id] = 600
				return true
			end
		else
			TriggerClientEvent("Notify",source,"negado","Lixeira está <b>vazia</b>.")
		end
	end
end

function misc.trashPayment()
	local source = source
	local user_id = vRP.getUserId(source)
	
	if user_id then
		if pagamento ~= "" and pagamento ~= "rato" then
			if pagamento == "dinheiro" then
				vRP.giveInventoryItem(user_id,pagamento,amountMoney[source])
				TriggerClientEvent("Notify",source,"sucesso","Você encontrou <b>$"..amountMoney[source].." dólares</b>.")
			else
				vRP.giveInventoryItem(user_id,pagamento,amount[source])
				TriggerClientEvent("Notify",source,"sucesso","Você encontrou <b>x"..amount[source].." "..vRP.itemNameList(pagamento).."</b>.")
			end
			amount[source] = nil
			amountMoney[source] = nil
		elseif pagamento == "rato" then
			TriggerClientEvent("Notify",source,"negado","Não havia nada na lixeira, além de ratos que te morderam.")
			TriggerClientEvent("unity-dispatch:Ragdoll",source)
			vRPclient.varyHealth(user_id,-100)
			Wait(5000)
			TriggerClientEvent("unity-dispatch:Ragdoll",source)
			amount[source] = nil
			amountMoney[source] = nil
		else
			TriggerClientEvent("Notify",source,"negado","Não havia nada na lixeira.")
			amount[source] = nil
			amountMoney[source] = nil
		end
	end
end

--[ WATHER COOLER | FUNCTION ]----------------------------------------------------------------------

function misc.searchCooler()
	local source = source
	local user_id = vRP.getUserId(source)
	if vRP.getInventoryItemAmount(user_id,"garrafavazia") >= 1 then
		if vRP.getInventoryWeight(user_id) + vRP.getItemWeight("agua") <= vRP.getInventoryMaxWeight(user_id) then
			return true
		else
			return false
		end
	else
		return false
	end
end

function misc.coolerPayment()
	local source = source
	local user_id = vRP.getUserId(source)

	if vRP.tryGetInventoryItem(user_id,"garrafavazia",1) then
		SetTimeout(3000,function()
			vRP.giveInventoryItem(user_id,"agua",1)
		end)
	end
end