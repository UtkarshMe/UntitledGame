-- views/Map.lua : View for Map model

local View = require('views.View')
local view = View:new()

function view:load()
    self.canvas = love.graphics.newCanvas()
    love.graphics.setCanvas(self.canvas)
        love.graphics.clear()
        love.graphics.setBlendMode('alpha')
    love.graphics.setCanvas()  -- reset the canvas
end

function view:update()
    love.graphics.setCanvas(self.canvas)
        love.graphics.setColor(0, 0, 0, 1)
        for x=1,#self._parent.map.data do
            for y=1,#self._parent.map.data[x] do
                love.graphics.print(
                        self._parent.map.components[self._parent:getTile(x, y)],
                        x * 50, y * 50)
            end
        end
    love.graphics.setCanvas()  -- reset the canvas
end

function view:draw(x, y)
    love.graphics.draw(self.canvas, x, y)
    local user = self._parent:getPosition('user')
    love.graphics.print('pl', user[1] * 50, user[2] * 50)
end

return view
