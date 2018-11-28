-- views/Map.lua : View for Map model

local animate = require('animate')
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
        user = {
            animate = animate:new({ speed = 2, factor = 2 }),
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
        canvas = love.graphics.newCanvas(),
        text = 'story not found',
        animate = animate:new({ speed = 10, loop = false }),
        padding = {
            x = 20,
            y = 20,
        },
    }

    self.console = {
        x = 0,
        y = self.mapPeak.y + self.mapPeak.height,
        width = self.width,
        height = math.floor(self.height * 0.25),
        font = love.graphics.newFont(20),
        cursor = animate:new(),
        padding = {
            x = 50,
            y = 50,
        },
    }
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

    self.story.text = self._parent:getMap().story or self.story.text
end

function view:draw()
    local user = self._parent:getPosition('user')
    local userOnMap = {
        x = (user[1] - self.mapPeak.tiles.offset.x) * globals.assets.tile.width
                + self.mapPeak.x,
        y = (user[2] - self.mapPeak.tiles.offset.y) * globals.assets.tile.height
                + self.mapPeak.y,
    }

    love.graphics.setBackgroundColor(0, 0, 0, 1)
    love.graphics.setColor(1, 1, 1, 1)

    -- map peak
    love.graphics.draw(self.mapPeak.canvas, self.mapPeak.x, self.mapPeak.y)
    self.mapPeak.user.animate:jump(globals.assets.images.user.tile,
            userOnMap.x, userOnMap.y)

    -- story
    love.graphics.setFont(self.console.font)
    love.graphics.printf(self.story.animate:teletype(self.story.text),
            self.story.x + self.story.padding.x,
            self.story.y + self.story.padding.y,
            self.story.width, self.story.align)

    -- console
    love.graphics.setFont(self.console.font)
    love.graphics.printf(self._parent.console:getValue()
            .. self.console.cursor:blinkText('_'),
            self.console.x + self.console.padding.x,
            self.console.y + self.console.padding.y,
            self.console.width)
end

return view
