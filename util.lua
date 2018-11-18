local Util = {}

function Util.load(component, props)
    local obj = require('models.' .. component):new()
    obj.view = require('views.' .. component):new(obj, props)
    obj.view:load()
    obj.controller = require('controllers.' .. component):new(obj)
    return obj
end

return Util
