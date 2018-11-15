local Console = require('components/Console')

local width, height = 60, 80

describe('Console', function()
    local console = {}

    setup(function()
        console = Console:new(width, height)
    end)

    it('can be instantiated', function()
        assert.is_not_nil(console)
    end)
end)
