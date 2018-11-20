-- controllers/Menu.lua : Controllers for Menu model

local log = require('log')
local Controller = require('controllers/Controller')
local controller = Controller:new(Controller)

function controller:activate(args)
    local item = unpack(args)
    log.debug('Menu.activate: ' .. item)
    self._parent.items[item].target()
end

function controller:keyinput(args)
    local key = unpack(args)
    local highlighted = self._parent:getHighlighted()

    log.debug('Menu.keyinput: ' .. key)
    if key == 'return' then
        globals.game.event:push('activate', { highlighted })
        return
    elseif key == 'down' then
        highlighted = highlighted + 1
    elseif key == 'up' then
        highlighted = highlighted - 1
    end

    if highlighted == 0 then
        highlighted = #self._parent.items
    elseif highlighted > #self._parent.items then
        highlighted = 1
    end

    self._parent:setHighlighted(highlighted)
end


return controller
