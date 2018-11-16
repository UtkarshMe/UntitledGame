
local View = {
    model = nil,
    canvas = nil,
}

function View:init(model)
    self.model = model

    -- generate canvas: this should only ever be done once
    self.canvas = love.graphics.newCanvas()
    love.graphics.setCanvas(self.canvas)
        love.graphics.clear()
        love.graphics.setBlendMode('alpha')
        love.graphics.setColor(0, 0, 0, 1)
        love.graphics.print('Hello there')
    love.graphics.setCanvas()  -- reset the canvas
end

function View:draw(width, height)
    love.graphics.draw(self.canvas, width, height)
end

return View
