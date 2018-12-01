-- data/maps/open.lua : Opening boxes

local Map = {
    size = {
        width = 13,
        height = 11,
    },
    components = {
        'wall',
        'box_closed',
        'grass',
        'exit',
        'tomato',
    },
    data = {
        { 1, 1, 1, 1, 1, 1, 4, 1, 1, 1, 1, 1, 1 },
        { 1, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 1 },
        { 1, 1, 3, 2, 3, 2, 3, 2, 3, 2, 3, 1, 1 },
        { 1, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 1 },
        { 1, 1, 3, 2, 3, 2, 3, 2, 3, 2, 3, 1, 1 },
        { 1, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 1 },
        { 1, 1, 3, 2, 3, 2, 3, 2, 3, 2, 3, 1, 1 },
        { 1, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 1 },
        { 1, 1, 3, 2, 3, 2, 3, 2, 3, 2, 3, 1, 1 },
        { 1, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 1 },
        { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
    },
    artifacts = {
        default = 3,
    },
    positions = {
        start = { 7, 6 },
        exit = { 7, 1 },
    },
    story =
[[Some boxes may contain stuff for you to find!

Try "open" when they are in front of you.]],
}

-- example to add artifacts:
Map.artifacts[5] = {}
Map.artifacts[5][6] = 5

return Map
