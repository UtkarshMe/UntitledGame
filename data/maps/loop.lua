-- data/maps/loop.lua : Looping tut

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
[[To execute commands repeatedly, use this pattern:

loop
  forward
endloop

To exit a loop, use "break" inside the loop]],
}

-- example to add artifacts:
--  Map.artifacts[3] = {}
--  Map.artifacts[3][4] = 1

return Map
