-- models/Background.lua : The background of the game

local Background = {
    size = {
        width = 0,
        height = 0
    },
    color = { 1, 0, 0, 1 },
}

function Background:init(width, height)
    self.size.width, self.size.height = width, height
end

return Background
