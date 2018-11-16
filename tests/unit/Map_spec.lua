local map = nil
local dummy = require('data.maps.dummy')

describe('Map', function()
    setup(function()
        map = require('models.Map')
    end)

    before_each(function()
        map:load(dummy)
    end)

    after_each(function()
        -- nop
    end)

    it('can be loaded from file', function()
        local size = { width = 10, height = 10 }
        assert.is_same(map:getSize(), size)
        assert.is_same(map:getMap().components, { 'Wall', 'Box', 'Grass' })
    end)

    it('allows getting and setting tile at position', function()
        local tile = map:getTile(1, 1)
        assert.is_same(map:getComponent(tile), 'Wall')

        tile = 2
        map:setTile(1, 1, tile)
        assert.is_same(map:getTile(1, 1), tile)

        tile = 99
        assert.has_error(function()
            map:setTile(1, 1, tile)
        end)
    end)

    it('allows getting and setting user position', function()
        assert.is_same(map:getPosition('user'), { 2, 2 })

        map:setPosition('user', { 2, 3 })
        assert.is_same(map:getPosition('user'), { 2, 3 })

        assert.has_error(function()
            local size = map:getSize()
            map:setPosition('user', { size.width + 1, size.height + 1 })
        end)

        assert.has_error(function()
            map:setPosition('user', { 0, 0 })
        end)
    end)

    it('does not get/set position of unknown things', function()
        assert.has_error(function()
            map:getPosition('unk')
        end)

        assert.has_error(function()
            map:setPosition('unk', { 1, 2 })
        end)
    end)
end)
