local console = nil
local script = 'some script'

describe('Console', function()
    setup(function()
        console = require('models.Console')
    end)

    it('can get and update user script', function()
        console:updateValue(script)
        assert.is_same(console:getValue(), script)

        console:updateValue()
        assert.is_nil(console:getValue())
    end)
end)
