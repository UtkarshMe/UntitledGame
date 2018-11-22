-- models/Console.lua : The model for console for user to enter script

local Model = require('models.Model')
local model = Model:new({ name = "Console", value = ''})

function model:updateValue(newValue)
    self.value = newValue or ''
end

function model:appendValue(value)
    self.value = (self.value or '') .. value
end

function model:getValue()
    return self.value or ''
end

return model
