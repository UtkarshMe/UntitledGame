-- models/Console.lua : The model for console for user to enter script

local Model = require('models.Model')
local model = Model:new({ name = "Console", value = ''})

function model:updateValue(newValue)
    self.value = newValue or ''
end

function model:appendValue(value)
    value:match "^%s*(.-)%s*$"  -- trim
    self.value = (self.value or '') .. value
end

function model:getValue()
    return self.value or ''
end

function model:setError(err)
    self.err = err
end

function model:getError()
    return self.err
end

return model
