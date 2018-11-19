globals = {}

local game = require('game')

-- Function to initialize game state
-- Put config parsing, state initialization etc. here
function love.load()
    globals.game = game

    game.init()

    -- FIXME: should be in update
    game.event:push('activate', { 1 }) -- user "activates" button "new"
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
