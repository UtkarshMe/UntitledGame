-- assets.lua : Images and sounds for the game

local log = require('log')
local assets = {
    images = {},
    sounds = {},
}

function assets.load()
    log.debug('assets.init: loading tilesets')

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
end

return assets
