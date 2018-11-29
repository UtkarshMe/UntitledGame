-- models/MenuItem.lua : An entry in the menu

local Model = require('models.Model')
local model = Model:new()

function model:new(label, target)
    local obj = {
        label = label,
        target = target,
        isHighlighted = false,
    }

    self.__index = self
    return setmetatable(obj, self)
end

function model:getLabel()
    return self.label
end

function model:setLabel(label)
    self.label = label
end

function model:getTarget()
    return self.target
end

function model:setTarget(target)
    self.target = target
end

return model
