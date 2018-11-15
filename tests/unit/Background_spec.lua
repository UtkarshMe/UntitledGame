describe('Background', function()

    local background = require('models.Background')
    local width, height = 60, 80

    setup(function()
        background:init(width, height)
    end)

    it('can be instantiated', function()
        assert.is_not_nil(background)
    end)
end)
