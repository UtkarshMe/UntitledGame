require('tests.unit.helper')
local View = require('views.View')

describe('View', function()
    local view = nil

    before_each(function()
        view = View:new()
        assert.is_not_nil(view)
    end)

    after_each(function()
        view = nil
    end)

    it('can be loaded', function()
        view:load()
    end)

    it('can be updated', function()
        view:update()
    end)

    it('can be drawn', function()
        view:draw()
    end)
end)
