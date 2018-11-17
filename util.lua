local Util = {}

function Util.loadComponent(component, props)
    local width, height = props.screen.width, props.screen.height

    local obj = {
        model = require('models.'..component),
        view = require('views.'..component)
    }

    obj.model:init(width, height)
    obj.view:init(obj.model)

    return obj
end

return Util
