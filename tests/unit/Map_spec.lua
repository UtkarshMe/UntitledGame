local map = nil

describe('Map', function()
    setup(function()
        map = require('models.Map')
    end)

    before_each(function()
        map:load('dummy')
    end)

    after_each(function()
        -- nop
    end)

    it('can be loaded from file', function()
        assert.is_same(map:getSize(), { width = 10, height = 10 })
        assert.is_same(map:getMap().components, { 'wall', 'box', 'grass' })
    end)

    it('allows getting and setting tile at position', function()
        local tile = map:getTile(1, 1)
        assert.is_same(map:getComponent(tile), 'wall')

        tile = 2
        map:setTile(1, 1, tile)
        assert.is_same(map:getTile(1, 1), tile)

        tile = 99
        assert.has_error(function()
            map:setTile(1, 1, tile)
        end)
    end)

    it('allows getting and setting user position', function()
        assert.is_same(map:getUserPosition(), { 2, 2 })

        map:setUserPosition({ 2, 3 })
        assert.is_same(map:getUserPosition(), { 2, 3 })

        assert.has_error(function()
            local size = map:getSize()
            map:setUserPosition({ size.width + 1, size.height + 1 })
        end)

        assert.has_error(function()
            map:setUserPosition({ 0, 0 })
        end)
    end)
end)
