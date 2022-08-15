local maps = {}
local gametypes = {}

AddEventHandler('onClientResourceStart', function(res)
    -- parse metadata for this resource

    -- map files
    local num = GetNumResourceMetadata(res, 'map')

    if num > 0 then
        for i = 0, num-1 do
            local file = GetResourceMetadata(res, 'map', i)

            if file then
                addMap(file, res)
            end
        end
    end

    -- resource type data
    local type = GetResourceMetadata(res, 'resource_type', 0)

    if type then
        local extraData = GetResourceMetadata(res, 'resource_type_extra', 0)

        if extraData then
            extraData = json.decode(extraData)
        else
            extraData = {}
        end

        if type == 'map' then
            maps[res] = extraData
        elseif type == 'gametype' then
            gametypes[res] = extraData
        end
    end

    -- handle starting
    loadMap(res)

    -- defer this to the next game tick to work around a lack of dependencies
    Citizen.CreateThread(function()
        Citizen.Wait(15)

        if maps[res] then
            TriggerEvent('onClientMapStart', res)
        elseif gametypes[res] then
            TriggerEvent('onClientGameTypeStart', res)
        end
    end)
end)

AddEventHandler('onResourceStop', function(res)
    if maps[res] then
        TriggerEvent('onClientMapStop', res)
    elseif gametypes[res] then
        TriggerEvent('onClientGameTypeStop', res)
    end

    unloadMap(res)
end)