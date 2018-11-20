-- models/Menu.lua : Model for the menu shows at the start

local Model = require('models.Model')
local MenuItem = require('models.MenuItem')

local model = Model:new()

function model:new()
    local obj = {
        items = {}
    }

    self.__index = self
    setmetatable(obj, self)

    obj:addItem('New Game', function()
        -- user "activates" button "new"
        globals.game.switch('console')
    end)
    obj:addItem('Load Game')
    obj:addItem('Save Game')
    obj:addItem('How to Play')
    obj:addItem('Exit')

    return obj
end

function model:addItem(label, callback)
    local id = #self.items + 1
    self.items[id] = MenuItem:new(label, callback)
    return id
end

function model:getItem(id)
    return self.items[id]
end

return model
