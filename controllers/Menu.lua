-- controllers/Menu.lua : Controllers for Menu model

local log = require('log')
local Controller = require('controllers/Controller')
local controller = Controller:new(Controller)

function controller.activate(args)
    log.debug('Menu.activate: ' .. unpack(args))
    globals.game.switch('map')
end


return controller
