-- models/Console.lua : The console on which the user writes the code

local Console = {
    size = { width = 0, height = 0 },
    canvas = nil,                       -- cached static canvas
}

function Console:init(width, height)
    self.size.width, self.size.height = width, height
end

function Console:setScript(script)
    self.value = script
end
function Console:getScript()
    return self.value
end

return Console
