-- data/maps/forward.lua : Learn to go forward

local Map = {
    size = {
        width = 11,
        height = 9,
    },
    components = {
        'wall',
        'box_closed',
        'grass',
        'exit',
    },
    data = {
        { 1, 1, 1, 1, 1, 4, 1, 1, 1, 1, 1 },
        { 1, 3, 3, 3, 3, 3, 3, 3, 3, 3, 1 },
        { 1, 3, 2, 3, 2, 3, 2, 3, 2, 3, 1 },
        { 1, 3, 3, 3, 3, 3, 3, 3, 3, 3, 1 },
        { 1, 3, 2, 3, 2, 3, 2, 3, 2, 3, 1 },
        { 1, 3, 3, 3, 3, 3, 3, 3, 3, 3, 1 },
        { 1, 3, 2, 3, 2, 3, 2, 3, 2, 3, 1 },
        { 1, 3, 3, 3, 3, 3, 3, 3, 3, 3, 1 },
        { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
    },
    positions = {
        start = { 6, 8 },
        exit = { 6, 1 },
    },
    commands = {
        'forward',
    },
}

return Map
