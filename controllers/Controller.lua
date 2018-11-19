-- controllers/Controller.lua : Abstract class for controllers

local log = require('log')
local Controller = {
    name = 'Controller'
}

function Controller:new(parent)
    local obj = {
        _parent = parent or { name = 'Controller' },
        events = {},
    }

    setmetatable(obj, self)
    self.__index = self
    return obj
end

function Controller:addEvent(eventName, callback)
    if self:canHandleEvent(eventName) then
        error(self._parent.name .. '.addEvent: event "' .. eventName ..
                '" already exists. Use replaceEvent')
    else
        log.debug(self._parent.name .. '.addEvent: Adding event "' ..
                eventName .. '"')
        self[eventName] = callback
    end
end

function Controller:removeEvent(eventName)
    if self:canHandleEvent(eventName) then
        self[eventName] = nil
    else
        error(self._parent.name .. '.removeEvent: cannot remove event "' ..
                eventName ..  '" which does not exist.')
    end
end

function Controller:replaceEvent(eventName, callback)
    self:removeEvent(eventName)
    self:addEvent(eventName, callback)
end

function Controller:handleEvent(eventName, args)
    if self:canHandleEvent(eventName) then
        return self[eventName](self, args)
    else
        error(self._parent.name .. '.handleEvent: event "' .. eventName ..
                '" does not exist.')
    end
end

function Controller:canHandleEvent(eventName)
    return self[eventName] ~= nil
end

return Controller
