-- views/View.lua : Abstract class for views

local View = {}

function View:new(parent, props)
    local obj = {
        _parent = parent,
        canvas = nil,
        props = props,
    }

    self.__index = self
    return setmetatable(obj, self)
end

-- load things which are not gonna change (like images, etc.) here
function View.load()
    print('View not implemented')
end

-- update the canvas
function View.update()
    print('View not implemented')
end

-- load the canvas
function View.draw()
    print('View not implemented')
end


return View
