-- components/Console.lua : The console on which the user writes the code

local Console = {
    size = { width = 0, height = 0 },
    canvas = nil,                       -- cached static canvas
}


function Console:new(width, height)
    local newObj = {
        size = { width = width, height = height },
        value = nil,
    }

    self.__index = self
    return setmetatable(newObj, self)
end

function Console:setScript(script)
    self.value = script
end
function Console:getScript()
    return self.value
end

function Console:initCanvas()
    self.canvas = love.graphics.newCanvas()
end


return Console
