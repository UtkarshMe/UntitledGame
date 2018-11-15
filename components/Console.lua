-- components/Console.lua : The console on which the user writes the code

local Console = {
    size = { width = 0, height = 0 },
    canvas = nil,                       -- cached static canvas
}


function Console:new(width, height)
    local newObj = {
        size = { width = width, height = height },
        canvas = love.graphics.newCanvas(),
        value = [[ loop forward endloop ]],
    }

    self.__index = self
    return setmetatable(newObj, self)
end

function Console:update()
    -- TODO
    return self
end


return Console
