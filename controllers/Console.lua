-- controllers/Console.lua : Controllers for Console model

local log = require('log')
local utf8 = require('utf8')
local controller = { name = 'Console' }

function controller.submit(model)
    globals.game.event.push('scriptSubmit', { model:getValue() })
    globals.game.event.push('run')
end

function controller.update(model, args)
    model:updateValue(args[1])
end

function controller.textinput(model, args)
    model:appendValue(args[1])
end

function controller.keyinput(model, args)
    -- TODO: Implement way to move cursor
    local key = args[1] or 'empty'
    log.debug('Console.keyinput: ' .. key)

    if key == 'backspace' then
        local value = model:getValue()
        local byteoffset = utf8.offset(value, -1)

        if byteoffset then
            -- remove the last UTF-8 character.
            -- string.sub operates on bytes rather than UTF-8 characters, so we
            -- couldn't do string.sub(value, 1, -2).
            value = string.sub(value, 1, byteoffset - 1)
        end
        model:updateValue(value)

    elseif key == 'return' then  -- FIXME
        globals.game.event.push('submit')
    end
end

return controller
