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
    if self.events[eventName] then
        print('addEvent: event ' .. eventName ..
                'already exists. Use replaceEvent')
    else
        self.events[eventName] = callback
    end
end

function State:removeEvent(eventName)
    self.events[eventName] = nil
end

function State:replaceEvent(eventName, callback)
    self:removeEvent(eventName)
    self:addEvent(eventName, callback)
end

function State:handleEvent(eventName, args)
    if self.events[eventName] then
        self.events[eventName](args)
    else
        print('handleEvent: event ' .. eventName ..
                ' does not exist. Use addEvent')
    end
end

return State
