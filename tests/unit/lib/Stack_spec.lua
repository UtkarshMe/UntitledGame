local Stack = require('lib.Stack')

describe('Stack', function()

    local stack = nil

    before_each(function()
        stack = Stack:new()
    end)

    after_each(function()
        stack = nil
    end)

    it('is empty to begin with', function()
        assert.is_nil(stack:top())
    end)

    it('can be pushed to', function()
        stack:push('item1')
        assert.is_equal(stack:top(), 'item1')
        stack:push('item2')
        assert.is_equal(stack:top(), 'item2')
    end)

    it('can be poped from', function()
        stack:push('item1')
        stack:push('item2')
        stack:pop()
        assert.is_equal(stack:top(), 'item1')
        stack:pop()
        assert.is_nil(stack:top())
    end)

    it('can be emptied', function()
        stack:push('item1')
        stack:push('item2')
        stack:empty()
        assert.is_nil(stack:top())
    end)
end)
