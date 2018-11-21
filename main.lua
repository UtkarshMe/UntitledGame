globals = {}
globals.logLevel = 'debug'

local game = require('game'); globals.game = game

-- Function to initialize game state
-- Put config parsing, state initialization etc. here
function love.load()
    game.load()

    -- FIXME: should be in update
    game.event.push('update', { 'forward forward forward' })
    game.event.push('submit')
    game.event.push('step')
    game.event.push('step')
    game.event.push('step')
    game.event.push('step')
end

-- Function to render the game screen
-- Parse game state and construct the screen here
function love.draw()
    game.draw()
end

-- Function to manipulate game state at each frame
-- Put game strategy here
function love.update()
    -- check for input
    -- handle input: update state

    -- update computer controlled characters
end

function love.keypressed(key, unicode)
    if key == "escape" then
        love.event.quit()
    else
        game.event.push('keyinput', { key, unicode })
    end  -- temporary
end
