-- views/Map.lua : View for Map model

local View = require('views.View')
local view = View:new()

function view:load(width, height, props)
    self.width = math.floor(width) or 800
    self.height = math.floor(height) or 600
    self._props = props

    self.mapPeak = {
        x = 0,
        y = 0,
        tiles = {
            x = 5,
            y = 5,
            offset = {
                x = 0,
                y = 0,
            },
        },
        width = 0,
        height = 0,
        canvas = nil,
        data = {
            width = 0,
            height = 0,
        },
    }
    self.mapPeak.width = self.mapPeak.tiles.x * globals.assets.tile.width
    self.mapPeak.height = self.mapPeak.tiles.y * globals.assets.tile.height
    self.mapPeak.canvas = love.graphics.newCanvas(self.mapPeak.width,
            self.mapPeak.height)

    self.story = {
        x = self.mapPeak.x + self.mapPeak.width,
        y = 0,
        width = self.width - self.mapPeak.x - self.mapPeak.width,
        height = self.mapPeak.height,
        align = 'left',
        canvas = love.graphics.newCanvas()
    }

    self.console = {
        x = 0,
        y = self.mapPeak.y + self.mapPeak.height,
        width = self.width,
        height = math.floor(self.height * 0.25),
        font = love.graphics.newFont(20),
    }

    self.timer = 'mapview'
    globals.timer.track(self.timer)
end

function view:update()
    local size = self._parent:getSize()
    local user = self._parent:getPosition('user')

    self.mapPeak.tiles.offset = {
        x = math.max(0, user[1] - math.floor(self.mapPeak.tiles.x / 2)),
        y = math.max(0, user[2] - math.floor(self.mapPeak.tiles.y / 2)),
    }

    self.mapPeak.data.width = globals.assets.tile.width * size.width
    self.mapPeak.data.height = globals.assets.tile.height * size.height

    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setCanvas(self.story.canvas)
        love.graphics.setFont(self.console.font)
        love.graphics.clear()
        love.graphics.printf(self._parent.map.story, 0, 0, self.story.width,
                self.story.align)
    love.graphics.setCanvas()

    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setCanvas(self.mapPeak.canvas)
        for x=self.mapPeak.tiles.offset.x,size.width do
            for y=self.mapPeak.tiles.offset.y,size.height do
                local tile = self._parent:getTile(x, y)
                local tileName = self._parent.map.components[tile]
                love.graphics.draw(globals.assets.images[tileName].tile,
                        (x - self.mapPeak.tiles.offset.x)
                        * globals.assets.tile.width,
                        (y - self.mapPeak.tiles.offset.y)
                        * globals.assets.tile.height)
            end
        end
    love.graphics.setCanvas()  -- reset the canvas
    globals.timer.start(self.timer)
end

function view:draw()
    local user = self._parent:getPosition('user')
    local userOnMap = {
        x = (user[1] - self.mapPeak.tiles.offset.x)
                * globals.assets.tile.width + self.mapPeak.x,
        y = (user[2] - self.mapPeak.tiles.offset.y)
                * globals.assets.tile.height + self.mapPeak.y,
    }
    local timer = math.floor(2 * globals.timer.getTime(self.timer))
    local cursor = '_'

    local offset = {
        x = userOnMap.x - (self.mapPeak.width / 2),
        y = userOnMap.y - (self.mapPeak.height / 2),
    }

    love.graphics.setBackgroundColor(0, 0, 0, 1)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(self.story.canvas, self.story.x, self.story.y)
    love.graphics.draw(self.mapPeak.canvas, self.mapPeak.x, self.mapPeak.y)

    if timer == 0 then
        love.graphics.draw(globals.assets.images.user.tile, userOnMap.x,
                userOnMap.y - 1)
        cursor = '_'
    elseif timer == 1 then
        love.graphics.draw(globals.assets.images.user.tile, userOnMap.x,
                userOnMap.y)
        cursor = ''
    elseif timer == 2 then
        love.graphics.draw(globals.assets.images.user.tile, userOnMap.x,
                userOnMap.y)
        cursor = '_'

        globals.timer.reset(self.timer)
    end

    -- script console
    love.graphics.setFont(self.console.font)
    love.graphics.printf(self._parent.console:getValue() .. cursor,
            self.console.x, self.console.y, self.console.width)
end

return view
