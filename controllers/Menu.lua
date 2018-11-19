-- controllers/Menu.lua : Controllers for Menu model

local log = require('log')
local Controller = require('controllers/Controller')
local controller = Controller:new(Controller)

function controller:activate(args)
    local item = unpack(args)
    log.debug('Menu.activate: ' .. item)
    self._parent.items[item].target()
end


return controller
