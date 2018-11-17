-- state.lua : Keeps track of the state of the game

local State = {
    _stack = {},
}

function State:push(state)
    self._stack[#self._stack + 1] = state
end

function State:pop()
    if #self._stack > 0 then
        table.remove(self._stack, #self._stack)
    end
end

function State:current()
    return self._stack[#self._stack]
end

function State:empty()
    self._stack = {}
end

function State:init()
    self:empty()
end

return State
