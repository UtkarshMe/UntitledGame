-- assets.lua : Images and sounds for the game

local log = require('log')
local assets = {
    images = {},
    sounds = {},
    fonts = {},
}

function assets.load()
    log.debug('assets.init: loading tilesets')

    -- tileset stuff here

    local tileset = {
        terrain = love.graphics.newImage('assets/images/terrain_atlas.png'),
        base_out = love.graphics.newImage('assets/images/base_out_atlas.png'),
        width = 1024, height = 1024,
    }

    assets.tile = { width = 32, height = 32 }

    assets.images = {
        grass = {
            tileset = tileset.terrain,
            tiles = {
                { 00, 00, 736, 160, 32 },
            }
        },
        wall = {
            tileset = tileset.terrain,
            tiles = {
                { 00, 00, 672, 704, 32 },
            },
        },
        box_closed = {
            tileset = tileset.base_out,
            tiles = {
                { 00, 00, 672, 544, 32 },
            },
        },
        exit = {
            tileset = tileset.terrain,
            tiles = {
                { 00, 00, 448, 612, 32},  -- wooden stairs
                --{ 00, 00, 736, 160, 32 },  -- grass
            },
        },
        user = {
            tileset = tileset.terrain,
            tiles = {
                { 00, 00, 832, 1024 - 32, 32},  -- mushroom
            },
        },
        tomato = {
            tileset = tileset.terrain,
            tiles = {
                { 00, 00, 736, 160, 32 },  -- grass
                { 00, 00, 384, 768, 32 },
            }
        },
    }

    for id,value in pairs(assets.images) do
        local canvas = love.graphics.newCanvas(assets.tile.width,
                assets.tile.height)
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.setCanvas(canvas)
            for i=1, #value.tiles do
                local tile = value.tiles[i]
                love.graphics.draw(value.tileset,
                        love.graphics.newQuad(tile[3], tile[4],
                                tile[5], tile[5],
                                tileset.width, tileset.height),
                        tile[1], tile[2])
            end
        love.graphics.setCanvas()
        assets.images[id].tile = canvas
    end


    -- fonts stuff here
    assets.fonts = {
        default = love.graphics.newFont('assets/fonts/gravity.ttf', 15),
        console = love.graphics.newFont('assets/fonts/monogram.ttf', 25),
        story = love.graphics.newFont('assets/fonts/gravity.ttf', 17),
        menu = love.graphics.newFont('assets/fonts/gravity.ttf', 16),
        banner = love.graphics.newFont('assets/fonts/gravity.ttf', 50),
        button = love.graphics.newFont('assets/fonts/gravity.ttf', 20),
    }


    -- sounds stuff here
    assets.sounds = {
        key = love.audio.newSource('assets/sounds/key.ogg', 'static'),
        click = love.audio.newSource('assets/sounds/click.ogg', 'static'),
        step = love.audio.newSource('assets/sounds/step.ogg', 'static'),
        win = love.audio.newSource('assets/sounds/win.ogg', 'static'),
        lose = love.audio.newSource('assets/sounds/lose.ogg', 'static'),
        message = love.audio.newSource('assets/sounds/message.ogg', 'static'),
        loops = {
            start = love.audio.newSource('assets/sounds/loop1.wav', 'stream'),
            game = love.audio.newSource('assets/sounds/loop2.wav', 'stream'),
            run = love.audio.newSource('assets/sounds/loop2.wav', 'stream'),
        }
    }

    assets.sounds.loops.start:setLooping(true)
    assets.sounds.loops.game:setLooping(true)

end

return assets
