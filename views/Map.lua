
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
    love.graphics.setCanvas()  -- reset the canvas
end

function View:generate()
    love.graphics.setCanvas(self.canvas)
        love.graphics.setColor(0, 0, 0, 1)
        for x=1,#self.model.data do
            for y=1,#self.model.data[x] do
                love.graphics.print(
                        self.model.components[self.model:getTile(x, y)],
                        x * 50, y * 50)
            end
        end
    love.graphics.setCanvas()  -- reset the canvas
end

function View:draw(width, height)
    love.graphics.draw(self.canvas, width, height)
end

return View
