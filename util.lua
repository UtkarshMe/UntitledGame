local Util = {}

function Util.load(component, props)
    local obj = { name = component }

    obj.model = require('models.' .. component):new(obj)
    obj.view = require('views.' .. component):new(obj, props)
    obj.controller = require('controllers.' .. component):new(obj)

    obj.view:load()

    return obj
end

return Util
