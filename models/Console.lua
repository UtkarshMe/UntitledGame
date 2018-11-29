-- models/Console.lua : The model for console for user to enter script

local utf8 = require('utf8')
local Model = require('models.Model')
local model = Model:new(
    {
        name = "Console",
        value = '',
        cursor = 1,
        message = '',
    })

function model:updateValue(newValue)
    self.value = newValue or ''
end

function model:appendValue(value)
    value:match('^%s*(.-)%s*$')  -- trim
    self.value = (string.sub(self.value, 1, self.cursor) or '') .. value
            .. (string.sub(self.value, self.cursor + 1) or '')
    self:moveCursor(string.len(value))
end

function model:getValue()
    return self.value or ''
end

function model:setMessage(message)
    self.message = message or ''
end

function model:getMessage()
    return self.message
end

function model:moveCursor(delta)
    local position = self.cursor + delta
    if position < 0 then
        self.cursor = 0
    elseif position > string.len(self.value) then
        self.cursor = string.len(self.value)
    else
        self.cursor = position
    end
end

function model:getCursor()
    return self.cursor
end

function model:backspace()
    local value = string.sub(self.value, 1, self.cursor)
    local byteoffset = utf8.offset(value, -1)
    if byteoffset then
        -- remove the last UTF-8 character.
        -- string.sub operates on bytes rather than UTF-8 characters, so we
        -- couldn't do string.sub(value, 1, -2).
        value = string.sub(value, 1, byteoffset - 1)
    end
    self.value = value .. string.sub(self.value, self.cursor + 1)
    self:moveCursor(-1)
end

return model
