-- components/components.lua : Module to initialize components

local Background = require('components.Background')
local Console = require('components.Console')

local Components = {}

function Components:init(props)
    local width, height = props.screen.width, props.screen.height

    self.background = Background:new(width, height)
    self.background:initCanvas()

    self.console = Console:new(width / 2, height / 2)
    self.console:initCanvas()
end

return Components
