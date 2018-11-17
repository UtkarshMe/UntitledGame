-- game.lua : Control the game

local prefix = 'models.states.'

local Game = {
    state = require('state'),
    _states = {
        menu = require(prefix .. 'menu'),
    }
}

function Game:init()
    self.state:empty()
    self.state:push(self._states.menu)  -- initial state
end

function Game:handleEvent(event, args)
    self.state:current():handleEvent(event, args)
end

function Game:addEvent(stateName, event, cb)
    self._states[stateName]:addEvent(event, cb)
end

return Game
