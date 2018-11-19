-- controllers/Map.lua : Controllers for Map model

local Controller = require('controllers/Controller')
local controller = Controller:new('map')

function controller:execute(args)
    local command = unpack(args)
    if command == 'forward' then
        local user = self._parent:getUserPosition()
        user[2] = user[2] - 1
        self._parent:setUserPosition(user)
    end
end

return controller
