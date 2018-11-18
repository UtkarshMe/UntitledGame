local Util = {}

function Util.load(component, props)
    local Model = require('models.' .. component)
    --TODO: --local Model = require('models.' .. component):new(obj)
    local View = require('views.' .. component)
    local Controller = require('controllers.' .. component)
    local obj = {}

    obj.name = component
    obj.model = Model:new(obj)
    obj.view = View:new(obj, props)
    obj.controller = Controller:new(obj)

    obj.view:load()

    return obj
end

return Util
