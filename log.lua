-- log.lua : logger for our game

local log = {}

function log.info(...)
    -- comment out line below to prevent logging
    print('info : ' .. ...)
end

function log.debug(...)
    -- comment out line below to prevent logging
    print('debug: ' .. ...)
end

return log
