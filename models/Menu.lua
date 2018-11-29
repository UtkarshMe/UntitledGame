-- models/Menu.lua : Model for the menu shows at the start

local Model = require('models.Model')
local MenuItem = require('models.MenuItem')

local model = Model:new()

function model:new()
    local obj = {
        items = {},
        highlighted = 1
    }

    self.__index = self
    setmetatable(obj, self)

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

function model:getHighlighted()
    return self.highlighted
end

function model:setHighlighted(id)
    if id > #self.items or id < 1 then
        error('Menu.setHighlighted: id out of bounds')
    else
        self.items[self.highlighted].isHighlighted = false
        self.highlighted = id
        self.items[self.highlighted].isHighlighted = true
    end
end

return model
