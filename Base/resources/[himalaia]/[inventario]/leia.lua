-- vazamento por dogz1n community
-- discord.gg/dogz1n


-- NÃO TEM SEGREDO NA INSTALAÇÃO! COLOQUE OS ARQUIVOS DO XAMPP NA RAIZ DO HTDOCS >
-- c:\xampp\htdocs




-- TUTORIAL ABAIXO PELO PROPRIO PEDRO D!





-- A primeira coisa a se fazer é mudar alguma funções da sua base (não se preucupe se não entenda algum termo)
-- Abra a sua pasta vrp, vá em modules e depois em inventory
-- Irá aparecer um código bem grande mas não se preucupe não precisa entender tudo oque está la,
-- Você irá procurar por vRP.giveInventoryItem
-- Encontrará algo mais ou menos assim 

function vRP.giveInventoryItem(user_id,idname,amount)
	local amount = parseInt(amount)
	local data = vRP.getUserDataTable(user_id)
	if data and amount > 0 then
		local entry = data.inventory[idname]
		if entry then
			entry.amount = entry.amount + amount
		else
			data.inventory[idname] = { amount = amount }
		end
	end
end

-- Você apagará tuda essa função ou seja todo essa parte de código.
-- Feito isso você irá nas ultimas linhas do vrp, modules, inventory
-- Você dará alguns enters para dar um espaço entre as linhas e colará o seguinte código

function returnList(item)
	if itemlist[item] ~= nil then
		return itemlist[item]
	end
end

function vRP.giveInventoryItem(user_id,idname,amount,slot)
	local amount = parseInt(amount)
	local inventory = vRP.getUserDataTable(user_id)
	local data = inventory.inventory
	local stop = false
	local newSlotPlayer = 0

	if data and amount > 0 then
		if tostring(slot) == tostring('true') or  tostring(slot) == tostring('false') then
			slot = nil
		end
		if idname then
			if slot then
				if data[tostring(slot)] == nil then
					data[tostring(slot)] = { item = idname, amount = parseInt(amount) }
				else
					if idname == data[tostring(slot)].item then
						data[tostring(slot)].amount = parseInt(data[slot].amount) + parseInt(amount)
					end
				end
			else
				for k,v in pairs(inventory.inventory) do
					if v.item == idname then
						local slot = k
						data[tostring(slot)].amount = parseInt(data[slot].amount) + parseInt(amount)
						stop = true
						break
					end
				end
	
				if stop == false then
					repeat
						newSlotPlayer = newSlotPlayer + 1
					until data[tostring(newSlotPlayer)] == nil or (data[tostring(newSlotPlayer)] and data[tostring(newSlotPlayer)].item == idname)
					newSlotPlayer = tostring(newSlotPlayer)
					data[tostring(newSlotPlayer)] = { item = idname, amount = parseInt(amount) }
				end
			end
		end
	end
end

-- Após isso procurará por vRP.tryGetInventoryItem
-- Encontrará algo mais ou menos assim 

function vRP.tryGetInventoryItem(user_id,idname,amount)
	local amount = parseInt(amount)
	local data = vRP.getUserDataTable(user_id)
	if data and amount > 0 then
		--if idname == "tora" or idname == "carnedepuma" or idname == "etiqueta" then
			--creativeLogs(creative_itens,"**USER_ID:** "..user_id.." **ITEM:** "..idname.." - **QUANTIDADE:** "..parseInt(amount).." - "..os.date("%H:%M:%S"))
		--end
		local entry = data.inventory[idname]
		if entry and entry.amount >= amount then
			entry.amount = entry.amount - amount

			if entry.amount <= 0 then
				data.inventory[idname] = nil
			end
			return true
		end
	end
	return false
end

-- Você deve fazer o mesmo e apagar toda essa parte de código do seu vrp, modules, inventory
-- Após isso colará o seguinte código embaixo da função de cima (não esqueça de dar alguns enters para dar um espaçamento)

function vRP.tryGetInventoryItem(user_id, itemName, amount, slot)
    if type(slot) ~= "number" then
        slot = nil
    end

    local dataTable = vRP.getUserDataTable(user_id)
    if dataTable and dataTable.inventory then
        local playerInventory = dataTable.inventory
        if slot then
            slot = tostring(slot)
            if playerInventory[slot] then
                if playerInventory[slot].item == itemName then
                    if playerInventory[slot].amount >= amount then
                        if playerInventory[slot].amount == amount then
                            playerInventory[slot] = nil
                        else
                            playerInventory[slot].amount = (playerInventory[slot].amount - amount)
                        end
                        return true
                    end
                end
            end
        else
            if vRP.getInventoryItemAmount(user_id, itemName) < amount then 
                return false 
            end

            local totalQuantity = 0
            for k,v in pairs(playerInventory) do
                if v.item == itemName then
                    totalQuantity = totalQuantity + v.amount                    
                    if totalQuantity >= amount then
                        playerInventory[k].amount = (totalQuantity - amount)
                        if totalQuantity == amount then
                            playerInventory[k] = nil
                        end
                        return true
                    else
                        playerInventory[k] = nil
                    end
                end
            end
        end
    end
    return false
end


function vRP.delteItem(user_id,idname)
	local table = vRP.getUserDataTable(user_id)
	local data = table.inventory
	for k,v in pairs(data) do
		if tostring(v.item) == tostring(idname) then
			data[tostring(k)] = nil
		end
	end
end

function vRP.updateItens(user_id,idname)
	local table = vRP.getUserDataTable(user_id)
	local data = table.inventory
	for k,v in pairs(data) do
		if tostring(k) == tostring(idname) then
			data[tostring(idname)] = nil
			return true
		end
	end
end

-- Estamos quase acabando agora você dará mais alguns enters em baixo doque você ja colou
-- Procure agora por vRP.getInventoryItemAmount
-- Você encontará algo mais ou menos assim 

function vRP.getInventoryItemAmount(user_id,idname)
	local data = vRP.getUserDataTable(user_id)
	if data and data.inventory then
		local entry = data.inventory[idname]
		if entry then
			return entry.amount
		end
	end
	return 0
end

-- Apague tudo da mesma maneira como ja estamos fazendo,
-- Após isso cole embaixo da função do que colamos a cima o seguitne código 

function vRP.getInventoryItemAmount(user_id,idname)
	local data = vRP.getUserDataTable(user_id)
	local quantidade = 0
	if data and data.inventory then
		for k,v in pairs(data.inventory) do
			if v.item == idname then
				quantidade = parseInt(quantidade) + parseInt(v.amount)
			end
		end
		return quantidade
	end
	return 0
end


-- Agora procure por computeItemsWeight
-- Você deve ecnontrar algo assim amis ou menos

function vRP.computeItemsWeight(items)
	local weight = 0
	for k,v in pairs(items) do
		local iweight = vRP.getItemWeight(k)
		weight = weight+iweight*v.amount
	end
	return weight
end

--  Apague es subsitua por 

function vRP.computeItemsWeight(items)
	local weight = 0
	for k,v in pairs(items) do
		local iweight = vRP.getItemWeight(v.item)
		weight = weight+iweight*v.amount
	end
	return weight
end

-- Ultima coisa no modules vá no final desse código que você colou de mais alguns enters para seprar e cole o seguinte código:

function vRP.updateSlot(user_id,item,oldSlot,newSlot,amount)
	local inventory = vRP.getUserDataTable(user_id)
	local data = inventory.inventory
	if data and parseInt(amount) > -1 then
		local amountTotal = vRP.getInventoryItemAmountSlot(user_id,tostring(newSlot))
		local amountTotalAntiga = vRP.getInventoryItemAmountSlot(user_id,tostring(oldSlot))

		if data[tostring(newSlot)] then
			local entrada = data[tostring(newSlot)]
			if entrada.item == item then
				local fixo = vRP.getInventoryItemAmountSlot(user_id,tostring(newSlot))
				if parseInt(amount) <= parseInt(amountTotalAntiga) then
					data[tostring(oldSlot)].amount = parseInt(amountTotalAntiga) - parseInt(amount)
					data[tostring(newSlot)].amount = parseInt(amount) + parseInt(fixo)
				end
				if parseInt(data[tostring(oldSlot)].amount) <= 0 then
					data[tostring(oldSlot)] = nil
				end
			end
		else
			if parseInt(amountTotalAntiga) == parseInt(amount) then
				local temp = data[tostring(oldSlot)]
				data[tostring(oldSlot)] = data[tostring(newSlot)]
				data[tostring(newSlot)] = temp
			elseif parseInt(amountTotalAntiga) ~= parseInt(amount) then
				if parseInt(amount) <= parseInt(amountTotalAntiga) then
					data[tostring(oldSlot)].amount = parseInt(amountTotalAntiga) - parseInt(amount)
					data[tostring(newSlot)] = { item = item, amount = parseInt(amount) }
				end
			end
		end

	end
end

function vRP.getInventoryItemAmountSlot(user_id,slot)
	local data = vRP.getUserDataTable(user_id)
	if data and data.inventory then
		local item = data.inventory[slot]
		if item then
			return item.amount
		end
	end
	return 0
end

-- Vamos fazer os chests funcionarem agora
-- Vá no seu script de casa e vá no cliente e cole o seguinte código nas ultimas linhas

RegisterNetEvent("dPN:inventario:vault")
AddEventHandler("dPN:inventario:vault",function()
	if houseOpen ~= "" and houseOpen ~= nil then
		local vault = homes[houseOpen].vault
		if vault then
			TriggerEvent('dPN:inventario:Returnvault',vault,houseOpen)
		end
	end
end)

-- Agora procure por 

RegisterCommand("vault",function(source,args)

-- Você deve encontarar algo assim: 

RegisterCommand("vault",function(source,args)
	local ped = PlayerPedId()
	local x,y,z = table.unpack(GetEntityCoords(ped))
	for k,v in pairs(homes) do
		local _,i = GetGroundZFor_3dCoord(v["vault"][1],v["vault"][2],v["vault"][3])
		local distance = Vdist(x,y,z,v["vault"][1],v["vault"][2],i)
		if distance <= 2.0 and houseTimer <= 0 and vSERVER.checkIntPermissions(k) then
			houseTimer = 3
			TriggerEvent("vrp_sound:source","zipperopen",0.5)
			SetNuiFocus(true,true)
			SendNUIMessage({ action = "showMenu" })
			houseOpen = tostring(k)
		end
	end
end)

-- Apague tudo

-- Agora vá na parte do server.lua do vrp_homes e cole isso lá embaixo

RegisterNetEvent("dPN:inventario:RequestVault")
AddEventHandler("dPN:inventario:RequestVault",function(user_id,house)
	if house then
		if homes[house] then
			TriggerEvent('dPN:inventario:returAmountVault',user_id,homes[house])
		end
	end
end)


-- Troque o seu código de roubar por esse

RegisterCommand('roubar',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local nplayer = vRPclient.getNearestPlayer(source,2)
	if nplayer then
		local nuser_id = vRP.getUserId(nplayer)
		local policia = vRP.getUsersByPermission("policia.permissao")
		if not vRP.hasPermission(user_id,"garmas.permissao") then
			if vRP.request(nplayer,"Você está sendo roubado, deseja passar tudo?",30) then
				local vida = vRPclient.getHealth(nplayer)
				if vida <= 100 then
					TriggerClientEvent('cancelando',source,true)
					vRPclient._playAnim(source,false,{{"amb@medic@standing@kneel@idle_a","idle_a"}},true)
					TriggerClientEvent("progress",source,30000,"roubando")
					SetTimeout(30000,function()
						local ndata = vRP.getUserDataTable(nuser_id)
						if ndata ~= nil then
							if ndata.inventory ~= nil then
								for k,v in pairs(ndata.inventory) do
									if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(k)*v.amount <= vRP.getInventoryMaxWeight(user_id) then
										if vRP.tryGetInventoryItem(nuser_id,k,v.amount) then
											vRP.giveInventoryItem(user_id,v.item,v.amount)
										end
									else
										TriggerClientEvent("Notify",source,"negado","Mochila não suporta <b>"..vRP.format(parseInt(v.amount)).."x "..itemlist[k].nome.."</b> por causa do peso.")
									end
								end
							end
						end
						local weapons = vRPclient.replaceWeapons(nplayer,{})
						for k,v in pairs(weapons) do
							vRP.giveInventoryItem(nuser_id,"wbody|"..k,1)
							if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wbody|"..k) <= vRP.getInventoryMaxWeight(user_id) then
								if vRP.tryGetInventoryItem(nuser_id,"wbody|"..k,1) then
									vRP.giveInventoryItem(user_id,"wbody|"..k,1)
								end
							else
								TriggerClientEvent("Notify",source,"negado","Mochila não suporta <b>1x "..itemlist["wbody"..k].nome.."</b> por causa do peso.")
							end
							if v.ammo > 0 then
								vRP.giveInventoryItem(nuser_id,"wammo|"..k,v.ammo)
								if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wammo|"..k)*v.ammo <= vRP.getInventoryMaxWeight(user_id) then
									if vRP.tryGetInventoryItem(nuser_id,"wammo|"..k,v.ammo) then
										vRP.giveInventoryItem(user_id,"wammo|"..k,v.ammo)
									end
								else
									TriggerClientEvent("Notify",source,"negado","Mochila não suporta <b>"..vRP.format(parseInt(v.ammo)).."x "..itemlist["wammo|"..k].nome.."</b> por causa do peso.")
								end
							end
						end
						local nmoney = vRP.getMoney(nuser_id)
						if vRP.tryPayment(nuser_id,nmoney) then
							vRP.giveMoney(user_id,nmoney)
						end
						vRPclient.setStandBY(source,parseInt(600))
						vRPclient._stopAnim(source,false)
						TriggerClientEvent('cancelando',source,false)
						TriggerClientEvent("Notify",source,"importante","Roubo concluido com sucesso.")
						TriggerEvent('logs:ToDiscord', discord_webhook1 , "ROUBO", "```Player "..user_id.." roubou o ID: "..nuser_id.."```", "https://www.tumarcafacil.com/wp-content/uploads/2017/06/RegistroDeMarca-01-1.png", false, false)
					end)
				else
					local ndata = vRP.getUserDataTable(nuser_id)
					if ndata ~= nil then
						if ndata.inventory ~= nil then
							for k,v in pairs(ndata.inventory) do
								if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(k)*v.amount <= vRP.getInventoryMaxWeight(user_id) then
									if vRP.tryGetInventoryItem(nuser_id,k,v.amount) then
										vRP.giveInventoryItem(user_id,v.item,v.amount)
									end
								else
									TriggerClientEvent("Notify",source,"negado","Mochila não suporta <b>"..vRP.format(parseInt(v.amount)).."x "..itemlist[k].nome.."</b> por causa do peso.")
								end
							end
						end
					end
					local weapons = vRPclient.replaceWeapons(nplayer,{})
					for k,v in pairs(weapons) do
						vRP.giveInventoryItem(nuser_id,"wbody|"..k,1)
						if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wbody|"..k) <= vRP.getInventoryMaxWeight(user_id) then
							if vRP.tryGetInventoryItem(nuser_id,"wbody|"..k,1) then
								vRP.giveInventoryItem(user_id,"wbody|"..k,1)
							end
						else
							TriggerClientEvent("Notify",source,"negado","Mochila não suporta <b>1x "..itemlist["wbody|"..k].nome.."</b> por causa do peso.")
						end
						if v.ammo > 0 then
							vRP.giveInventoryItem(nuser_id,"wammo|"..k,v.ammo)
							if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wammo|"..k)*v.ammo <= vRP.getInventoryMaxWeight(user_id) then
								if vRP.tryGetInventoryItem(nuser_id,"wammo|"..k,v.ammo) then
									vRP.giveInventoryItem(user_id,"wammo|"..k,v.ammo)
								end
							else
								TriggerClientEvent("Notify",source,"negado","Mochila não suporta <b>"..vRP.format(parseInt(v.ammo)).."x "..itemlist["wammo|"..k].nome.."</b> por causa do peso.")
							end
						end
					end
					local nmoney = vRP.getMoney(nuser_id)
					if vRP.tryPayment(nuser_id,nmoney) then
						vRP.giveMoney(user_id,nmoney)
					end
					vRPclient.setStandBY(source,parseInt(600))
					TriggerClientEvent("Notify",source,"importante","Roubo concluido com sucesso.")
					TriggerEvent('logs:ToDiscord', discord_webhook1 , "ROUBO", "```Player "..user_id.." roubou o ID: "..nuser_id.."```", "https://www.tumarcafacil.com/wp-content/uploads/2017/06/RegistroDeMarca-01-1.png", false, false)
				end
			else
				TriggerClientEvent("Notify",source,"aviso","A pessoa está resistindo ao roubo.")
			end
		else
			TriggerClientEvent("Notify",source,"negado","Policiais não podem ser roubados.")
		end
	end
end)


-- troque seu código de revistar para esse

RegisterCommand('revistar',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local nplayer = vRPclient.getNearestPlayer(source,2)
	local nuser_id = vRP.getUserId(nplayer)
	if nuser_id then
		local identity = vRP.getUserIdentity(user_id)
		local weapons = vRPclient.getWeapons(nplayer)
		local money = vRP.getMoney(nuser_id)
		local data = vRP.getUserDataTable(nuser_id)

		TriggerClientEvent('cancelando',source,true)
		TriggerClientEvent('cancelando',nplayer,true)
		TriggerClientEvent('carregar',nplayer,source)
		vRPclient._playAnim(source,false,{{"misscarsteal4@director_grip","end_loop_grip"}},true)
		vRPclient._playAnim(nplayer,false,{{"random@mugging3","handsup_standing_base"}},true)
		TriggerClientEvent("progress",source,5000,"revistando")
		SetTimeout(5000,function()

			TriggerClientEvent('chatMessage',source,"",{},"^4- -  ^5M O C H I L A^4  - - - - - - - - - - - - - - - - - - - - - - - - - - -  [  ^3"..string.format("%.2f",vRP.getInventoryWeight(nuser_id)).."kg^4  /  ^3"..string.format("%.2f",vRP.getInventoryMaxWeight(nuser_id)).."kg^4  ]  - -")
			if data and data.inventory then
				for k,v in pairs(data.inventory) do
					TriggerClientEvent('chatMessage',source,"",{},"     "..vRP.format(parseInt(v.amount)).."x "..vRP.itemNameList(v.item))
				end
			end
			TriggerClientEvent('chatMessage',source,"",{},"^4- -  ^5E Q U I P A D O^4  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -")
			for k,v in pairs(weapons) do
				if v.ammo < 1 then
					TriggerClientEvent('chatMessage',source,"",{},"     1x "..vRP.itemNameList("wbody|"..k))
				else
					TriggerClientEvent('chatMessage',source,"",{},"     1x "..vRP.itemNameList("wbody|"..k).." | "..vRP.format(parseInt(v.ammo)).."x Munições")
				end
			end

			vRPclient._stopAnim(source,false)
			vRPclient._stopAnim(nplayer,false)
			TriggerClientEvent('cancelando',source,false)
			TriggerClientEvent('cancelando',nplayer,false)
			TriggerClientEvent('carregar',nplayer,source)
			TriggerClientEvent('chatMessage',source,"",{},"     $"..vRP.format(parseInt(money)).." Dólares")
		end)
		TriggerClientEvent("Notify",nplayer,"aviso","Você está sendo <b>Revistado</b>.")
	end
end)

-- troque seu código de saquear apra esse

RegisterCommand('saquear',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local nplayer = vRPclient.getNearestPlayer(source,2)
	if nplayer then
		if vRPclient.isInComa(nplayer) then
			local identity_user = vRP.getUserIdentity(user_id)
			local nuser_id = vRP.getUserId(nplayer)
			local nidentity = vRP.getUserIdentity(nuser_id)
			local policia = vRP.getUsersByPermission("policia.permissao")
			local itens_saque = {}
			if #policia >= 0 then
				local vida = vRPclient.getHealth(nplayer)
				TriggerClientEvent('cancelando',source,true)
				vRPclient._playAnim(source,false,{{"amb@medic@standing@tendtodead@idle_a","idle_a"}},true)
				TriggerClientEvent("progress",source,8000,"saqueando")
				SetTimeout(8000,function()
					if not vRP.hasPermission(nuser_id, "policia.permissao") then
						local ndata = vRP.getUserDataTable(nuser_id)
						if ndata ~= nil then
							if ndata.inventory ~= nil then
								for k,v in pairs(ndata.inventory) do
									if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(v.item)*v.amount <= vRP.getInventoryMaxWeight(user_id) then
										if vRP.tryGetInventoryItem(nuser_id,v.item,v.amount) then
											vRP.giveInventoryItem(user_id,v.item,v.amount)
											table.insert(itens_saque, "[ITEM]: "..vRP.itemNameList(v.item).." [QUANTIDADE]: "..v.amount)
										end
									else
										TriggerClientEvent("Notify",source,"negado","Mochila não suporta <b>"..vRP.format(parseInt(v.amount)).."x "..vRP.itemNameList(v.item).."</b> por causa do peso.")
									end
								end
							end
						end
						local weapons = vRPclient.replaceWeapons(nplayer,{})
						for k,v in pairs(weapons) do
							vRP.giveInventoryItem(nuser_id,"wbody|"..k,1)
							if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wbody|"..k) <= vRP.getInventoryMaxWeight(user_id) then
								if vRP.tryGetInventoryItem(nuser_id,"wbody|"..k,1) then
									vRP.giveInventoryItem(user_id,"wbody|"..k,1)
									table.insert(itens_saque, "[ITEM]: "..vRP.itemNameList("wbody|"..k).." [QUANTIDADE]: "..1)
								end
							else
								TriggerClientEvent("Notify",source,"negado","Mochila não suporta <b>1x "..vRP.itemNameList("wbody|"..k).."</b> por causa do peso.")
							end
							if v.ammo > 0 then
								vRP.giveInventoryItem(nuser_id,"wammo|"..k,v.ammo)
								if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wammo|"..k)*v.ammo <= vRP.getInventoryMaxWeight(user_id) then
									if vRP.tryGetInventoryItem(nuser_id,"wammo|"..k,v.ammo) then
										vRP.giveInventoryItem(user_id,"wammo|"..k,v.ammo)
										table.insert(itens_saque, "[ITEM]: "..vRP.itemNameList("wammo|"..k).." [QTD]: "..v.ammo)
									end
								else
									TriggerClientEvent("Notify",source,"negado","Mochila não suporta <b>"..vRP.format(parseInt(v.ammo)).."x "..vRP.itemNameList("wammo|"..k).."</b> por causa do peso.")
								end
							end
						end
						local nmoney = vRP.getMoney(nuser_id)
						if vRP.tryPayment(nuser_id,nmoney) then
							vRP.giveMoney(user_id,nmoney)
						end
					elseif vRP.tryGetInventoryItem(nuser_id,"distintivopolicial",1) then
						vRP.giveInventoryItem(user_id,"distintivopolicial",1)
					end
					vRPclient.setStandBY(source,parseInt(8000))
					vRPclient._stopAnim(source,false)
					TriggerClientEvent('cancelando',source,false)
					local apreendidos = table.concat(itens_saque, "\n")
					TriggerClientEvent("Notify",source,"importante","Saque concluido com sucesso.")
					SendWebhookMessage(webhooksaquear,"```prolog\n[ID]: "..user_id.." "..identity_user.name.." "..identity_user.firstname.."\n[SAQUEOU]: "..nuser_id.." "..nidentity.name.." " ..nidentity.firstname .. "\n" .. apreendidos ..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
					Citizen.Wait(8000)
				end)
			else
				TriggerClientEvent("Notify",source,"aviso","Número insuficiente de policiais no momento.")
			end
		else
			TriggerClientEvent("Notify",source,"negado","Você só pode saquear quem está em coma.")
		end
	end
end)