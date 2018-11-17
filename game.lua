-- game.lua : Control the game

local log = require('log')
local prefix = 'models.states.'

local game = {
    state = require('state'),
    _states = {
        menu = require(prefix .. 'menu'),
        map = require(prefix .. 'map'),
    },
    event = {},  -- TODO: Add queue
}

function game.init()
    game.state:empty()
    game.switch('menu')  -- initial state
end

function game.switch(stateName)
    if game._states[stateName] then
        log.debug('game.switch: ' .. stateName)
        game.state:push(game._states[stateName])
    else
        error('game.switch: state "' .. stateName .. '" does not exist')
    end
end


function game.event:push(event, args)
    -- game.event will eventually use queue. add self as argument to keep the
    -- interface constant.
    self._top = event
    game.state:current():handleEvent(self._top, args)
end

function game.event.add(stateName, event, cb)
    game._states[stateName]:addEvent(event, cb)
end

return game
