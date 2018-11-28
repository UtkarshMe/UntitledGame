-- util.lua

local util = {}
local parser = require('parser')

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

function util.newParsedScript(rawScript)
    local parsedCommands = parser.parse(rawScript)
    if not parsedCommands then
        return nil
    end
    local parsed = {
        commands = parsedCommands
    }
    parsed.current = parsed.commands.top
    parsed.nextCommand = function()
        local command = parsed.current
        if command then
            parsed.current = command.next
            return command
        else
            return nil
        end
    end

    parsed.setCommand = function(command)
        parsed.current = command
    end

    return parsed
end

return util
