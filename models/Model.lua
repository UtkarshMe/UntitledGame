-- models/Model.lua : Abstract class for models

local Model = {}

function Model:new(parent)
    local obj = {
        _parent = parent
    }

    self.__index = self
    return setmetatable(obj, self)
end


return Model
