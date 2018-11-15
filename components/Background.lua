-- components/Background.lua : The background of the game

local Background = {
    size = { width = 0, height = 0 },
    canvas = nil,           -- cached static canvas
}


function Background:new(width, height)
    local newObj = {
        size = { width = width, height = height },
    }

    self.__index = self
    return setmetatable(newObj, self)
end

function Background:update()
    -- TODO
    return self
end

function Background:initCanvas()
    self.canvas = love.graphics.newCanvas()

    love.graphics.setCanvas(self.canvas)
        love.graphics.clear()
        love.graphics.setBlendMode('alpha')
        love.graphics.setColor(1, 0, 0, 1)  -- tomato color
        love.graphics.rectangle('fill', 0, 0, self.size.width, self.size.height)
    love.graphics.setCanvas()  -- reset the canvas
end

return Background
