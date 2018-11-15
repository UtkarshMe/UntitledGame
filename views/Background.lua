-- views/Background.lua : The background of the game

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
        love.graphics.setColor(model.color)
        love.graphics.rectangle('fill', 0, 0, model.size.width,
                model.size.height)
    love.graphics.setCanvas()  -- reset the canvas
end

function View:draw(args)
    love.graphics.draw(self.canvas, args)
end

return View
