local Console = require('components/Console')

describe('Console', function()

    local console = {}
    local width, height = 60, 80

    setup(function()
        console = Console:new(width, height)
    end)

    it('can be instantiated', function()
        assert.is_not_nil(console)
    end)

    it('can hold the user script', function()
        local script = [[loop forward endloop]]
        assert.is_nil(console.script)
        console:setScript(script)
        assert.is_same(script, console:getScript())
    end)
end)
