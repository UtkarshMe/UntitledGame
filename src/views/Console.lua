-- views/Console.lua : View for Console model (now obsolete)

local View = require('views.View')
local util = require('views.util')
local view = View:new()

function view:load(width, height, props)
    self.width = math.floor(width) or 1000
    self.height = math.floor(height) or 1000
    self._props = props
    self.canvas = love.graphics.newCanvas(self.width, self.height)

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

    self.buttons = {
        submit = {
            x = self.console.x + self.console.width + 50,
            y = self.console.y,
            width = 150,
            height = 50,
            cornerRadius = 3,
            padding = {
                x = 10,
                y = 10,
            },
            font = self.console.font,
            value = 'Submit',
            color = {
                bg      = { 1.00, 0.00, 0.00, 1.0 },
                text    = { 0.00, 1.00, 1.00, 1.0 },
                border  = { 1.00, 1.00, 1.00, 1.0 },
            },
        },
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

        for _,button in pairs(self.buttons) do
            love.graphics.setLineWidth(1)
            love.graphics.setColor(button.color.border)
            love.graphics.rectangle('line', button.x, button.y,
                    button.width, button.height,
                    button.cornerRadius, button.cornerRadius, 100)

            love.graphics.setFont(button.font)
            love.graphics.print(button.value, button.x + button.padding.x,
                    button.y + button.padding.y)
        end

    love.graphics.setCanvas()

    globals.game.event.add('Console', 'mousepress', function(_, args)
        local x, y = unpack(args)
        if util.is_over({x = x, y = y}, self.buttons.submit) then
            globals.game.event.push('submit')
        end
    end)
end

function view:draw(x, y)
    if not self.canvas then
        error('attempting to draw view not loaded')
        return
    end

    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(self.canvas, x, y)
    love.graphics.setBackgroundColor(0, 0, 0, 1)
    love.graphics.setFont(self.console.font)
    love.graphics.printf(
            {
                self.console.textColor, self._parent:getValue(),
                self.console.cursorColor, '_',
            },
            self.console.x + self.console.padding.x,
            self.console.y + self.console.padding.y,
            self.console.width - 2 * self.console.padding.y)

    love.graphics.print(self._parent:getError() or '')

end

return view
