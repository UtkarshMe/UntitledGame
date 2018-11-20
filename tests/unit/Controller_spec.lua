require('tests.unit.helper')
local Controller = require('controllers.Controller')

describe('Controller', function()
    local controller = nil
    local cb1 = function(_, args) return unpack(args) end
    local cb2 = function(_, args) return not unpack(args) end

    before_each(function()
        controller = Controller:new()
    end)

    after_each(function()
        controller = nil
    end)

    it('has a name', function()
        assert.is_same(controller.name, 'Controller')
    end)

    it('can add events', function()
        controller:addEvent('event1', cb1)
        controller:addEvent('event2', nil)
    end)

    it('can check if event is handled', function()
        assert.is_false(controller:canHandleEvent('event1'))
        controller:addEvent('event1', cb1)
        assert.is_true(controller:canHandleEvent('event1'))
    end)

    it('can handle known events', function()
        controller:addEvent('event1', cb1)
        assert.is_true(controller:handleEvent('event1', { true }))
        assert.is_false(controller:handleEvent('event1', { false }))
    end)

    it('can remove events', function()
        controller:addEvent('event1', cb1)
        assert.is_true(controller:handleEvent('event1', { true }))
        controller:removeEvent('event1')
        assert.has_error(function()
            controller:handleEvent('event1', { true })
        end)
    end)

    it('can replace events', function()
        controller:addEvent('event1', cb1)
        assert.is_true(controller:handleEvent('event1', { true }))
        controller:replaceEvent('event1', cb2)
        assert.is_false(controller:handleEvent('event1', { true }))
    end)

    it('fails to handle unknown events', function()
        assert.has_error(function()
            controller:handleEvent('event1', { true })
        end)
    end)

    it('fails on replacing/removing unknown event', function()
        assert.has_error(function() controller:removeEvent('event1') end)
    end)

    it('fails on adding new event of same name', function()
        controller:addEvent('event1', cb1)
        assert.has_error(function() controller:addEvent('event1', cb2) end)
    end)
end)
