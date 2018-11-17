local game = require('game')

local total_time

-- Function to initialize game state
-- Put config parsing, state initialization etc. here
function love.load()
    game:init()

    -- TODO: this should be loaded from views/
    function game.draw() end

    total_time = 0
end

-- Function to render the game screen
-- Parse game state and construct the screen here
function love.draw()
    game.draw()
end

-- Function to manipulate game state at each frame
-- Put game strategy here
function love.update(time_since_update)
    total_time = total_time + time_since_update

    -- check for input
    -- handle input: update state
    game:handleEvent('activate', {'new'})

    -- update computer controlled characters
end
