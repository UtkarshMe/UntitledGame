-- models/MenuItem.lua : An entry in the menu

local Model = require('models.Model')
local model = Model:new()

function model:new(label, target)
    local obj = {
        label = label,
        target = target,
    }

    self.__index = self
    return setmetatable(obj, self)
end

return model
