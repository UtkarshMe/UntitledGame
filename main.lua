globals = {}
globals.logLevel = 'debug'
globals.timer = require('timer')
globals.assets = require('assets')

globals.scaleMouse = function (x, y)
    return (x - globals.view.x) / globals.view.scale,
        (y - globals.view.y) / globals.view.scale
end

local game = require('game'); globals.game = game

-- Function to initialize game state
-- Put config parsing, state initialization etc. here
function love.load()
    globals.view = {
        scale = 1,
        x = 0,
        y = 0,
    }
    globals.assets.load()
    game.load()
    globals.canvas = love.graphics.newCanvas()
end

-- Function to render the game screen
-- Parse game state and construct the screen here
function love.draw()
    love.graphics.setCanvas(globals.canvas)
        love.graphics.clear()
        game.draw()
    love.graphics.setCanvas()
    love.graphics.draw(globals.canvas, globals.view.x, globals.view.y, 0,
            globals.view.scale)
end

-- Function to manipulate game state at each frame
-- Put game strategy here
function love.update(timeSinceUpdate)
    globals.timer.update(timeSinceUpdate)
    game.update()
end

function love.keypressed(key, unicode)
    if key == "escape" then
        love.event.quit()
    else
        game.event.push('keyinput', { key, unicode })
    end
end

function love.textinput(text)
    game.event.push('textinput', { text })
end

function love.mousepressed(x, y, button)
    x, y = globals.scaleMouse(x, y)
    game.event.push('mousepress', { x, y, button })
end

function love.resize(width, height)
    local function min(a, b)
        if a > b then
            return b
        else
            return a
        end
    end
    local scale = min(width / 800, height / 600)
    globals.view = {
        scale = scale,
        x = (width - (800 * scale)) / 2,
        y = (height - (600 * scale)) / 2,
    }
end
