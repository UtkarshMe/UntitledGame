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
    -- if we're not animating anymore, just return the last frame
    if animatable.animating then
        local frame =
                (math.floor(animatable.options.speed
                    * globals.timer.getTime(animatable.options.timer))
                % animatable.options.frames ) + 1

        -- if at the last frame of the loop set not animating anymore if
        -- looping is disabled
        if animatable.options.loop == false
                and frame == animatable.options.frames then
            animatable.animating = false
        end
        return frame
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
        return ''
    elseif frame == 2 then
        return text
    end
end

function animate:teletype(text)
    self.options.frames = string.len(text) + 1
    local frame = getFrame(self)
    return string.sub(text, 1, frame - 1)
end

function animate:loop(callback)
    if self.animating and getFrame(self) == self.options.frames then
        callback()
    end
end

return animate
