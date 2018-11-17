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

return Game
