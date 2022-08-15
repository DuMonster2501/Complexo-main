-----------------------------------------------------------------------------------------------------------------------------------------
-- COORDS
-----------------------------------------------------------------------------------------------------------------------------------------
local localidades = {
    [1] = { -- Lixeiro
	    name = "Lixeiro",
        notifycoord = {81.82,-1554.86,29.6},
        header = function()
            if IsControlJustPressed(1,38) then 
                TriggerEvent("Notify","amarelo","Dê <b>/lixeiro</b> para iniciar ou finalizar o serviço.",5000)
            end
        end
    },
	[2] = { -- Transportador
		name = "Transportador",
        notifycoord = {354.14,270.56,103.02},
        header = function()
            if IsControlJustPressed(1,38) then 
                TriggerEvent("Notify","amarelo","Dê <b>/transportador</b> para iniciar ou finalizar o serviço.",5000)
            end
        end
    },
	[3] = { -- Motorista
		name = "Motorista",
        notifycoord = {452.97,-607.75,28.59},
        header = function()
            if IsControlJustPressed(1,38) then 
                TriggerEvent("Notify","amarelo","Dê <b>/motorista</b> para iniciar ou finalizar o serviço.",5000)
            end
        end
    },
	[4] = { -- Lenhador
		name = "Lenhador",
        notifycoord = {-555.2,5364.38,70.43},
        header = function()
            if IsControlJustPressed(1,38) then 
                TriggerEvent("Notify","amarelo","Dê <b>/lenhador</b> para iniciar ou finalizar o serviço.",5000)
            end
        end
    },
	[5] = { -- Colheita
		name = "Colheita",
        notifycoord = {406.04,6526.17,27.75},
        header = function()
            if IsControlJustPressed(1,38) then 
                TriggerEvent("Notify","amarelo","Dê <b>/colheita</b> para iniciar ou finalizar o serviço.",5000)
            end
        end
    },
	[5] = { -- Minerador
		name = "Minerador",
        notifycoord = {-594.72,2090.05,131.65},
        header = function()
            if IsControlJustPressed(1,38) then 
                TriggerEvent("Notify","amarelo","Dê <b>/minerador</b> para iniciar ou finalizar o serviço.",5000)
            end
        end
    },
    [6] = { -- Transporte de Presidiario
		name = "Transporte de Presidiario",
        notifycoord = {1850.41,2588.12,45.71},
        header = function()
            if IsControlJustPressed(1,38) then 
            end
        end
    },
    [7] = { -- Taxi Aéreo
		name = "Taxi Aéreo",
        notifycoord = {-940.79,-2960.43,13.95},
        header = function()
            if IsControlJustPressed(1,38) then 
            end
        end
    },
	[8] = { -- Mecanica 1
		name = "Mecanico (a)",
        notifycoord = {-35.82,-1041.4,28.6},
        header = function()
            if IsControlJustPressed(1,38) then 
                TriggerEvent("Notify","amarelo","Dê <b>/service</b> para entrar ou sair de serviço.",5000)
            end
        end
    },
	[9] = { -- Mecanica 2
		name = "Mecanico (a)",
        notifycoord = {-200.81,-1317.91,31.09},
        header = function()
            if IsControlJustPressed(1,38) then 
                TriggerEvent("Notify","amarelo","Dê <b>/service</b> para entrar ou sair de serviço.",5000)
            end
        end
    },
	[10] = { -- Mecanica 3
		name = "Mecanico (a)",
        notifycoord = {811.21,-966.33,25.98},
        header = function()
            if IsControlJustPressed(1,38) then 
                TriggerEvent("Notify","amarelo","Dê <b>/service</b> para entrar ou sair de serviço.",5000)
            end
        end
    },
	[11] = { -- Mecanica 4
		name = "Mecanico (a)",
        notifycoord = {-345.57,-122.89,39.01},
        header = function()
            if IsControlJustPressed(1,38) then 
                TriggerEvent("Notify","amarelo","Dê <b>/service</b> para entrar ou sair de serviço.",5000)
            end
        end
    }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTION
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        local sleep = 500
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        for k,v in pairs(localidades) do
            local distance = #(coords - vector3(v.notifycoord[1],v.notifycoord[2],v.notifycoord[3]))
            if distance <= 1 then
                sleep = 4
                v.header()
            end
        end
        Citizen.Wait(sleep)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADHOVERFY
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	local innerTable = {}
	for k,v in pairs(localidades) do
		table.insert(innerTable,{ v.notifycoord[1],v.notifycoord[2],v.notifycoord[3],2,"E",v["name"],"Pressione para conversar" })
	end

	TriggerEvent("hoverfy:insertTable",innerTable)
end)