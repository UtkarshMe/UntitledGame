local Background = require('components/Background')

describe('Background', function()

    local background = {}
    local width, height = 60, 80

    setup(function()
        background = Background:new(width, height)
    end)

    it('can be instantiated', function()
        assert.is_not_nil(background)
    end)
end)
