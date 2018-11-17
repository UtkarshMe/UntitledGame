-- models/Map.lua : The model for game map

local Model = require('models/Model')
local model = Model:new(nil)
local mapPrefix = 'data/maps/'

function model:init()
    self.size = { width = 0, height = 0 }
end

function model:load(mapName)
    local map = require(mapPrefix .. mapName)

    self.size = map.size
    self.components = map.components
    self.data = map.data
end

function model:getTile(x, y)
    return self.data[y][x]
end

function model:setTile(x, y, tile)
    self.data[y][x] = tile
end

return model
