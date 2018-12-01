-- data/maps/ifstart-ifexit.lua : Conditionals tut

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
[[To execute commands conditionally, use this pattern:

ifstart
  forward
else
  backward
endif

You can also use "ifexit" in place of "ifstart" to check for exit.
]],
}

-- example to add artifacts:
--  Map.artifacts[3] = {}
--  Map.artifacts[3][4] = 1

return Map
