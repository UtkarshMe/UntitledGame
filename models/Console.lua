-- models/Console.lua : The model for console for user to enter script

local Model = require('models.Model')
local model = Model:new({ name = "Console", value = nil})

function model:updateValue(newValue)
    self.value = newValue
end

function model:getValue()
    return self.value
end

return model
