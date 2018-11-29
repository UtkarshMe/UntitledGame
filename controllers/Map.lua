-- controllers/Map.lua : Controllers for Map model

local utf8 = require('utf8')
local log = require('log')
local default = require('controllers.Default')
local controller = { name = 'Map' }

function controller.submit(model)
    model.console:setError()
    globals.game.models.Map:reset()
    globals.game.event.push('scriptSubmit', { model.console:getValue() })
end

function controller.scriptError(model)
    model.console:setError('Error in script')
end

function controller.update(model, args)
    model.console:updateValue(args[1])
end

function controller.execute(model, args)
    local command = unpack(args)
    if not command then
        return
    end
    local user = model:getPosition('user')
    log.debug('execute: ' .. command.value)
    if command.value == 'forward' then
        user[2] = user[2] - 1
    elseif command.value == 'backward' then
        user[2] = user[2] + 1
    elseif command.value == 'left' then
        user[1] = user[1] - 1
    elseif command.value == 'right' then
        user[1] = user[1] + 1

    elseif command.value == 'strike' then
        local artifact = model:getArtifact(user[1], user[2] - 1)
        if artifact then
            model:setTile(user[1], user[2] - 1, artifact)
            globals.game.views.Map:update()
        end

    elseif command.value == 'ifstart' then
        local start = model:getPosition('start')
        if start[1] == user[1] and start[2] == user[2] then
            log.debug('setCommand then')
            globals.game.script.parsed.setCommand(command.thenBranch)
            globals.game.event.push('step')
            return
        else
            log.debug('setCommand else')
            globals.game.script.parsed.setCommand(command.elseBranch)
            globals.game.event.push('step')
            return
        end
    elseif command.value == 'then'
            or command.value == 'else'
            or command.value == 'endif' then
        globals.game.event.push('step')
    end

    if model:isTileMovable(user[1], user[2]) then
        model:setPosition('user', user)
    else
        globals.game.event.push('step')
    end
end

function controller.step(model)
    local command = nil
    if globals.game.script.parsed then
        command = globals.game.script.parsed.nextCommand()
    end
    if command then
        log.debug('Map.step: ' .. command.value)
        controller.execute(model, { command })
    else
        log.debug('Map.step: End of script')
        globals.game.event.push('checkWin')
    end
end

function controller.checkWin(model)
    local user = model:getPosition('user')
    local exit = model:getPosition('exit')

    globals.game.event.clear()

    if user[1] == exit[1] and user[2] == exit[2] then
        globals.game.event.push('endGame', { 'win' })
    else
        globals.game.event.push('endGame', { 'lose' })
    end
end

function controller.keyinput(model, args)
    -- TODO: Implement way to move cursor
    local key = args[1] or 'empty'
    log.debug('Console.keyinput: ' .. key)

    if key == 'backspace' then
        local value = model.console:getValue()
        local byteoffset = utf8.offset(value, -1)

        if byteoffset then
            -- remove the last UTF-8 character.
            -- string.sub operates on bytes rather than UTF-8 characters, so we
            -- couldn't do string.sub(value, 1, -2).
            value = string.sub(value, 1, byteoffset - 1)
        end
        model.console:updateValue(value)

    elseif key == 'return' then
        model.console:appendValue('\n')
    end
end

function controller.textinput(model, args)
    model.console:appendValue(args[1])
end

controller.mousepress = default.mousepress

return controller
