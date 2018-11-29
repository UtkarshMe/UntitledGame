-- views/Menu.lua : View for Menu model

local util = require('views.util')
local View = require('views.View')
local MenuItem = require('views.MenuItem')
local view = View:new()

function view:load(width, height, props)
    self.width = math.floor(width) or 800
    self.height = math.floor(height) or 600
    self._props = props

    self.menu = {
        width = 400,
        height = 400,
        items = {
            x = 100,
            y = 150,
            height = 45,
            width = 200,
            margin = {
                x = 10,
                y = 0,
            },
            data = {},
        }
    }

    self.menu.x = math.floor((self.width - self.menu.width) / 2)
    self.menu.y = math.floor((self.height - self.menu.height) / 2)

    for i,item in ipairs(self._parent.items) do
        item.view = MenuItem:new(item)
        item.view:load(self.menu.items.width, self.menu.items.height, props)
        self.menu.items.data[i] = {
            x = self.menu.x + self.menu.items.x,
            y = self.menu.y + self.menu.items.y
                    + (i - 1) * self.menu.items.height
                    + (i - 1) * self.menu.items.margin.x,
            width = self.menu.items.width,
            height = self.menu.items.height,
        }
    end

    globals.game.event.add('Menu', 'mousepress', function(_, args)
        local x, y = unpack(args)
        for i,item in ipairs(self.menu.items.data) do
            if util.is_over({ x = x, y = y }, item) then
                self._parent.items[i]:getTarget()()
            end
        end
    end)

    self.canvas = love.graphics.newCanvas(self.width, self.height)
end

function view:draw(x, y)
    local mouse = {}
    mouse.x, mouse.y = globals.scaleMouse(love.mouse.getPosition())

    for i,item in ipairs(self.menu.items.data) do
        if util.is_over(mouse, item) then
            self._parent:setHighlighted(i)
        end
    end

    love.graphics.setBackgroundColor(0, 0, 0, 1)  -- only in top level
    love.graphics.clear()
    if self.canvas then
        love.graphics.draw(self.canvas, x, y)
        love.graphics.setColor(1, 1, 1, 1)
        for i,item in ipairs(self._parent.items) do
            item.view:draw(self.menu.items.data[i].x, self.menu.items.data[i].y)
        end
    else
        error('attempting to draw view not loaded')
    end
end

return view
