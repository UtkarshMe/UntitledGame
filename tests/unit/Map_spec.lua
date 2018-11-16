local map = nil
local size = {
    width = 10,
    height = 10,
}

describe('Map', function()
    before_each(function()
        map = require('models.Map')
        map:init(size.width, size.height)
    end)

    it('can be loaded from file', function()
        map:load('dummy')
        assert.is_same(map.size, size)
        assert.is_same(map.components, { 'wall', 'box', 'grass' })
    end)

    it('can be saved to file')
    it('allows getting and setting position of tile/character')
    it('allows getting and setting tile/character at position')
end)
