local parser = {}

local function newCommand(command, parent)
    local obj = { value = command, next = nil }
    if parent then
        parent.next = obj
    end
    return obj
end

function parser.parse(rawScript)
    local commands = {}
    local current = 1
    local command = nil

    for token in string.gmatch(rawScript or '', "[%a_]+") do
        -- TODO: This does not support loops, conditions etc.
        command = newCommand(token, command)
        commands[current] = command
        current = current + 1
    end

    commands.top = commands[1]

    return commands
end

return parser
