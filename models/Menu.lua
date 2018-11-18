-- models/Menu.lua : Model for the menu shows at the start

local Model = require('models.Model')
local MenuItem = require('models.MenuItem')

local model = Model:new()

function model:new()
    local obj = {
        items = {
            MenuItem:new('New Game'),
            MenuItem:new('Load Game'),
            MenuItem:new('Save Game'),
            MenuItem:new('How to Play'),
            MenuItem:new('Exit'),
        },
    }

    self.__index = self
    return setmetatable(obj, self)
end

return model
