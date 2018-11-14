
-- Function to initialize game state
-- Put config parsing, state initialization etc. here
function love.load()
    components = require('components/components')

    local props = {
        screen = {
            width = 1024,  -- TODO: this should not be hard-coded
            height = 768
        }
    }
    -- components should only be initialized after screen size is defined
    -- because screen size is required to properly load them
    components:init(props)
end

-- Function to render the game screen
-- Parse game state and construct the screen here
function love.draw()
    love.graphics.setColor(1, 1, 1, 1)  -- reset color before drawing to canvas

    love.graphics.draw(components.background.canvas)
end

-- Function to manipulate game state at each frame
-- Put game strategy here
function love.update(time_since_update)
end
