local biomes = {
    [1] = {
        name = 'Desert',
        emoji = '🏜️',
        color = '#dddd00',
        effect = '-5% speed [ground] [enemy]'
    },
    [2] = {
        name = 'Forest',
        emoji = '🌲',
        color = '#228B22',
        effect = '+5% defense [ground]'
    },
    [3] = {
        name = 'Mountain',
        emoji = '⛰️',
        color = '#808080',
        effect = '+5% attack [air]'
    },
    [4] = {
        name = 'Ocean',
        emoji = '🌊',
        color = '#0000FF',
        effect = '+5% attack [water]'
    },
    [5] = {
        name = 'Tundra',
        emoji = '❄️',
        color = '#ADD8E6',
        effect = '-5% speed [enemy]'
    },
    [6] = {
        name = 'Swamp',
        emoji = '🐊',
        color = '#556B2F',
        effect = '+5% defense [water]'
    },
    [7] = {
        name = 'Volcano',
        emoji = '🌋',
        color = '#FF4500',
        effect = '-5% defense [ground]'
    },
    [8] = {
        name = 'Jungle',
        emoji = '🌴',
        color = '#32CD32',
        effect = '+5% heal'
    }
}

local implemented_biomes = {
    'Desert',
    'Forest',
    'Mountain',
    'Ocean',
    'Tundra',
    'Swamp',
    'Volcano',
    'Jungle'
}
