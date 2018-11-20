-- game.lua : A state machine to control the game

local log = require('log')
local util = require('util')

local game = {
    state = require('lib.Stack'):new(),
    event = {},  -- TODO: Add queue
}

function game.init()
    game._states = {
        menu = util.load('Menu'),
        console = util.load('Console'),
        map = util.load('Map'),
    }

    game._states.menu:addItem('New Game', function()
        game.switch('console')
    end)
    game._states.menu:addItem('Load Game')
    game._states.menu:addItem('Save Game')
    game._states.menu:addItem('How to Play')
    game._states.menu:addItem('Exit', function()
        love.event.quit()
    end)
    game._states.menu.view:load()

    game.switch('menu')  -- initial state

    game._states.map:load('forward')
    game._states.map.view:update()
end

function game.draw()
    game.state:top().view:draw()
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
    game.state:top().controller:handleEvent(self._top, args)
end

function game.event.add(stateName, event, cb)
    game._states[stateName]:addEvent(event, cb)
end

return game
