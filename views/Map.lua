-- views/Map.lua : View for Map model

local View = require('views.View')
local view = View:new()

function view:load(width, height, props)
    self.width = math.floor(width) or 1000
    self.height = math.floor(height) or 1000
    self._props = props

    self.mapArea = {
        x = 0,
        y = 0,
        width = self.width,
        height = math.floor(self.height * 0.75),
    }

    self.console = {
        x = 0,
        y = self.mapArea.x + self.mapArea.height,
        width = self.width,
        height = math.floor(self.height * 0.25),
        font = love.graphics.newFont(20),
    }

end

function view:update()
    local size = self._parent:getSize()

    self.mapArea.canvas = love.graphics.newCanvas()
    love.graphics.setCanvas(self.mapArea.canvas)
        love.graphics.setColor(1, 1, 1, 1)
        for x=1,size.width do
            for y=1,size.height do
                local tile = self._parent:getTile(x, y)
                local tileName = self._parent.map.components[tile]
                love.graphics.draw(globals.assets.images[tileName].tile,
                        (x - 1) * globals.assets.tile.width,
                        (y - 1) * globals.assets.tile.height)
            end
        end
    love.graphics.setCanvas()  -- reset the canvas
end

function view:draw()
    local user = self._parent:getPosition('user')
    local userOnMap = {
        x = (user[1] - 1) * globals.assets.tile.width,
        y = (user[2] - 1) * globals.assets.tile.height
    }

    love.graphics.setBackgroundColor(0, 0, 0, 1)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.clear()

    -- map area
    love.graphics.draw(self.mapArea.canvas, 0, 0)

    -- user tile
    love.graphics.draw(globals.assets.images.user.tile, userOnMap.x,
            userOnMap.y)

    -- script console
    love.graphics.setFont(self.console.font)
    love.graphics.printf(self._parent.console:getValue(), self.console.x,
            self.console.y, self.console.width)
end

return view
