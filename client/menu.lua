ESX = exports[Config.FrameworkName]:getSharedObject()

lib.registerContext({
    id = 'vs_pedmenu',
    title = 'VS Ped Menu',
    options = {
        {
            title = 'Set your skin',
            description = 'Set your skin',
            icon = 'fas fa-tshirt',
            onSelect = function ()
                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                    local isMale = skin.sex == 0
                    TriggerEvent('skinchanger:loadDefaultModel', isMale, function()
                        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                            TriggerEvent('skinchanger:loadSkin', skin)
                        end)
                    end)
                end)
                ESX.ShowNotification('Skin set')
            end
        },
        {
            title = 'Spawn Ped',
            description = 'Spawn a ped',
            icon = 'fas fa-child',
            menu = 'show_ped'
        }
    }
})

local options = {}
for _, info in pairs(Config.PedList) do
    options[#options + 1] = {
        title = info.name,
        description = 'Spawn a ped',
        image = info.image,
        onSelect = function()
            local Ped = GetHashKey(info.value)
            RequestModel(Ped)
            while not HasModelLoaded(Ped) do
                Wait(100)
            end
            SetPlayerModel(PlayerId(), Ped)
            SetModelAsNoLongerNeeded(Ped)
            ESX.ShowNotification('Ped set')
        end
    }
end

lib.registerContext({
    id = 'show_ped',
    menu = 'vs_pedmenu',
    title = 'Show Ped',
    options = options,
})

if Config.UseCommand == true then
      RegisterCommand('pedmenu', function()
        lib.showContext('vs_pedmenu')
    end, false)
end

if Config.UseKey == true then
    Keys.Register(Config.Keys, 'vs_pedmenu', 'Show Ped Menu', function()
        lib.showContext('vs_pedmenu')
    end)
end