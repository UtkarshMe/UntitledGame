-- views/Menu.lua : View for Menu model

local log = require('log')
local View = require('views.View')
local MenuItem = require('views.MenuItem')
local view = View:new()

function view:load(width, height, props)
    self.width = width or 1000
    self.height = height or 1000
    self._props = props

    for _,item in ipairs(self._parent.items) do
        log.debug('menu.view.load: load item: ' .. item.label)
        item.view = MenuItem:new(item)
        item.view:load(self.width / 5, self.height / 5)
    end

    self.canvas = love.graphics.newCanvas(width, height)
    log.debug('menu.view.load: set canvas')
    love.graphics.setCanvas(self.canvas)
        log.debug('menu.view.load: generate canvas')
        love.graphics.clear()
        love.graphics.setBackgroundColor(0, 1, 0, 1)  -- only in top level
        love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setCanvas()
end

function view:draw(x, y)
    if self.canvas then
        log.debug('menu.view.draw: draw canvas')
        love.graphics.draw(self.canvas, x, y)
        love.graphics.setColor(0, 0, 0, 1)
        local highlighted = self._parent:getHighlighted()
        for i,item in ipairs(self._parent.items) do
            if i == highlighted then
                item.view:draw(25, 20 * i)
            else
                item.view:draw(20, 20 * i)
            end
        end
    else
        error('attempting to draw view not loaded')
    end
end

return view
