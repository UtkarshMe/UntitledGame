-- state.lua : Keeps track of the state of the game

local prefix = 'data.states.'

local State = {
    _stack = {},
    _states = {
        dummy1 = { name = 'dummy1' }, dummy2 = { name = 'dummy2' }, -- for tests
        menu = require(prefix .. 'menu'),
    }
}

function State:push(state)
    self._stack[#self._stack + 1] = self._states[state]
end

function State:pop()
    if #self._stack > 0 then
        table.remove(self._stack, #self._stack)
    end
end

function State:current()
    local state = self._stack[#self._stack]
    if state then
        return state.name
    end
end

function State:empty()
    self._stack = {}
end

function State:init()
    self:empty()
end

return State
