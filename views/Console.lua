-- views/Console.lua : View for Console model

local View = require('views.View')
local view = View:new()

function view:load(width, height, props)
    self.width = width or 1000
    self.height = height or 1000
    self._props = props
    self.canvas = love.graphics.newCanvas(width, height)

    self.console = {
        x = 50,
        y = 50,
        width = self.width - 100 - 200,
        height = self.height - 100 - 10,
        cornerRadius = 10,
        padding = {
            x = 20,
            y = 20,
        },
        lineWidth = 20,
        font = love.graphics.newFont(20),
        bgColor     = { 0.01, 0.08, 0.01, 1.0 },
        borderColor = { 0.31, 0.80, 0.01, 1.0 },
        textColor   = { 0.30, 1.00, 0.10, 1.0 },
        cursorColor = { 0.30, 1.00, 0.10, 0.7 },
    }

    love.graphics.setCanvas(self.canvas)
        love.graphics.setLineWidth(self.console.lineWidth)
        love.graphics.setColor(self.console.borderColor)
        love.graphics.rectangle('line', self.console.x, self.console.y,
                self.console.width, self.console.height,
                self.console.cornerRadius, self.console.cornerRadius, 100)

        love.graphics.setColor(self.console.bgColor)
        love.graphics.rectangle('fill', self.console.x, self.console.y,
                self.console.width, self.console.height,
                self.console.cornerRadius, self.console.cornerRadius, 100)

    love.graphics.setCanvas()
end

function view:draw(x, y)
    if self.canvas then
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.draw(self.canvas, x, y)
        love.graphics.setBackgroundColor(0, 0, 0, 1)
        love.graphics.setFont(self.console.font)
        love.graphics.print(
                {
                    self.console.textColor, self._parent:getValue(),
                    self.console.cursorColor, '_',
                },
                self.console.x + self.console.padding.x,
                self.console.y + self.console.padding.y)
    else
        error('attempting to draw view not loaded')
    end
end

return view
