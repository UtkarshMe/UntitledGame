-- controllers/Menu.lua : Controllers for Menu model

local log = require('log')
local controller = { name = 'Menu' }

function controller.activate(model, args)
    local item = unpack(args)
    log.debug('Menu.activate: ' .. item)
    model.items[item].target()
end

function controller.keyinput(model, args)
    local key = unpack(args)
    local highlighted = model:getHighlighted()

    log.debug('Menu.keyinput: ' .. key)

    if key == 'return' then
        globals.game.event.push('activate', { highlighted })
        return
    elseif key == 'down' then
        highlighted = highlighted + 1
    elseif key == 'up' then
        highlighted = highlighted - 1
    end

    if highlighted == 0 then
        highlighted = #model.items
    elseif highlighted > #model.items then
        highlighted = 1
    end

    model:setHighlighted(highlighted)
end

function controller.textinput()
    -- nop
end

return controller
