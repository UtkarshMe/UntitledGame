-- state.lua : Keeps track of the state of the game

local Stack = require('lib.Stack')
local State = Stack:new()

function State:current()
    return self:top()
end

return State
