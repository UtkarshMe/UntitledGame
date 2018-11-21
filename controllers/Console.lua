-- controllers/Console.lua : Controllers for Console model

local controller = { name = 'Console' }

function controller.submit(model)
    globals.game.state:push('Map')
    globals.game.event.push('input', { model:getValue() })
end

function controller.update(model, args)
    model:updateValue(args[1])
end

return controller
