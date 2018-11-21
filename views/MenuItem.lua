-- views/MenuItem.lua : View for MenuItem model

local View = require('views.View')
local view = View:new()

function view:load(width, height, props)
    self.width = width
    self.height = height
    self._props = props

    self.canvas = love.graphics.newCanvas(self.width, self.height)
    love.graphics.setCanvas(self.canvas)
        love.graphics.clear()
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.print('menuItem: ' .. self._parent.label)
    love.graphics.setCanvas()
end

function view:draw(x, y)
    if self.canvas then
        love.graphics.draw(self.canvas, x, y)
    else
        error('attempting to draw view not loaded')
    end
end

return view
