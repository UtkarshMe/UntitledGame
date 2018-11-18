local Model = require('models.Model')

describe('Model', function()
    local model = nil

    before_each(function()
        model = Model:new()
        assert.is_not_nil(model)
    end)

    after_each(function()
        model = nil
    end)
end)
