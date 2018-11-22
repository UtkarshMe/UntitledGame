globals = {}
globals.logLevel = 'debug'

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
function love.update()
end

function love.keypressed(key, unicode)
    if key == "escape" then
        love.event.quit()
    else
        game.event.push('keyinput', { key, unicode })
    end
end
