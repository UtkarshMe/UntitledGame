
local conf = {
    name = 'WRT',
}

-- Put love2d configuration here
function love.conf(init)
    init.window.title = conf.name
    init.window.width = 800
    init.window.height = 600
    init.window.borderless = true
    init.window.resizable = true
end

return conf
