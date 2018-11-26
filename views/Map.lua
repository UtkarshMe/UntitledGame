-- views/Map.lua : View for Map model

local View = require('views.View')
local view = View:new()

function view:load(width, height, props)
    self.width = math.floor(width) or 1000
    self.height = math.floor(height) or 1000
    self._props = props
    self.canvas = love.graphics.newCanvas(self.width, self.height)
    self.playerCanvas = love.graphics.newCanvas(self.width, self.height)

    self.mapArea = {
        x = 0,
        y = 0,
        width = 4 * globals.assets.tile.width,
        height = 4 * globals.assets.tile.height,
        scale = { x = 1, y = 1 },
    }

    love.graphics.setCanvas(self.canvas)
        love.graphics.clear()
        love.graphics.setBlendMode('alpha')
    love.graphics.setCanvas()  -- reset the canvas
end

function view:update()
    local size = self._parent:getSize()

    local mapWidth =
            globals.assets.tile.width * self.mapArea.scale.x * size.width
    local mapHeight =
            globals.assets.tile.height * self.mapArea.scale.y * size.height
    self.mapArea.x = (self.width - mapWidth) / 2
    self.mapArea.y = (self.height - mapHeight) / 2

    love.graphics.setCanvas(self.canvas)
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

    love.graphics.setBackgroundColor(0, 0, 0, 1)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(self.canvas, self.mapArea.x, self.mapArea.y, 0,
            self.mapArea.scale.x, self.mapArea.scale.y)

    local user = self._parent:getPosition('user')
    love.graphics.draw(globals.assets.images.user.tile,
            self.mapArea.x
            + (user[1] - 1) * globals.assets.tile.width * self.mapArea.scale.x,
            self.mapArea.y
            + (user[2] - 1) * globals.assets.tile.height * self.mapArea.scale.y,
            0, self.mapArea.scale.x, self.mapArea.scale.y)
end

return view
