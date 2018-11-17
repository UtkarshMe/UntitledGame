-- game.lua : Control the game

local Game = {
    state = require('state'),
}

function Game:init()
    self.state:init()
    self.state:push('menu')  -- initial state
end

function Game:handleEvent(event, args)
    local currentState = self.state:current()
    local cb = self.state:getStateInfo(currentState).events[event]

    if cb then
        cb(args)
    else
        print('Unregistered event!')
    end
end

function Game:addEvent(stateName, event, cb)
    local state = self.state:getStateInfo(stateName)
    if state then
        if state.events[event] then
            print('Event exists!')
        else
            state.events[event] = cb
        end
    end
end

return Game
