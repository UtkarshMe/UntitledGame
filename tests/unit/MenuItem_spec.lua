local MenuItem = require('models.MenuItem')

describe('Menu Item', function()
    local menuItem = nil

    it('can get/set a label', function()
        local label = 'some label'

        menuItem = MenuItem:new(label)
        assert.is_same(menuItem:getLabel(), label)

        label = 'some other label'
        menuItem:setLabel(label)
        assert.is_same(menuItem:getLabel(), label)
    end)

    it('can get/set a target', function()
        local target = function() return true end

        menuItem = MenuItem:new(nil, target)
        local ret = menuItem:getTarget()
        assert.is_same(ret, target)
        assert.is_true(ret())

        target = function() return nil end
        menuItem:setTarget(target)
        ret = menuItem:getTarget()
        assert.is_same(ret, target)
        assert.is_nil(ret())
    end)
end)
