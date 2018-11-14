-- components/Background.lua : The background of the game

local Background = {
    size = { width = 0, height = 0 },
    canvas = nil,           -- cached static canvas
}


function Background:new(width, height)
    local newObj = {
        size = { width = width, height = height },
        canvas = love.graphics.newCanvas(width, height),
    }

    -- generate canvas
    love.graphics.setCanvas(newObj.canvas)
        love.graphics.clear()
        love.graphics.setBlendMode('alpha')
        love.graphics.setColor(1, 0, 0, 1)  -- tomato color
        love.graphics.rectangle('fill', 0, 0, width, height)
    love.graphics.setCanvas()  -- reset the canvas

    self.__index = self
    return setmetatable(newObj, self)
end

function Background:update()
    -- TODO
    return self
end


return Background
