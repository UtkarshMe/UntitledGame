-- models/states/menu.lua : State info for menu

local State = require('models.states.State')
local state = State:new('menu')

state:addEvent('activate', function(args)
    print('menu activated: ' .. unpack(args))
end)

return state
