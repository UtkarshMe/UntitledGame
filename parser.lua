local Stack = require('lib.Stack')

local function table_has(table, value)
    for _, val in ipairs(table) do
        if val == value then
            return true
        end
    end
    return false
end

local function newCommand(command, parent)
    local obj = { value = command, next = nil }
    if parent then
        parent.next = obj
    end
    return obj
end

local function parse(rawScript)
    local commands = {}
    local current = 1
    local command = nil
    local nextToken = string.gmatch(rawScript or '', "[%a_]+")
    local ifStack = Stack:new()

    while true do
        local token = nextToken()
        if not token then
            break
        end

        if table_has({ 'forward', 'backward', 'left', 'right', 'strike' },
                token) then
            command = newCommand(token, command)
            commands[current] = command
            current = current + 1

        elseif table_has({'ifexit', 'ifstart'}, token) then
            command = newCommand(token, command)
            commands[current] = command
            current = current + 1

            command.exit = newCommand('endif', command)
            commands[current] = command.exit
            current = current + 1

            command.elseBranch = newCommand('else', nil)
            commands[current] = command.elseBranch
            command.elseBranch.next = command.exit
            current = current + 1

            command.thenBranch = newCommand('then', nil)
            commands[current] = command.thenBranch
            command.thenBranch.next = command.exit
            current = current + 1

            ifStack:push(command)
            command = command.thenBranch

        elseif token == 'else' then
            local ifcond = ifStack:top()
            if not ifcond then
                return nil
            end
            command.next = ifcond.exit
            command = ifcond.elseBranch

        elseif token == 'endif' then
            local ifcond = ifStack:top()
            if not ifcond then
                return nil
            end
            ifStack:pop()
            command.next = ifcond.exit
            command = ifcond.exit

        else -- unknown token
            return nil
        end
    end

    if ifStack:top() then
        return nil
    end

    commands.top = commands[1]

    return commands
end

return {
    parse = parse,
}
