-- views/Map.lua : View for Map model

local animate = require('animate')
local util = require('views.util')
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
            x = 9,
            y = 9,
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
        padding = {
            x = 10,
            y = 10,
        },
        user = {
            animate = animate:new({ speed = 5, factor = 2 }),
        },
    }
    self.mapPeak.width = self.mapPeak.tiles.x * globals.assets.tile.width
            + self.mapPeak.padding.x
    self.mapPeak.height = self.mapPeak.tiles.y * globals.assets.tile.height
            + self.mapPeak.padding.y
    self.mapPeak.canvas = love.graphics.newCanvas(self.mapPeak.width
            - self.mapPeak.padding.x,
            self.mapPeak.height - self.mapPeak.padding.y)

    self.story = {
        x = self.mapPeak.x + self.mapPeak.width,
        y = 0,
        width = self.width - self.mapPeak.x - self.mapPeak.width,
        height = self.mapPeak.height,
        align = 'left',
        canvas = love.graphics.newCanvas(),
        text = 'story not found',
        font = globals.assets.fonts.story,
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
        height = self.height - self.mapPeak.y - self.mapPeak.height,
        editor = {
            x = 0,
            y = 0,
            width = self.width - 200,
            height = self.height - self.mapPeak.y - self.mapPeak.height,
            cursor = animate:new({ speed = 2 }),
            color = { 0.20, 0.20, 0.20, 1 },
            padding = {
                x = 20,
                y = 20,
            },
            margin = {
                x = 10,
                y = 10,
            },
            border = {
                outer = {
                    width = 2,
                    height = 2,
                    color = { 0.25, 0.25, 0.25, 1 },
                },
                inner = {
                    width = 3,
                    height = 3,
                    color = { 0.30, 0.30, 0.30, 1 },
                },
                width = 5,
                height = 5,
            },
            input = {
                font = globals.assets.fonts.console,
                color = {
                    text = { 1, 1, 1, 1 },
                    cursor = { 0.7, 0.7, 0.7, 1 },
                },
            },
        },
        buttons = {
            height = 50,
            padding = {
                x = 10,
                y = 10,
            },
            data = {
                {
                    label = 'Run',
                    callback = function()
                        self._parent.console:setMessage('Running...')
                        globals.game.event.push('submit')
                    end
                },
                {
                    label = 'Reset',
                    callback = function()
                        self._parent.console:setMessage()
                        globals.game.event.push('update', { '' })
                    end
                },
                {
                    label = 'Quit',
                    callback = function()
                        self._parent.console:setMessage()
                        love.audio.stop(globals.assets.sounds.loops.game)
                        love.audio.play(globals.assets.sounds.loops.start)
                        globals.game.state:push('Menu')
                    end
                },
            },
            margin = {
                x = 10,
                y = 10,
            },
            font = globals.assets.fonts.button,
            color = {
                background = { 0.20, 0.20, 0.20, 1},
                font =       { 0.80, 0.80, 0.80, 1 },
                border = {
                    outer = { 0.25, 0.25, 0.25, 1 },
                    inner = { 0.30, 0.30, 0.30, 1 },
                }
            },
            align = 'center',
        },
        message = {
            font = globals.assets.fonts.default,
            color = { 1, 0, 0, 1 },
            margin = {
                x = 0,
                y = 10,
            },
        },
    }

    self.console.editor.width = self.console.editor.width
            - 2 * self.console.editor.margin.x
    self.console.editor.height = self.console.editor.height
            - 2 * self.console.editor.margin.y

    self.console.buttons.x = self.console.editor.x + self.console.editor.width
            + 2 * self.console.editor.margin.x
    self.console.buttons.y = self.console.editor.y
    self.console.buttons.width = self.width - self.console.editor.width
            - 2 * self.console.editor.margin.x

    self.console.message.x = self.console.buttons.x
    self.console.message.y = self.console.y + self.console.message.margin.y
            + #self.console.buttons.data
                * (self.console.buttons.height + self.console.buttons.margin.y)
    self.console.message.width = self.console.buttons.width

    self.console.canvas = love.graphics.newCanvas(self.console.width,
            self.console.height)
    self.console.editor.canvas = love.graphics.newCanvas(
            self.console.editor.width, self.console.editor.height)

    local i = 1
    for id,_ in pairs(self.console.buttons.data) do
        self.console.buttons.data[id].x = self.console.buttons.x
        self.console.buttons.data[id].y = self.console.buttons.y
                + (i - 1) * self.console.buttons.height
                + i * self.console.buttons.margin.y
        self.console.buttons.data[id].width = self.console.buttons.width
                - self.console.buttons.margin.x
        self.console.buttons.data[id].height = self.console.buttons.height
        i = i + 1
    end

    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setCanvas(self.console.editor.canvas)
        -- border outer
        love.graphics.setColor(self.console.editor.border.outer.color)
        love.graphics.rectangle('fill',
                self.console.editor.x, self.console.editor.y,
                self.console.editor.width, self.console.editor.height)

        -- border inner
        love.graphics.setColor(self.console.editor.border.inner.color)
        love.graphics.rectangle('fill',
                self.console.editor.border.outer.width,
                self.console.editor.border.outer.height,
                self.console.editor.width
                    - 2 * self.console.editor.border.outer.width,
                self.console.editor.height
                    - 2 * self.console.editor.border.outer.height)

        -- padded area
        love.graphics.setColor(self.console.editor.color)
        love.graphics.rectangle('fill', self.console.editor.border.width,
                self.console.editor.border.height,
                self.console.editor.width
                    - 2 * self.console.editor.border.width,
                self.console.editor.height
                    - 2 * self.console.editor.border.height)
    love.graphics.setCanvas()

    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setCanvas(self.console.canvas)
        -- editor
        love.graphics.draw(self.console.editor.canvas,
                self.console.editor.margin.x,
                self.console.editor.margin.y)

        -- buttons
        for _,button in ipairs(self.console.buttons.data) do
            love.graphics.setColor(self.console.buttons.color.border.outer)
            love.graphics.rectangle('fill', button.x, button.y,
                    button.width, button.height)

            love.graphics.setColor(self.console.buttons.color.border.inner)
            love.graphics.rectangle('fill', button.x + 2, button.y + 2,
                    button.width - 4, button.height - 4)

            love.graphics.setColor(self.console.buttons.color.background)
            love.graphics.rectangle('fill', button.x + 5, button.y + 5,
                    button.width - 10, button.height - 10)

            love.graphics.setColor(self.console.buttons.color.font)
            love.graphics.setFont(self.console.buttons.font)
            love.graphics.printf(button.label,
                    button.x + self.console.buttons.padding.x,
                    button.y + self.console.buttons.padding.y,
                    self.console.buttons.width
                        - 2 * self.console.buttons.padding.x
                        - 2 * self.console.buttons.margin.x,
                    self.console.buttons.align)
        end
    love.graphics.setCanvas()

    globals.game.event.add('Map', 'mousepress', function(_, args)
        local x, y = unpack(args)
        local offset = {
            x = self.console.x,
            y = self.console.y,
        }
        for _,button in pairs(self.console.buttons.data) do
            if util.is_over({ x = x, y = y }, button, offset) then
                love.audio.play(globals.assets.sounds.click)
                button.callback()
                break
            end
        end
    end)

    love.keyboard.setKeyRepeat(true)  -- allow pressing down keys
end

function view:reset()
    self.story.animate:replay()
end

function view:update()
    local size = self._parent:getSize()
    local user = self._parent:getPosition('user')

    self.mapPeak.tiles.offset = {
        x = math.min(
                math.max(1, user[1] - math.floor(self.mapPeak.tiles.x / 2)),
                size.width - self.mapPeak.tiles.x + 1
            ),
        y = math.min(
                math.max(1, user[2] - math.floor(self.mapPeak.tiles.y / 2)),
                size.height - self.mapPeak.tiles.y + 1
            ),
    }

    self.mapPeak.data.width = globals.assets.tile.width * size.width
    self.mapPeak.data.height = globals.assets.tile.height * size.height

    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setCanvas(self.mapPeak.canvas)
        love.graphics.clear()
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

    -- map peak
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(self.mapPeak.canvas,
            self.mapPeak.x + self.mapPeak.padding.x,
            self.mapPeak.y + self.mapPeak.padding.y)
    self.mapPeak.user.animate:jump(globals.assets.images.user.tile,
            userOnMap.x + self.mapPeak.padding.x,
            userOnMap.y + self.mapPeak.padding.y)

    -- story
    love.graphics.setFont(self.story.font)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.printf(self.story.animate:teletype(self.story.text),
            self.story.x + self.story.padding.x,
            self.story.y + self.story.padding.y,
            self.story.width, self.story.align)

    -- console
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(self.console.canvas, self.console.x, self.console.y)

    -- message
    love.graphics.setFont(self.console.message.font)
    love.graphics.setColor(self.console.message.color)
    love.graphics.printf(self._parent.console:getMessage(),
            self.console.message.x,
            self.console.message.y,
            self.console.message.width)


    -- editor area
    local cursor = self._parent.console:getCursor()
    local value = self._parent.console:getValue()
    local text = {
        string.sub(value, 1, cursor) or '',
        '_',
        string.sub(value, cursor + 1) or ''
    }

    -- print the text in background color and then print cursor. this ensures
    -- the cursor is printed at the position even for non-monospaced fonts. and
    -- then, print the whole thing in text color
    love.graphics.setFont(self.console.editor.input.font)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.printf({
                self.console.editor.color, text[1],
                self.console.editor.input.color.cursor,
                    self.console.editor.cursor:blinkText('_')
            },
            self.console.x + self.console.editor.x
                + self.console.editor.margin.x
                + self.console.editor.padding.x,
            self.console.y + self.console.editor.y
                + self.console.editor.margin.y
                + self.console.editor.padding.y,
            self.console.editor.width)
    love.graphics.printf({
                self.console.editor.input.color.text,
                text[1] .. text[3]
            },
            self.console.x + self.console.editor.x
                + self.console.editor.margin.x
                + self.console.editor.padding.x,
            self.console.y + self.console.editor.y
                + self.console.editor.margin.y
                + self.console.editor.padding.y,
            self.console.editor.width)
end

return view
