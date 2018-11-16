-- models/Map.lua : The current game map

local mapPrefix = 'data/maps/'
local Map = {}

function Map:init()
    self.size = { width = 0, height = 0 }
end

function Map:load(mapName)
    local map = require(mapPrefix .. mapName)

    self.size = map.size
    self.components = map.components
    self.data = map.data
end

return Map
