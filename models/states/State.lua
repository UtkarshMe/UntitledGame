-- models/state/State.lua : Abstract class for various states

local State = {}

function State:new(name)
    local obj = {
        name = name,
        events = {},
    }

    self.__index = self
    return setmetatable(obj, self)
end

function State:addEvent(eventName, callback)
    if self:canHandleEvent(eventName) then
        error('addEvent: event "' .. eventName ..
                '" already exists. Use replaceEvent')
    else
        self.events[eventName] = callback
    end
end

function State:removeEvent(eventName)
    if self:canHandleEvent(eventName) then
        self.events[eventName] = nil
    else
        error('removeEvent: cannot remove event "' .. eventName ..
                '" which does not exist.')
    end
end

function State:replaceEvent(eventName, callback)
    self:removeEvent(eventName)
    self:addEvent(eventName, callback)
end

function State:handleEvent(eventName, args)
    if self:canHandleEvent(eventName) then
        return self.events[eventName](args)
    else
        error('handleEvent: event "' .. eventName ..
                '" does not exist. Use addEvent')
    end
end

function State:canHandleEvent(eventName)
    return self.events[eventName] ~= nil
end

return State
