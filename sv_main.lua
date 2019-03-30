---------------------------

-- made by parow with <3 --

---------------------------

function GetBlipData()
	local a = LoadResourceFile("blipCreator", "data/blipData.json")
	return a and json.decode(a) or {}
end






RegisterServerEvent('bc:addBlip')
AddEventHandler('bc:addBlip', function (data)
    BlipData = GetBlipData()
    print(dump(data))
    table.insert(BlipData,data)
    SaveResourceFile("blipCreator", "data/blipData.json", json.encode(BlipData))

    TriggerClientEvent("bc:SyncBlips",-1, GetBlipData())
end)
RegisterServerEvent('bc:editBlip')
AddEventHandler('bc:editBlip', function (i,data)
    print(i)
    print(dump(data))
    BlipData = GetBlipData()
   BlipData[i] = data
    SaveResourceFile("blipCreator", "data/blipData.json", json.encode(BlipData))

    TriggerClientEvent("bc:SyncBlips",-1, GetBlipData())
end)
RegisterServerEvent('bc:deleteBlip')
AddEventHandler('bc:deleteBlip', function (i)
    BlipData = GetBlipData()
    table.remove(BlipData,i)
    SaveResourceFile("blipCreator", "data/blipData.json", json.encode(BlipData))
    TriggerClientEvent("bc:SyncBlips",-1, GetBlipData())
end)
RegisterServerEvent('bc:requestSync')
AddEventHandler('bc:requestSync', function ()
    BlipData = GetBlipData()
    TriggerClientEvent("bc:SyncBlips",source,BlipData)
end)
function dump(o)
    if type(o) == 'table' then
       local s = '{ '
       for k,v in pairs(o) do
          if type(k) ~= 'number' then k = '"'..k..'"' end
          s = s .. '['..k..'] = ' .. dump(v) .. ','
       end
       return s .. '} '
    else
       return tostring(o)
    end
 end





local count = 0
for _,v in pairs(GetBlipData()) do count = count + 1 end

print("[blipCreator] Successfully loaded: " .. count .. " blip(s).")
