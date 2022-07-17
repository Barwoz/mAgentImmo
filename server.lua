-- MAIN:GetFramework

ESX = nil

TriggerEvent(_Config.getInitFramework, function(obj) ESX = obj end)

-- MAIN:FUNCTION

_sM = {
    Players = {}
}

function _sM.CheckPlayers(playerSource, playerGrade)
    local data = _sM.Players[playerSource]
    TriggerClientEvent("magent:client:abilities", playerSource, data, playerGrade)
end

-- MAIN:EVENT

RegisterNetEvent("m:server:playerLoaded")
AddEventHandler("m:server:playerLoaded", function()
    local xPlayer = ESX.GetPlayerFromId(source)
	while not xPlayer do 
		Wait(1)
		print("pas de xPlayer")
	end
    if xPlayer ~= nil then
        local job = xPlayer.getJob()
        local name = job.name
        if name == 'realestateagent' then
            local grade = job.grade_name
            _sM.Players[source] = true
            _sM.CheckPlayers(source, grade)
        end
    end
end)


ESX.RegisterServerCallback("m:server:GetPlayerIdentifier", function(source, cb, PlayerId)
    local identifier = GetPlayerIdentifier(PlayerId)
    cb(identifier)
end)

RegisterNetEvent("m:server:saveProperty")
AddEventHandler("m:server:saveProperty", function(data)
    local _src = source
    MySQL.Async.fetchAll("SELECT name FROM properties WHERE name = @name", {
        ['@name'] = data.name,
    }, function(result)
        if result[1] ~= nil then 
       	    TriggerClientEvent('m:showNotification', _src, 'Ce nom éxiste déja !')
       	else 
       	    Insert(_src, data)   
        end 
    end)
end)

function Insert(source, data)
    MySQL.Async.execute('INSERT INTO properties (name, label, entering, `exit`, inside, outside, ipls, is_single, is_room, is_gateway, room_menu, price) VALUES (@name, @label, @entering, @exit, @inside, @outside, @ipls, @isSingle, @isRoom, @isGateway, @roommenu, @price)',
		{
			['@name'] = data.name,
			['@label'] = data.label,
			['@entering'] = data.entering,
			['@exit'] = data.exit,
			['@inside'] = data.inside,
			['@outside'] = data.outside,
			['@ipls'] = data.ipl,
			['@isSingle'] = data.isSingle,
			['@isRoom'] = data.isRoom,
			['@isGateway'] = data.isGateway,
			['@roommenu'] = data.roommenu,
			['@price'] = data.price,

		}, 
		function (rowsChanged)
			TriggerClientEvent('m:showNotification', source, 'Propriété bien enregistré')
            GetPropertiesList()
		end
	)
end

function RemoveProperty(id, deleter)
	MySQL.Async.execute('DELETE FROM properties WHERE id = @id', {
		['@id']  = id
	}, function(rowsChanged)
		local xPlayer = ESX.GetPlayerFromId(deleter)
		while not xPlayer do
			Wait(1)
		end
		if xPlayer then
			TriggerClientEvent('esx:showNotification', deleter, _Text.delete_property)
			GetPropertiesList()
		end
	end)
end

function GetProperty(name)
	for i=1, #Config.Properties, 1 do
		if Config.Properties[i].name == name then
			return Config.Properties[i]
		end
	end
end

function GetPropertiesList()
    Config.Properties = {}
	MySQL.Async.fetchAll('SELECT * FROM properties', {}, function(properties)
		for i=1, #properties, 1 do
			local entering  = nil
			local exit      = nil
			local inside    = nil
			local outside   = nil
			local isSingle  = nil
			local isRoom    = nil
			local isGateway = nil
			local roomMenu  = nil
	
			if properties[i].entering ~= nil then
				entering = json.decode(properties[i].entering)
			end
	
			if properties[i].exit ~= nil then
				exit = json.decode(properties[i].exit)
			end
	
			if properties[i].inside ~= nil then
				inside = json.decode(properties[i].inside)
			end
	
			if properties[i].outside ~= nil then
				outside = json.decode(properties[i].outside)
			end
	
			if properties[i].is_single == 0 then
				isSingle = false
			else
				isSingle = true
			end
	
			if properties[i].is_room == 0 then
				isRoom = false
			else
				isRoom = true
			end
	
			if properties[i].is_gateway == 0 then
				isGateway = false
			else
				isGateway = true
			end
	
			if properties[i].room_menu ~= nil then
				roomMenu = json.decode(properties[i].room_menu)
			end
	
			table.insert(Config.Properties, {
				id        = properties[i].id,
				name      = properties[i].name,
				label     = properties[i].label,
				entering  = entering,
				exit      = exit,
				inside    = inside,
				outside   = outside,
				ipls      = json.decode(properties[i].ipls),
				gateway   = properties[i].gateway,
				isSingle  = isSingle,
				isRoom    = isRoom,
				isGateway = isGateway,
				roomMenu  = roomMenu,
				price     = properties[i].price
			})
		end
		TriggerClientEvent('esx_property:sendProperties', -1, Config.Properties)
	end)
end

function GetOwnersProperties()
	MySQL.Async.fetchAll('SELECT * FROM owned_properties', {}, function(owned_properties)
		for i=1, #owned_properties, 1 do
			table.insert(Config.OwnedProperties, {
				id      = owned_properties[i].id,
				name    = owned_properties[i].name,
				price   = owned_properties[i].price,
				rented = owned_properties[i].rented,
				owner   = owned_properties[i].owner
			})
		end
		TriggerClientEvent("esx_property:sendOwnerProperties", -1, Config.OwnedProperties)
	end)
end

function SetPropertyOwned(name, price, rented, owner)
	MySQL.Async.execute('INSERT INTO owned_properties (name, price, rented, owner) VALUES (@name, @price, @rented, @owner)', {
		['@name']   = name,
		['@price']  = price,
		['@rented'] = (rented and 1 or 0),
		['@owner']  = owner
	}, function(rowsChanged)
		local xPlayer = ESX.GetPlayerFromIdentifier(owner)

		if xPlayer then
			TriggerClientEvent('esx_property:setPropertyOwned', xPlayer.source, name, true)

			if rented then
				TriggerClientEvent('esx:showNotification', xPlayer.source, (_Text.rented_for):format(ESX.Math.GroupDigits(price)))
			else
				TriggerClientEvent('esx:showNotification', xPlayer.source, (_Text.purchased_for):format(price))
			end
			GetOwnersProperties()
		end
	end)
end

function RemoveOwnedProperty(name, owner)
	MySQL.Async.execute('DELETE FROM owned_properties WHERE name = @name AND owner = @owner', {
		['@name']  = name,
		['@owner'] = owner
	}, function(rowsChanged)
		local xPlayer = ESX.GetPlayerFromIdentifier(owner)

		if xPlayer then
			TriggerClientEvent('esx_property:setPropertyOwned', xPlayer.source, name, false)
			TriggerClientEvent('esx:showNotification', xPlayer.source, _Text.made_property)
			GetOwnersProperties()
		end
	end)
end

MySQL.ready(function()
	GetPropertiesList()
	GetOwnersProperties()
end)

ESX.RegisterServerCallback('esx_property:getProperties', function(source, cb)
	cb(Config.Properties)
end)

ESX.RegisterServerCallback('esx_property:getOwnerProperties', function(source, cb)
	cb(Config.OwnedProperties)
end)

RegisterServerEvent("esx_property:RemoveProperty")
AddEventHandler("esx_property:RemoveProperty", function(propertyid)
	RemoveProperty(propertyid, source)
end)

AddEventHandler('esx_ownedproperty:getOwnedProperties', function(cb)
	MySQL.Async.fetchAll('SELECT * FROM owned_properties', {}, function(result)
		local properties = {}

		for i=1, #result, 1 do
			table.insert(properties, {
				id     = result[i].id,
				name   = result[i].name,
				label  = GetProperty(result[i].name).label,
				price  = result[i].price,
				rented = (result[i].rented == 1 and true or false),
				owner  = result[i].owner
			})
		end

		cb(properties)
	end)
end)

RegisterNetEvent("m:server:setPropertyOwned")
AddEventHandler('m:server:setPropertyOwned', function(name, price, rented, owner)
	SetPropertyOwned(name, price, rented, owner)
end)

AddEventHandler('esx_property:removeOwnedProperty', function(name, owner)
	RemoveOwnedProperty(name, owner)
end)

RegisterServerEvent('esx_property:rentProperty')
AddEventHandler('esx_property:rentProperty', function(propertyName)
	local xPlayer  = ESX.GetPlayerFromId(source)
	local property = GetProperty(propertyName)
	local rent     = ESX.Math.Round(property.price / 200)

	SetPropertyOwned(propertyName, rent, true, xPlayer.identifier)
end)

RegisterServerEvent('esx_property:buyProperty')
AddEventHandler('esx_property:buyProperty', function(propertyName)
	local xPlayer  = ESX.GetPlayerFromId(source)
	local property = GetProperty(propertyName)

	if property.price <= xPlayer.getMoney() then
		xPlayer.removeMoney(property.price)
		SetPropertyOwned(propertyName, property.price, false, xPlayer.identifier)
	else
		TriggerClientEvent('esx:showNotification', source, _Text.not_enough)
	end
end)

RegisterServerEvent('esx_property:removeOwnedProperty')
AddEventHandler('esx_property:removeOwnedProperty', function(propertyName)
	local xPlayer = ESX.GetPlayerFromId(source)
	RemoveOwnedProperty(propertyName, xPlayer.identifier)
end)

AddEventHandler('esx_property:removeOwnedPropertyIdentifier', function(propertyName, identifier)
	RemoveOwnedProperty(propertyName, identifier)
end)

RegisterServerEvent('esx_property:saveLastProperty')
AddEventHandler('esx_property:saveLastProperty', function(property)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.execute('UPDATE users SET last_property = @last_property WHERE identifier = @identifier', {
		['@last_property'] = property,
		['@identifier']    = xPlayer.identifier
	})
end)

RegisterServerEvent('esx_property:deleteLastProperty')
AddEventHandler('esx_property:deleteLastProperty', function()
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.execute('UPDATE users SET last_property = NULL WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	})
end)

RegisterServerEvent('esx_property:getItem')
AddEventHandler('esx_property:getItem', function(owner, type, item, count)
	local _source      = source
	local xPlayer      = ESX.GetPlayerFromId(_source)
	local xPlayerOwner = ESX.GetPlayerFromIdentifier(owner)

	if type == 'item_standard' then

		local sourceItem = xPlayer.getInventoryItem(item)

		TriggerEvent('esx_addoninventory:getInventory', 'property', xPlayerOwner.identifier, function(inventory)
			local inventoryItem = inventory.getItem(item)

			-- is there enough in the property?
			if count > 0 and inventoryItem.count >= count then
			
				-- can the player carry the said amount of x item?
				if sourceItem.limit ~= -1 and (sourceItem.count + count) > sourceItem.limit then
					TriggerClientEvent('esx:showNotification', _source, _Text.player_cannot_hold)
				else
					inventory.removeItem(item, count)
					xPlayer.addInventoryItem(item, count)
					TriggerClientEvent('esx:showNotification', _source, (_Text.have_withdrawn):format(count, inventoryItem.label))
				end
			else
				TriggerClientEvent('esx:showNotification', _source, _Text.not_enough_in_property)
			end
		end)

	elseif type == 'item_account' then

		TriggerEvent('esx_addonaccount:getAccount', 'property_' .. item, xPlayerOwner.identifier, function(account)
			local roomAccountMoney = account.money

			if roomAccountMoney >= count then
				account.removeMoney(count)
				xPlayer.addAccountMoney(item, count)
			else
				TriggerClientEvent('esx:showNotification', _source, _Text.amount_invalid)
			end
		end)

	elseif type == 'item_weapon' then

		TriggerEvent('esx_datastore:getDataStore', 'property', xPlayerOwner.identifier, function(store)
			local storeWeapons = store.get('weapons') or {}
			local weaponName   = nil
			local ammo         = nil

			for i=1, #storeWeapons, 1 do
				if storeWeapons[i].name == item then
					weaponName = storeWeapons[i].name
					ammo       = storeWeapons[i].ammo

					table.remove(storeWeapons, i)
					break
				end
			end

			store.set('weapons', storeWeapons)
			xPlayer.addWeapon(weaponName, ammo)
		end)

	end
end)

RegisterServerEvent('esx_property:putItem')
AddEventHandler('esx_property:putItem', function(owner, type, item, count)
	local _source      = source
	local xPlayer      = ESX.GetPlayerFromId(_source)
	local xPlayerOwner = ESX.GetPlayerFromIdentifier(owner)

	if type == 'item_standard' then

		local playerItemCount = xPlayer.getInventoryItem(item).count

		if playerItemCount >= count and count > 0 then
			TriggerEvent('esx_addoninventory:getInventory', 'property', xPlayerOwner.identifier, function(inventory)
				xPlayer.removeInventoryItem(item, count)
				inventory.addItem(item, count)
				TriggerClientEvent('esx:showNotification', _source, (_Text.have_deposited):format(count, inventory.getItem(item).label))
			end)
		else
			TriggerClientEvent('esx:showNotification', _source, _Text.invalid_quantity)
		end

	elseif type == 'item_account' then

		local playerAccountMoney = xPlayer.getAccount(item).money

		if playerAccountMoney >= count and count > 0 then
			xPlayer.removeAccountMoney(item, count)

			TriggerEvent('esx_addonaccount:getAccount', 'property_' .. item, xPlayerOwner.identifier, function(account)
				account.addMoney(count)
			end)
		else
			TriggerClientEvent('esx:showNotification', _source, _Text.amount_invalid)
		end

	elseif type == 'item_weapon' then

		TriggerEvent('esx_datastore:getDataStore', 'property', xPlayerOwner.identifier, function(store)
			local storeWeapons = store.get('weapons') or {}

			table.insert(storeWeapons, {
				name = item,
				ammo = count
			})

			store.set('weapons', storeWeapons)
			xPlayer.removeWeapon(item)
		end)

	end
end)

ESX.RegisterServerCallback('esx_property:getOwnedProperties', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	while not xPlayer do
		Wait(1)
	end
	MySQL.Async.fetchAll('SELECT * FROM owned_properties WHERE owner = @owner', {
		['@owner'] = xPlayer.identifier
	}, function(ownedProperties)
		local properties = {}

		for i=1, #ownedProperties, 1 do
			table.insert(properties, ownedProperties[i].name)
		end

		cb(properties)
	end)
end)

ESX.RegisterServerCallback('esx_property:getLastProperty', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT last_property FROM users WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	}, function(users)
		cb(users[1].last_property)
	end)
end)

ESX.RegisterServerCallback("m:server:GetPlayerInArea", function(source, cb, coords, radius)
	local xPlayers = ESX.GetPlayers()
	local tempsTable = {}
	local thisCoords = coords
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		local xPlayerCoords = xPlayer.getCoords()
		if (xPlayerCoords.x - thisCoords.x ) <= radius and (xPlayerCoords.y - thisCoords.y ) <= radius and (xPlayerCoords.z - thisCoords.z ) <= radius then
			table.insert(tempsTable, {
				id = xPlayers[i],
				name = xPlayer.getName(),
			})
		end
	end
	print(ESX.DumpTable(tempsTable))
	cb(tempsTable)
end)

ESX.RegisterServerCallback('m:getPropertyItems', function(source, cb, owner)
	local xPlayer = owner
	local Items  = {}

	TriggerEvent('esx_addoninventory:getInventory', 'property', xPlayer, function(inventory)
		Items = inventory.items
	end)

	cb(Items)
end)

ESX.RegisterServerCallback('esx_property:getPropertyInventory', function(source, cb, owner)
	local xPlayer    = ESX.GetPlayerFromIdentifier(owner)
	local blackMoney = 0
	local items      = {}
	local weapons    = {}

	TriggerEvent('esx_addonaccount:getAccount', 'property_black_money', xPlayer.identifier, function(account)
		blackMoney = account.money
	end)

	TriggerEvent('esx_addoninventory:getInventory', 'property', xPlayer.identifier, function(inventory)
		items = inventory.items
	end)

	TriggerEvent('esx_datastore:getDataStore', 'property', xPlayer.identifier, function(store)
		weapons = store.get('weapons') or {}
	end)

	cb({
		blackMoney = blackMoney,
		items      = items,
		weapons    = weapons
	})
end)

ESX.RegisterServerCallback('esx_property:getPlayerInventory', function(source, cb)
	local xPlayer    = ESX.GetPlayerFromId(source)
	local blackMoney = xPlayer.getAccount('black_money').money
	local items      = xPlayer.inventory

	cb({
		blackMoney = blackMoney,
		items      = items,
		weapons    = xPlayer.getLoadout()
	})
end)

ESX.RegisterServerCallback('esx_property:getPlayerDressing', function(source, cb)
	local xPlayer  = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_datastore:getDataStore', 'property', xPlayer.identifier, function(store)
		local count  = store.count('dressing')
		local labels = {}

		for i=1, count, 1 do
			local entry = store.get('dressing', i)
			table.insert(labels, entry.label)
		end

		cb(labels)
	end)
end)

ESX.RegisterServerCallback('esx_property:getPlayerOutfit', function(source, cb, num)
	local xPlayer  = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_datastore:getDataStore', 'property', xPlayer.identifier, function(store)
		local outfit = store.get('dressing', num)
		cb(outfit.skin)
	end)
end)

RegisterServerEvent('esx_property:removeOutfit')
AddEventHandler('esx_property:removeOutfit', function(label)
	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_datastore:getDataStore', 'property', xPlayer.identifier, function(store)
		local dressing = store.get('dressing') or {}

		table.remove(dressing, label)
		store.set('dressing', dressing)
	end)
end)

function PayRent(d, h, m)
	MySQL.Async.fetchAll('SELECT * FROM owned_properties WHERE rented = 1', {}, function (result)
		for i=1, #result, 1 do
			local xPlayer = ESX.GetPlayerFromIdentifier(result[i].owner)

			-- message player if connected
			if xPlayer then
				xPlayer.removeAccountMoney('bank', result[i].price)
				TriggerClientEvent('esx:showNotification', xPlayer.source, (_Text.paid_rent):fomrat(ESX.Math.GroupDigits(result[i].price)))
			else -- pay rent either way
				MySQL.Sync.execute('UPDATE users SET bank = bank - @bank WHERE identifier = @identifier', {
					['@bank']       = result[i].price,
					['@identifier'] = result[i].owner
				})
			end

			TriggerEvent('esx_addonaccount:getSharedAccount', 'society_realestateagent', function(account)
				account.addMoney(result[i].price)
			end)
		end
	end)
end

TriggerEvent('cron:runAt', 22, 0, PayRent)

local instances = {}

function GetInstancedPlayers()
	local players = {}

	for k,v in pairs(instances) do
		for k2,v2 in ipairs(v.players) do
			players[v2] = true
		end
	end

	return players
end

AddEventHandler('playerDropped', function(reason)
	if instances[source] then
		CloseInstance(source)
	end
end)

function CreateInstance(type, player, data)
	instances[player] = {
		type    = type,
		host    = player,
		players = {},
		data    = data
	}

	TriggerEvent('instance:onCreate', instances[player])
	TriggerClientEvent('instance:onCreate', player, instances[player])
	TriggerClientEvent('instance:onInstancedPlayersData', -1, GetInstancedPlayers())
end

function CloseInstance(instance)
	if instances[instance] then

		for i=1, #instances[instance].players do
			TriggerClientEvent('instance:onClose', instances[instance].players[i])
		end

		instances[instance] = nil

		TriggerClientEvent('instance:onInstancedPlayersData', -1, GetInstancedPlayers())
		TriggerEvent('instance:onClose', instance)
	end
end

function AddPlayerToInstance(instance, player)
	local found = false

	for i=1, #instances[instance].players do
		if instances[instance].players[i] == player then
			found = true
			break
		end
	end

	if not found then
		table.insert(instances[instance].players, player)
	end

	TriggerClientEvent('instance:onEnter', player, instances[instance])

	for i=1, #instances[instance].players do
		if instances[instance].players[i] ~= player then
			TriggerClientEvent('instance:onPlayerEntered', instances[instance].players[i], instances[instance], player)
		end
	end

	TriggerClientEvent('instance:onInstancedPlayersData', -1, GetInstancedPlayers())
end

function RemovePlayerFromInstance(instance, player)
	if instances[instance] then
		TriggerClientEvent('instance:onLeave', player, instances[instance])

		if instances[instance].host == player then
			for i=1, #instances[instance].players do
				if instances[instance].players[i] ~= player then
					TriggerClientEvent('instance:onPlayerLeft', instances[instance].players[i], instances[instance], player)
				end
			end

			CloseInstance(instance)
		else
			for i=1, #instances[instance].players do
				if instances[instance].players[i] == player then
					instances[instance].players[i] = nil
				end
			end

			for i=1, #instances[instance].players do
				if instances[instance].players[i] ~= player then
					TriggerClientEvent('instance:onPlayerLeft', instances[instance].players[i], instances[instance], player)
				end

			end

			TriggerClientEvent('instance:onInstancedPlayersData', -1, GetInstancedPlayers())
		end
	end
end

function InvitePlayerToInstance(instance, type, player, data)
	TriggerClientEvent('instance:onInvite', player, instance, type, data)
end

RegisterServerEvent('instance:create')
AddEventHandler('instance:create', function(type, data)
	CreateInstance(type, source, data)
end)

RegisterServerEvent('instance:close')
AddEventHandler('instance:close', function()
	CloseInstance(source)
end)

RegisterServerEvent('instance:enter')
AddEventHandler('instance:enter', function(instance)
	AddPlayerToInstance(instance, source)
end)

RegisterServerEvent('instance:leave')
AddEventHandler('instance:leave', function(instance)
	RemovePlayerFromInstance(instance, source)
end)

RegisterServerEvent('instance:invite')
AddEventHandler('instance:invite', function(instance, type, player, data)
	InvitePlayerToInstance(instance, type, player, data)
end)
