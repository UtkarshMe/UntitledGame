-- components/components.lua : Module to initialize components

local Background = require('components/Background')
local Console = require('components/Console')

local Components = {}

function Components:init(props)
    Components.background = Background:new(props.screen.width,
            props.screen.height)

    Components.console = Console:new(props.screen.width / 2,
            props.screen.height / 2)
end

return Components
