
-- Put love2d configuration here
function love.conf(init)
    init.window.width = 800
    init.window.height = 600
end

local conf = {}

function conf.getMeta()
    return {
        name = 'Untitled Game',
    }
end

return conf
