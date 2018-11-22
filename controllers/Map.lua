-- controllers/Map.lua : Controllers for Map model

local log = require('log')
local default = require('controllers.Default')
local controller = { name = 'Map' }

function controller.execute(model, args)
    local command = unpack(args)
    if command == 'forward' then
        local user = model:getPosition('user')
        user[2] = user[2] - 1
        model:setPosition('user', user)
    end
end

function controller.step()
    local command = globals.game.script.parsed.nextCommand()
    if command then
        log.debug('Map.step: ' .. command)
        globals.game.event.push('execute', { command })
    else
        log.debug('Map.step: End of script')
        globals.game.event.push('endGame')
    end
end

function controller.endGame(model)
    local user = model:getPosition('user')
    local exit = model:getPosition('exit')

    if user[1] == exit[1] and user[2] == exit[2] then
        globals.game.event.push('win')
    else
        globals.game.event.push('lose')
    end
end

function controller.win()
    log.info('User won')
end

function controller.lose()
    log.info('User lost')
end

controller.keyinput = default.keyinput
controller.textinput = default.textinput

return controller
