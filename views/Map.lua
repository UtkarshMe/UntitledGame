-- views/Map.lua : View for Map model

local View = require('views.View')
local view = View:new()

function view:load(width, height, props)
    self.width = math.floor(width) or 800
    self.height = math.floor(height) or 600
    self._props = props

    self.story = {
        x = 0,
        y = 0,
        width = self.width,
        height = self.height / 3,
        canvas = love.graphics.newCanvas()
    }

    self.mapArea = {
        x = 0,
        y = self.story.y + self.story.height,
        width = globals.assets.tile.width * 15,
        height = globals.assets.tile.height * 15,
        canvas = love.graphics.newCanvas()
    }

    self.console = {
        x = self.mapArea.x + self.mapArea.width,
        y = self.mapArea.y,
        width = self.width - self.mapArea.width,
        height = math.floor(self.height * 0.25),
        font = love.graphics.newFont(20),
    }

    self.timer = 'mapview'
    globals.timer.track(self.timer)
end

function view:update()
    local size = self._parent:getSize()

    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setCanvas(self.story.canvas)
        love.graphics.setFont(self.console.font)
        love.graphics.clear()
        love.graphics.printf(self._parent.map.story, 0, 0, self.story.width,
                'center')
    love.graphics.setCanvas()

    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setCanvas(self.mapArea.canvas)
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
    globals.timer.start(self.timer)
end

function view:draw()
    local user = self._parent:getPosition('user')
    local userOnMap = {
        x = (user[1] - 1) * globals.assets.tile.width + self.mapArea.x,
        y = (user[2] - 1) * globals.assets.tile.height + self.mapArea.y,
    }
    local timer = math.floor(2 * globals.timer.getTime(self.timer))
    local cursor = '_'

    love.graphics.setBackgroundColor(0, 0, 0, 1)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(self.story.canvas, self.story.x, self.story.y)
    love.graphics.draw(self.mapArea.canvas, self.mapArea.x, self.mapArea.y)

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
