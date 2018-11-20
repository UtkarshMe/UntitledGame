local Menu = require('models.Menu')

describe('Menu', function()
    local menu = nil
    local cb = function(_) return true end

    before_each(function()
        menu = Menu:new()
    end)

    it('allows MenuItem to be added', function()
        menu:addItem('item1', cb)
    end)

    it('allows MenuItem to be fetched', function()
        local id = menu:addItem('item1', cb)
        local item = menu:getItem(id)
        assert.is_same(item.label, 'item1')
        assert.is_true(item.target())
    end)

    it('return nil on fetching non-existant id', function()
        assert.is_nil(menu:getItem(99))
        assert.is_nil(menu:getItem('some wrong id'))
    end)

    it('keeps track of highlighted item', function()
        menu:addItem('item1', cb)
        menu:addItem('item2', cb)
        assert.is_equal(menu:getHighlighted(), 1)
        menu:setHighlighted(2)
        assert.is_equal(menu:getHighlighted(), 2)
        assert.has_error(function()
            menu:setHighlighted(99)
        end)
    end)
end)
