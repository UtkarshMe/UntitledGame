-- util.lua

local util = {}

function util.newEventHandler(parent, model)
    local obj = parent or require('controllers.Default')
    return function(event, args)
        if obj[event] then
            obj[event](model, args)
        else
            love.event.push(event, args)
        end
    end
end

return util
