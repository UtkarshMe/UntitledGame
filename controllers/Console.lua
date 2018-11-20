-- controllers/Console.lua : Controllers for Console model

local Controller = require('controllers/Controller')
local controller = Controller:new()

function controller:submit()
    globals.game.switch('map')
end

function controller:update(args)
    local text = unpack(args)
    self._parent:updateValue(text)
end

return controller
