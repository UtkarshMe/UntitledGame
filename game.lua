-- game.lua : A state machine to control the game

local log = require('log')
local util = require('util')
local maps = {
    'forward',
}

local game = {
    state = require('lib.Stack'):new(),
    models = {},
    views = {},
    event = {
        handlers = love.handlers,
        poll = love.event.poll,
    },
    maps = {
        _current = 1,
    },
}

function game.event.add(stateName, event, cb)
    log.debug('game.event.add: ' .. stateName .. ': ' .. event)
    game.event.handlers[stateName][event] = cb
end

function game.maps.current()
    return game.maps[game.maps._current]
end

function game.event.handlers.redraw()
    log.debug('drawing')
    game.draw()
end

function game.event.push(event, args)
    local state = game.state:top()
    log.debug('game.event.push: ' .. state .. ': ' .. event)
    love.event.push(state, event, args)
end

function game.event.handlers.nextMap()
    local current = game.maps._current + 1
    if not game.maps[current] then
        love.event.quit()
    else
        game.maps._current = current
    end
end

function game.event.handlers.resetMap()
    game.maps._current = 1
end

function game.loadComponent(component)
    log.debug('game.loadComponent: ' .. component)
    local model = require('models.' .. component):new({ name = component })
    game.models[component] = model
    game.views[component] = require('views.' .. component):new(model)
    game.event.handlers[component] = util.newEventHandler(
            require('controllers.' .. component), model)
end

function game.load()
    game.loadComponent('Menu')
    game.loadComponent('Console')
    game.loadComponent('Map')

    for i=1,#maps do
        game.maps[i] = require('data.maps.' .. maps[i])
    end

    game.models.Menu:addItem('New Game', function()
        log.debug('Menu: new game')
        game.state:push('Console')
    end)
    game.models.Menu:addItem('Load Game', function()
        log.debug('Menu: load game')
        love.event.quit()  -- TODO
    end)
    game.models.Menu:addItem('Save Game', function()
        log.debug('Menu: save game')
        love.event.quit()  -- TODO
    end)
    game.models.Menu:addItem('How to Play', function()
        log.debug('Menu: how to play')
        love.event.quit()  -- TODO
    end)
    game.models.Menu:addItem('Exit', function()
        log.debug('Menu: quit')
        love.event.quit()  -- TODO
    end)

    game.views.Menu:load()
    game.views.Console:load()
    game.views.Map:load()

    game.state:push('Menu')
    game.event.push('Menu', 'redraw')

    game.models.Map:load(game.maps.current())
    game.views.Map:update()
end

function game.draw()
    game.views[game.state:top()]:draw()
end

return game
