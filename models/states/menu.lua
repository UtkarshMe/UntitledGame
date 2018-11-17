-- models/states/menu.lua : State info for menu

local log = require('log')
local State = require('models.states.State')
local state = State:new('menu')

state:addEvent('activate', function(args)
    log.debug('menu activated: ' .. unpack(args))
    globals.game.switch('map')
end)

return state
