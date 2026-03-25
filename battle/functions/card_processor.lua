--[[
    {
    name = "Turtle",
    emoji = "🐢",
    environment = "ground",
    cost = 0.2,
    speed = 0.02,  -- m/s
    attack_base = 0,
    defense_base = 0.15,  -- +15% of base HP as defense
    special = "+X defense",
    weakness = "Bear, Wolf, Crocodile"
  },
]]
local process_card = function (card)
    return {
    name = card.name,
    emoji = card.emoji,
    environment = card.environment,
    cost = card.cost * SCALE,
    speed = card.base_speed * SCALE,
    health = card.base_health * SCALE,
    attack = card.base_attack * SCALE,
    defense = card.base_defense * SCALE,
    special = card.special,
    weakness = card.weakness
  }
end