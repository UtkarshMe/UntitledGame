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
    options.frame  = options.frames or 2

    return options
end

local function getFrame(options)
    local time = math.floor(options.speed
            * globals.timer.getTime(options.timer))

    return (time % options.frames) + 1
end

function animate.jump(drawable, x, y, options)
    options = parseOptions(options)
    options.frames = options.frames or 2
    local frame = getFrame(options)

    if frame == 1 then
        love.graphics.draw(drawable, x, y - options.factor)
    elseif frame == 2 then
        love.graphics.draw(drawable, x, y)
    end
end

function animate.blinkText(text, options)
    options = parseOptions(options)
    options.frames = options.frames or 2
    local frame = getFrame(options)

    if frame == 1 then
        return text
    elseif frame == 2 then
        return ''
    end
end

return animate
