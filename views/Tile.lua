
local View = {}

function View:init(tileName, props)
    self.model = require('data/tiles/' .. tileName)

    -- generate canvas: this should only ever be done once
    self.canvas = love.graphics.newCanvas()
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setCanvas(self.canvas)
        love.graphics.clear()
        love.graphics.setBlendMode('alpha')
        love.graphics.setColor(self.model.color)
        love.graphics.rectangle('fill', 0, 0, props.width, props.height)
    love.graphics.setCanvas()  -- reset the canvas
end

function View:draw(x, y)
    love.graphics.draw(self.canvas, x, y)
end

return View
