-- views/MenuItem.lua : View for MenuItem model

local View = require('views.View')
local view = View:new()

function view:load(width, height, props)
    self.width = math.floor(width) or 1000
    self.height = math.floor(height) or 1000
    self._props = props

    self.item = {
        x = 0,
        y = 0,
        width = self.width,
        height = self.height,
        padding = {
            x = 10,
            y = 10,
        },
    }

    self.item.normal = {
        text = {
            font = globals.assets.fonts.menu,
            color = { 1, 1, 1, 1 },
            align = 'center',
        },
        background = {
            color = { 0.20, 0.20, 0.20, 1 },
        },
        border = {
            x = 2,
            y = 2,
            color = { 0.25, 0.25, 0.25, 1 },
        },
        canvas = love.graphics.newCanvas(self.item.width, self.item.height),
    }

    self.item.hover = {
        text = {
            font = globals.assets.fonts.menu,
            color = { 1, 1, 1, 1 },
            align = 'center',
        },
        background = {
            color = { 0.10, 0.10, 0.10, 1 },
        },
        border = {
            x = 3,
            y = 3,
            color = { 0.25, 0.25, 0.25, 1 },
        },
        canvas = love.graphics.newCanvas(self.width, self.height)
    }


    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setCanvas(self.item.normal.canvas)
        love.graphics.clear()

        love.graphics.setColor(self.item.normal.border.color)
        love.graphics.rectangle('fill', self.item.x, self.item.y,
                self.item.width, self.item.height)

        love.graphics.setColor(self.item.normal.background.color)
        love.graphics.rectangle('fill',
                self.item.x + self.item.normal.border.x,
                self.item.y + self.item.normal.border.y,
                self.item.width - 2 * self.item.normal.border.x,
                self.item.height - 2 * self.item.normal.border.y)

        love.graphics.setFont(self.item.normal.text.font)
        love.graphics.setColor(self.item.normal.text.color)
        love.graphics.printf(self._parent.label,
                self.item.padding.x,
                self.item.padding.y,
                self.item.width - 2 * self.item.padding.x,
                self.item.normal.text.align)
    love.graphics.setCanvas()

    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setCanvas(self.item.hover.canvas)
        love.graphics.clear()

        love.graphics.setColor(self.item.hover.border.color)
        love.graphics.rectangle('fill', self.item.x, self.item.y,
                self.item.width, self.item.height)

        love.graphics.setColor(self.item.hover.background.color)
        love.graphics.rectangle('fill',
                self.item.x + self.item.hover.border.x,
                self.item.y + self.item.hover.border.y,
                self.item.width - 2 * self.item.hover.border.x,
                self.item.height - 2 * self.item.hover.border.y)

        love.graphics.setFont(self.item.hover.text.font)
        love.graphics.setColor(self.item.hover.text.color)
        love.graphics.printf(self._parent.label,
                self.item.padding.x,
                self.item.padding.y,
                self.item.width - 2 * self.item.padding.x,
                self.item.hover.text.align)
    love.graphics.setCanvas()
end

function view:draw(x, y)
    if self._parent.isHighlighted then
        love.graphics.draw(self.item.hover.canvas, x, y)
    else
        love.graphics.draw(self.item.normal.canvas, x, y)
    end
end

return view
