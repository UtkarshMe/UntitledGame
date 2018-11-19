local map = nil
local size = { width = 10, height = 10 }

describe('Map', function()
    setup(function()
        map = require('models.Map')
        map:init(size.width, size.height)
    end)

    before_each(function()
        map:load('dummy')
    end)

    after_each(function()
        -- nop
    end)

    it('can be loaded from file', function()
        assert.is_same(map:getSize(), size)
        assert.is_same(map:getMap().components, { 'wall', 'box', 'grass' })
    end)

    it('allows getting and setting tile at position', function()
        local tile = map:getTile(1, 1)
        assert.is_same(tile, 1)

        tile = 2
        map:setTile(1, 1, tile)
        assert.is_same(map:getTile(1, 1), tile)

        tile = 99
        assert.has_error(function()
            map:setTile(1, 1, tile)
        end)
    end)
end)
