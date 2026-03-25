-- List of implemented buildings
local implemented_buildings = {
    "Hospital",
}

-- List of implemented special buildings
local implemented_special_buildings = {
    "Statue of Liberty",
    "Great Wall",
    "Pyramids"
}

local buildings = {}

-- Defense and Attack buffs:
--defense
buildings[3] = {
    name = "Castle",
    emoji = "🏰",
    special = "+5% defense [ground]",
    class = "ground"
}

buildings[3] = {
    name = 'Port',
    emoji = "⚓",
    special = "+5% defense [water]",
    class = "water"
}

buildings[4] = {
    name = "Airport",
    emoji = "🛫",
    special = "+5% defense [air]",
    class = "air"
}
-- attack
--[[ name = 'lighthouse', emoji = "🚨"

]]

-- buff attack, buff defense
buildings[8] = {
    name = "Barracks",
    emoji = "⛺",
    special = "+5% Attack [ground], +5% defense [ground]"
}

-- speed
buildings[13] = {
    name = "Roads",
    emoji = "🛣️",
    special = "+5% speed [ground]",
}

buildings[13] = {
    name = "Railroads",
    emoji = "🛤️",
    special = "+10% speed [ground]",
}


-- attack/defense tradeoff
buildings[10] = {
    name = "Fortress",
    emoji = "🛡️",
    special = "-5% Attack, +10% defense",
    class = "none"
}

buildings[9] = {
    name = "Arsenal",
    emoji = "🏯",
    special = "+10% attack, -5% Defense",
    class = "none"
}

-- Heals
buildings[1] = {
    name = "Hospital",
    emoji = "🏥",
    special = "+10% Heal",
    class = "none"
}

buildings[2] = {
    name = "Church",
    emoji = "⛪",
    special = "+5% Heal, +5% defense",
    class = "none"
}

buildings[5] = {
    name = "Mosque",
    emoji = "🕌",
    attack_mod = 0.05,
    defense_mod = 0.05,
    special = "+5% Heal, +5% attack",
    class = "none"
}

buildings[6] = {
    name = "Temple",
    emoji = "🛕",
    attack_mod = 0,
    defense_mod = 0.05,
    special = "+5% Heal, +5% speed",
    class = "none"
}

buildings[7] = {
    name = "Synagogue",
    emoji = "🕍",
    special = "+5% Heal, +5% attack",
    class = "none"
}

buildings[8] = {
    name = "kaaba",
    emoji = '🕋',
    special = '+5% Heal, +5% attack',
    class = "none"
}
-- Economic Buildings
--[[
buildings[11] = {
    name = "Market",
    emoji = "🏪",
    special = "+5% resource generation",
    class = "none"
}

buildings[12] = {
    name = "Bank",
    emoji = "🏦",
    special = "+10% resource generation",
    class = "none"
}
]]


-- Negative Effect Buildings (Debuffs)
buildings[19] = {
    name = "Pollution Plant",
    emoji = "🏭",
    special = "+15% Attack, -10% Defense, -10% speed",
    class = "none"
}

buildings[20] = {
    name = "Prison",
    emoji = "🔒",
    attack_mod = 0.02,
    defense_mod = 0.08,
    special = "+15% defense, -10% attack, -10% speed",
    class = "none"
}

local special_buildings = {}

-- Additional Special Buildings
special_buildings[1] = {
    name = "Statue of Liberty",
    emoji = "🗽",
    special = "+25% Attack all",
}

special_buildings[2] = {
    name = "Great Wall",
    emoji = "🧱",
    special = "+25% Defense [ground] all",
}

special_buildings[3] = {
    name = "Holy Fountain",
    emoji = "🏞️",
    special = "+25% Heal all",
}
