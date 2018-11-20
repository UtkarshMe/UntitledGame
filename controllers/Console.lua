-- controllers/Console.lua : Controllers for Console model

local controller = { name = 'Console' }
local log = require('log')

function controller.submit(model)
    globals.game.state:push('Map')
    globals.game.event.push('input', { model:getValue() })
end

function controller.update(model, args)
    model:updateValue(args[1])
end

function controller.textinput(model, args)
    model:appendValue(args[1])
end

function controller.keyinput(_, args)
    -- TODO: Implement way to move cursor
    log.debug('Console.keyinput: ' .. (args[1] or 'empty'))
end

return controller
