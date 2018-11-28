-- log.lua : logger for our game

local log = {}
local levels = {
    none = 1,
    info = 2,
    debug = 3,
}

function log.info(...)
    if levels[globals.logLevel] >= levels.info then
        print('info : ' .. ...)
    end
end

function log.debug(...)
    if levels[globals.logLevel] >= levels.debug then
        print('debug: ' .. ...)
    end
end

return log
