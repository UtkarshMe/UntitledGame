-- timer.lua : Track that time!

local log = require('log')
local timer = {
    total = 0,
    trackers = {},
}

function timer.track(tracker)
    if not tracker then
        error('cannot setup tracker for nil')
        return
    end

    timer.trackers[tracker] = {
        _time = 0,
        _isTracking = false
    }
    log.debug('timer.track: ' .. tracker)
end

function timer.reset(tracker)
    timer.trackers[tracker]._time = 0
    log.debug('timer.reset: ' .. tracker)
end

function timer.start(tracker)
    timer.trackers[tracker]._isTracking = true
    log.debug('timer.start: ' .. tracker
            .. ' at: ' .. timer.trackers[tracker]._time)
end

function timer.stop(tracker)
    timer.trackers[tracker]._isTracking = false
    log.debug('timer.stop: ' .. tracker
            .. ' at: ' .. timer.trackers[tracker]._time)
end

function timer.update(timeDelta)
    timer.total = timer.total + timeDelta
    for tracker in pairs(timer.trackers) do
        local t = timer.trackers[tracker]
        if t._isTracking then
            t._time = t._time + timeDelta
        end
    end
end

function timer.getTime(tracker)
    return timer.trackers[tracker]._time
end

return timer
