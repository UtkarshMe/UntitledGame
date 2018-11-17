describe('state', function()

    local state = require('state')
    before_each(function()
        state:empty()
    end)

    it('is empty to begin with', function()
        assert.is_nil(state:current())
    end)

    it('can be pushed to', function()
        state:push('state1')
        assert.is_equal(state:current(), 'state1')
        state:push('state2')
        assert.is_equal(state:current(), 'state2')
    end)

    it('can be poped from', function()
        state:push('state1')
        state:push('state2')
        state:pop()
        assert.is_equal(state:current(), 'state1')
        state:pop()
        assert.is_nil(state:current())
    end)

    it('can be emptied', function()
        state:push('state1')
        state:push('state2')
        state:empty()
        assert.is_nil(state:current())
    end)
end)
