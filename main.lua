globals = {}
globals.logLevel = 'debug'
globals.timer = require('timer')

local game = require('game'); globals.game = game

-- Function to initialize game state
-- Put config parsing, state initialization etc. here
function love.load()
    game.load()
end

-- Function to render the game screen
-- Parse game state and construct the screen here
function love.draw()
    game.draw()
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
    game.event.push('mousepress', { x, y, button })
end

function love.resize(width, height)
    for _,view in pairs(game.views) do
        view:load(width, height)
    end
end
