local Model = require('models.Model')

describe('Model', function()
    local model = nil

    it('has a name', function()
        model = Model:new({ name = 'myModel'})
        assert.is_not_nil(model)
        assert.is_same(model:getName(), 'myModel')

        model = Model:new()
        assert.is_not_nil(model)
        assert.is_same(model:getName(), 'UnnamedModel')
    end)
end)
