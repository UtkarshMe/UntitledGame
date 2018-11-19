-- models/Model.lua : Abstract class for models

local Model = {}

function Model:new(parent)
    local obj = parent or { name = 'UnnamedModel' }

    self.__index = self
    return setmetatable(obj, self)
end


return Model
