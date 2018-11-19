-- data/maps/forward.lua : Learn to go forward

local Map = {
    size = {
        width = 5,
        height = 5,
    },
    components = {
        'wall',
        'box',
        'grass',
    },
    data = {
        { 1, 1, 3, 1, 1 },
        { 1, 2, 3, 2, 1 },
        { 1, 2, 3, 2, 1 },
        { 1, 2, 3, 2, 1 },
        { 1, 1, 3, 1, 1 },
    },
    positions = {
        user = { 3, 5 },
        exit = { 1, 3 },
    },
    commands = {
        'forward',
    },
}

return Map
