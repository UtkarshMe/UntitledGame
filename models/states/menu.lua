-- data/states/menu.lua : State info for menu

local state = {
    name = 'menu',
    events = {}
}

local function activate(args)
    print('menu activated: ' .. unpack(args))
end
state.events.activate = activate

return state
