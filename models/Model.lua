-- models/Model.lua : Abstract class for models

local Model = {}

function Model:new(parent)
    local obj = parent or { name = 'UnnamedModel' }

    self.__index = self
    return setmetatable(obj, self)
end

function Model:getName()
    return self.name or 'UnnamedModel'
end


return Model
