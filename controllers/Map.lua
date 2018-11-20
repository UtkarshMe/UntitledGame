-- controllers/Map.lua : Controllers for Map model

local log = require('log')
local Controller = require('controllers/Controller')
local controller = Controller:new('map')

function controller:execute(args)
    local command = unpack(args)
    if command == 'forward' then
        local user = self._parent:getPosition('user')
        user[2] = user[2] - 1
        self._parent:setPosition('user', user)
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
        globals.game.event:push('execute', { command })
    else
        log.debug('Map.step: End of script')
        globals.game.event:push('endGame')
    end
end

function controller:endGame()
    local user = self._parent:getPosition('user')
    local exit = self._parent:getPosition('exit')

    if user[1] == exit[1] and user[2] == exit[2] then
        globals.game.event:push('win')
    else
        globals.game.event:push('lose')
    end
end

function controller.win()
    log.info('User won')
end

function controller.lose()
    log.info('User lost')
end

return controller
