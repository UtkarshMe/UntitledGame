-- models/Map.lua : The model for game map

local Model = require('models/Model')
local model = Model:new()
local mapPrefix = 'data/maps/'

function model:load(mapName)
    self.map = require(mapPrefix .. mapName)
    self.script = nil
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

function model:getComponent(id)
    return self.map.components[id]
end

function model:getUserPosition()
    return self.map.positions.user
end

function model:setUserPosition(position)
    local size = self.map.size
    if position[1] > size.width or position[2] > size.height then
        error('Map.setUserPosition: position bigger than map size')
    elseif position[1] < 1 and position[2] < 1 then
        error('Map.setUserPosition: position smaller than 1')
    else
        self.map.positions.user = position
    end
end

return model
