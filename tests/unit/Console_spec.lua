require('tests.unit.helper')

local console = nil
local script = 'some script'
local value = 'this is some script'

describe('Console', function()
    setup(function()
        console = require('models.Console')
    end)

    it('can get and update user script', function()
        console:updateValue(script)
        assert.is_same(console:getValue(), script)

        console:updateValue()
        assert.is_same(console:getValue(), '')
    end)

    it('can append to user script', function()
        console:appendValue(script)
        assert.is_same(console:getValue(), script)

        console:appendValue(value)
        assert.is_same(console:getValue(), script .. value)
    end)
end)
