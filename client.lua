local lugar = {x=295.5284, y=-601.471, z=43.700} -- Posición 1
local lugar2 = {x=290.1530, y=-590.310, z=43.700} -- Posición 2
local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), true))
local ESX = exports['es_extended']:getSharedObject()

Keys = {
    ["ESC"]       = 322,  ["F1"]        = 288,  ["F2"]        = 289,  ["F3"]        = 170,  ["F5"]  = 166,  ["F6"]  = 167,  ["F7"]  = 168,  ["F8"]  = 169,  ["F9"]  = 56,   ["F10"]   = 57, 
    ["~"]         = 243,  ["1"]         = 157,  ["2"]         = 158,  ["3"]         = 160,  ["4"]   = 164,  ["5"]   = 165,  ["6"]   = 159,  ["7"]   = 161,  ["8"]   = 162,  ["9"]     = 163,  ["-"]   = 84,   ["="]     = 83,   ["BACKSPACE"]   = 177, 
    ["TAB"]       = 37,   ["Q"]         = 44,   ["W"]         = 32,   ["E"]         = 38,   ["R"]   = 45,   ["T"]   = 245,  ["Y"]   = 246,  ["U"]   = 303,  ["P"]   = 199,  ["["]     = 116,  ["]"]   = 40,   ["ENTER"]   = 18,
    ["CAPS"]      = 137,  ["A"]         = 34,   ["S"]         = 8,    ["D"]         = 9,    ["F"]   = 23,   ["G"]   = 47,   ["H"]   = 74,   ["K"]   = 311,  ["L"]   = 182,
    ["LEFTSHIFT"] = 21,   ["Z"]         = 20,   ["X"]         = 73,   ["C"]         = 26,   ["V"]   = 0,    ["B"]   = 29,   ["N"]   = 249,  ["M"]   = 244,  [","]   = 82,   ["."]     = 81,
    ["LEFTCTRL"]  = 36,   ["LEFTALT"]   = 19,   ["SPACE"]     = 22,   ["RIGHTCTRL"] = 70,
    ["HOME"]      = 213,  ["PAGEUP"]    = 10,   ["PAGEDOWN"]  = 11,   ["DELETE"]    = 178,
    ["LEFT"]      = 174,  ["RIGHT"]     = 175,  ["UP"]        = 27,   ["DOWN"]      = 173,
    ["NENTER"]    = 201,  ["N4"]        = 108,  ["N5"]        = 60,   ["N6"]        = 107,  ["N+"]  = 96,   ["N-"]  = 97,   ["N7"]  = 117,  ["N8"]  = 61,   ["N9"]  = 118
}

Citizen.CreateThread(function()
    while ESX.GetPlayerData() == nil do
        Wait(0)
    end
    PlayerData = ESX.GetPlayerData()
while true do
        local Player = PlayerPedId()
        local PPos = GetEntityCoords(Player)
        local _s = 1000
    if PlayerData.job.name == 'LosCrips' then -- Nombre del trabajo
        _s = 0
        if #(PPos - vector3(295.5284, -601.471, 43.700)) < 5 then
            DrawMarker(2, lugar.x, lugar.y, lugar.z - 1 , 0, 0, 0, 0, 0, 0, 0.75, 1.00, 0.6001,52,155,0, 200, 0, 0, 0, 0)
            if #(PPos - vector3(295.5284, -601.471, 43.700)) < 3 then
                DrawText3D(295.5284, -601.471, 42.5 +1, "Pulsa ~y~[E]~w~ para abrir el Garaje")
                if IsControlJustPressed(1, Keys['E']) then
                    OpenMenu()
                end
            end
        end
    end
    Citizen.Wait(_s)
end
end)

RegisterNetEvent('esx:playerLoaded', function(player)
PlayerData = player
end)

RegisterNetEvent('esx:setJob', function(job)
PlayerData = ESX.GetPlayerData()
PlayerData.job = job
end)

Citizen.CreateThread(function()
while true do
    local Player = PlayerPedId()
    local PPos = GetEntityCoords(Player)
    local _s = 1000
    if PlayerData.job.name == 'LosCrips' then -- Nombre del trabajo
        if #(PPos - vector3(290.1530, -590.310, 43.700)) < 5 then
            _s = 0
            DrawMarker(2, lugar2.x, lugar2.y, lugar2.z - 1 , 0, 0, 0, 0, 0, 0, 0.75, 1.00, 0.6001,52,155,0, 200, 0, 0, 0, 0)
            if #(PPos - vector3(290.1530, -590.310, 43.700)) < 3 then
                DrawText3D(290.1530, -590.310, 42.5 +1, "Pulsa ~y~[E]~w~ para guardar el Vehículo") -- Texto que sale cuando estas encima del punto
                if IsControlJustReleased(1, 38) then
                    if IsPedInAnyVehicle(Player, false) then
                        DeleteVehicle(GetVehiclePedIsIn(Player))
                    else
                        ESX.ShowNotification("No estás en ningún vehículo")
                    end
                end
            end
        end
        
    end
    Citizen.Wait(_s)
end
end)

function DrawText3D(x,y,z, text) 

    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        SetTextScale(0.0*scale, 0.5*scale)
        SetTextFont(0)
        SetTextProportional(1)
        -- SetTextScale(0.0, 0.55)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

function OpenMenu()
    local Player = PlayerPedId()
    local vehicles = {
        {label = 'label coche', value = 'modelo coche'}, -- Nombre y modelo del coche 1
        {label = 'label coche', value = 'modelo coche'}, -- Nombre y modelo del coche 2
    }

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'garage',{
        title = 'Vehículos Los Crips', -- Nombre del menu
        align = 'bottom-right',
        elements = vehicles
    },
    function(data, menu)
        if data.current.value == 'modelocoche' then -- Modelo del coche 1
            ESX.Game.SpawnVehicle('modelocoche', vector3(280.7922, -608.539, 43.087), 93.9988, function(veh) -- Modelo del coche 1
                TaskWarpPedIntoVehicle(Player, veh, -1)
                exports['LegacyFuel']:SetFuel(veh, 100)
            end)
            menu.close()
        elseif data.current.value == 'modelocoche' then -- Modelo del coche 2
            ESX.Game.SpawnVehicle('modelocoche', vector3(280.7922, -608.539, 43.087), 93.9988, function(veh) -- Modelo del coche 2
                TaskWarpPedIntoVehicle(Player, veh, -1)
                exports['LegacyFuel']:SetFuel(veh, 100)
            end)
            menu.close()
        end
    end,
    function(data, menu)
        menu.close()
    end)
end

RegisterNetEvent('LosCripsgarage:setJob') -- Renombrar al nombre del script
AddEventHandler('LosCripsgarage:setJob',function(jobu) -- Renombrar al nombre del script
	job = jobu
end)