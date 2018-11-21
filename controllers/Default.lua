-- controllers/Default.lua : Default controller for all models

local log = require('log')
local controllers = {}

function controllers.keyinput(args)
    log.info('default.inputkey: ' .. (args[1] or ''))
end

function controllers.textinput(args)
    log.info('default.inputkey: ' .. (args[1] or ''))
end

return controllers
