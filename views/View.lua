-- views/View.lua : Abstract class for views

local View = {}

function View:new(parent, props)
    local obj = {
        _parent = parent,
        canvas = love.graphics.newCanvas(),
        props = props,
    }

    self.__index = self
    return setmetatable(obj, self)
end

-- load things which are not gonna change (like images, etc.) here
function View.load()
end

-- update the canvas
function View.update()
end

-- load the canvas
function View.draw()
end


return View
