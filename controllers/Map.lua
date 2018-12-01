-- controllers/Map.lua : Controllers for Map model

local log = require('log')
local default = require('controllers.Default')
local controller = { name = 'Map' }

function controller.submit(model)
    globals.game.event.push('resetGame')
    globals.game.event.push('scriptSubmit', { model.console:getValue() })
end

function controller.scriptError(model)
    love.audio.play(globals.assets.sounds.message)
    model.console:setMessage('There is some error in your commands.')
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

    elseif command.value == 'open' then
        local artifact = model:getArtifact(user[1], user[2] - 1)
        if artifact then
            model:setTile(user[1], user[2] - 1, artifact)
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
    elseif command.value == 'ifexit' then
        local exit = model:getPosition('exit')
        if exit[1] == user[1] and exit[2] == user[2] then
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
            or command.value == 'endif'
            or command.value == 'break'
            or command.value == 'endloop' then
        globals.game.event.push('step')
    end

    if model:isTileMovable(user[1], user[2]) then
        model:setPosition('user', user)
    else
        globals.game.event.push('step')
    end

    globals.game.views.Map:update()
end

function controller.step(model)
    local command = nil
    if globals.game.script.parsed then
        command = globals.game.script.parsed.nextCommand()
    end
    if command then
        log.debug('Map.step: ' .. command.value)
        love.audio.play(globals.assets.sounds.step)
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
        model.console:setMessage('You won! On to the next level.')
        globals.game.event.push('endGame', { 'win' })
    else
        model.console:setMessage('You lost! Tweak your commands and try again.')
        globals.game.event.push('endGame', { 'lose' })
    end
end

function controller.keyinput(model, args)
    -- TODO: Implement way to move cursor
    local key = args[1] or 'empty'
    log.debug('Console.keyinput: ' .. key)

    if key == 'backspace' then
        model.console:backspace()

    elseif key == 'left' then
        model.console:moveCursor(-1)

    elseif key == 'right' then
        model.console:moveCursor(1)

    elseif key == 'home' then
        model.console:moveCursor(-string.len(model.console:getValue()))

    elseif key == 'end' then
        model.console:moveCursor(string.len(model.console:getValue()))

    elseif key == 'tab' then
        model.console:appendValue('\t')

    elseif key == 'return' then
        model.console:appendValue('\n')
    end

    love.audio.play(globals.assets.sounds.key)
end

function controller.textinput(model, args)
    model.console:appendValue(args[1])
end

controller.mousepress = default.mousepress

return controller
