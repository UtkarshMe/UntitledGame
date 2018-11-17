local State = require('models.states.State')

describe('State', function()
    local state = nil
    local cb1 = function(args) return unpack(args) end
    local cb2 = function(args) return not unpack(args) end

    before_each(function()
        state = State:new('label')
    end)

    after_each(function()
        state = nil
    end)

    it('has a name', function()
        assert.is_same(state.name, 'label')
    end)

    it('can add events', function()
        state:addEvent('event1', cb1)
        state:addEvent('event2', nil)
    end)

    it('can check if event is handled', function()
        assert.is_false(state:canHandleEvent('event1'))
        state:addEvent('event1', cb1)
        assert.is_true(state:canHandleEvent('event1'))
    end)

    it('can handle known events', function()
        state:addEvent('event1', cb1)
        assert.is_true(state:handleEvent('event1', { true }))
        assert.is_false(state:handleEvent('event1', { false }))
    end)

    it('can remove events', function()
        state:addEvent('event1', cb1)
        assert.is_true(state:handleEvent('event1', { true }))
        state:removeEvent('event1')
        assert.has_error(function() state:handleEvent('event1', { true }) end)
    end)

    it('can replace events', function()
        state:addEvent('event1', cb1)
        assert.is_true(state:handleEvent('event1', { true }))
        state:replaceEvent('event1', cb2)
        assert.is_false(state:handleEvent('event1', { true }))
    end)

    it('fails to handle unknown events', function()
        assert.has_error(function() state:handleEvent('event1', { true }) end)
    end)

    it('fails on replacing/removing unknown event', function()
        assert.has_error(function() state:removeEvent('event1') end)
    end)

    it('fails on adding new event of same name', function()
        state:addEvent('event1', cb1)
        assert.has_error(function() state:addEvent('event1', cb2) end)
    end)
end)
