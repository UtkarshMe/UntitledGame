-- controllers/Map.lua : Controllers for Map model

local log = require('log')
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

function controller:input(args)
    self._parent.script = unpack(args)
    self.nextToken = string.gmatch(self._parent.script or '', "[%a_]+")
end

function controller:step()
    local command = self:nextToken()
    if command then
        log.debug('Map.step: ' .. command)
        self:execute({ command })
    else
        log.debug('Map.step: End of script')
    end
end

return controller
