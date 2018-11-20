-- views/Console.lua : View for Console model

local log = require('log')
local View = require('views.View')
local view = View:new()

function view:load(width, height, props)
    self.width = width or 1000
    self.height = height or 1000
    self._props = props
    self.canvas = love.graphics.newCanvas(width, height)
end

function view:draw(x, y)
    if self.canvas then
        log.debug('menu.view.draw: draw canvas')
        love.graphics.draw(self.canvas, x, y)
        love.graphics.print(self._parent:getValue() or 'Nothing', x, y)
    else
        error('attempting to draw view not loaded')
    end
end

return view
