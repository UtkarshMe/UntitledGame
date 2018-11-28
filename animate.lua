-- animate.lua : helpers for animating

local animate = {}

animate.timer = 'animateTimer'
globals.timer.track(animate.timer)
globals.timer.start(animate.timer)

local function parseOptions(options)
    if not options then
        options = {}
    end

    options.speed  = options.speed  or 1
    options.timer  = options.timer  or animate.timer
    options.factor = options.factor or 10
    options.frames = options.frames or 2

    if options.loop == nil then
        options.loop = true
    end

    return options
end

local function getFrame(animatable)
    if animatable.animating then
        return (math.floor(animatable.options.speed
                    * globals.timer.getTime(animatable.options.timer))
                % animatable.options.frames ) + 1
    else
        return animatable.options.frames
    end
end

function animate:new(options)
    local obj = {
        animating = true,
        options = parseOptions(options),
    }

    self.__index = self
    return setmetatable(obj, self)
end

function animate.reset()
    globals.timer.reset(animate.timer)
end

function animate:jump(drawable, x, y)
    local frame = getFrame(self)

    if frame == 1 then
        love.graphics.draw(drawable, x, y - self.options.factor)
    elseif frame == 2 then
        love.graphics.draw(drawable, x, y)
    end
end

function animate:blinkText(text)
    local frame = getFrame(self)

    if frame == 1 then
        return text
    elseif frame == 2 then
        return ''
    end
end

function animate:teletype(text)
    self.options.frames = string.len(text) + 1
    local frame = getFrame(self)

    if frame == self.options.frames - 1 then
        if not self.options.loop then
            self.animating = false
        end
    else
        return string.sub(text, 1, frame - 1)
    end

    return text
end

return animate
