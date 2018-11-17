-- lib/Stack.lua : A LIFO stack

local Stack = {}

function Stack:new()
    local obj = {
        _stack = {}
    }

    self.__index = self
    return setmetatable(obj, self)
end

function Stack:push(item)
    self._stack[#self._stack + 1] = item
end

function Stack:pop()
    if #self._stack > 0 then
        table.remove(self._stack, #self._stack)
    end
end

function Stack:top()
    return self._stack[#self._stack]
end

function Stack:empty()
    self._stack = {}
end

return Stack
