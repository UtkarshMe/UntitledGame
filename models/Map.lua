-- models/Map.lua : The model for game map

local Model = require('models/Model')
local model = Model:new(nil)
local mapPrefix = 'data/maps/'

function model:init()
    self.map = {
        size = { width = 0, height = 0 }
    }
end

function model:load(mapName)
    self.map = require(mapPrefix .. mapName)
end

function model:getSize()
    return self.map.size
end

function model:getMap()
    return self.map
end

function model:getTile(x, y)
    return self.map.data[y][x]
end

function model:setTile(x, y, tile)
    if self.map.components[tile] then
        self.map.data[y][x] = tile
    else
        error('No component for tile id "' .. tile .. '"')
    end
end

function model:getUserPosition()
    return self.map.positions.user
end

function model:setUserPosition(position)
    self.map.positions.user = position
end

return model
