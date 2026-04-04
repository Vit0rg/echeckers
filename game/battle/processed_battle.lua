
-- /home/s1eep1ess/workspace/lua/echeckers/game/settings/configuration.lua
BUILD = 'TUI'
MODE = 'basic'
UI = {}
math.randomseed(os.time())
-- /home/s1eep1ess/workspace/lua/echeckers/game/assets/animals.lua
-- local animals = {}

-- Base HP multiplier factor (can be adjusted based on player life)
local BASE_HP_MULTIPLIER = 100  -- Default to 100, can be changed to 500 or more

-- Static variable with all animals implemented separated by environment
local animals_by_environment = {
  water = {
    "Shark", "Dolphin", "Whale", "Octopus", "Jellyfish", "Swordfish", "Tuna",
    "Stingray", "Electric Eel", "Manta Ray", "Squid", "Lobster",
    "Piranha", "Seahorse", "Penguin", "Clam", "Nautilus", "Shrimp", "Hermit Crab",
    "Manatee", "Hippopotamus", "Megalodon", "Kraken"
  },
  ground = {
    "Turtle", "Tortoise", "Lion", "Tiger", "Bear", "Cat", "Panther",
    "Horse", "Rabbit", "Deer", "Snail", "Crab", "Wolf", "Dog", "Ostrich",
    "Gazelle", "Antelope", "Elephant", "Rhino", "Peacock",
    "Crocodile", "Snake", "Frog", "Ant", "Beetle", "Spider", "Scorpion",
    "Giraffe", "Gorilla", "Kangaroo", "Polar Bear", "Leopard", "Hyena",
    "Zebra", "Koala", "Armadillo", "Lizard", "Chameleon",
    "Komodo Dragon", "Salamander", "Newt", "Termite", "Mantis",
    "Centipede", "Millipede", "Iguana", "Tarantula", "Rhinoceros Beetle",
    "Platypus", "Axolotl", "Pangolin", "T-Rex", "Triceratops", "Velociraptor",
    "Brontosaurus", "Mammoth", "Sabertooth Tiger", "Dodo", "Dragon", "Unicorn",
    "Phoenix", "Griffin"
  },
  air = {
    "Falcon", "Eagle", "Owl", "Pigeon", "Hummingbird", "Crow", "Vulture",
    "Bat", "Dragonfly", "Butterfly", "Mosquito", "Wasp", "Bee", "Swan",
    "Phoenix", "Griffin", "Dragon"
  }
}

-- Static variable with all animals implemented separated by simplified environment
local implemented_animals = {
  ground = {
    "Turtle", "Tortoise", "Lion", "Tiger", "Bear", "Cat", "Panther",
    "Horse", "Rabbit", "Deer", "Snail", "Crab", "Wolf", "Dog", "Ostrich",
    "Gazelle", "Antelope", "Elephant", "Rhino", "Peacock",
    "Crocodile", "Snake", "Frog", "Ant", "Beetle", "Spider", "Scorpion",
    "Giraffe", "Gorilla", "Kangaroo", "Polar Bear", "Leopard", "Hyena",
    "Zebra", "Koala", "Armadillo", "Lizard", "Chameleon",
    "Komodo Dragon", "Salamander", "Newt", "Termite", "Mantis",
    "Centipede", "Millipede", "Iguana", "Tarantula", "Rhinoceros Beetle",
    "Platypus", "Axolotl", "Pangolin", "T-Rex", "Triceratops", "Velociraptor",
    "Brontosaurus", "Mammoth", "Sabertooth Tiger", "Dodo", "Dragon", "Unicorn",
    "Phoenix", "Griffin"
  },
  water = {
    "Shark", "Dolphin", "Whale", "Octopus", "Jellyfish", "Swordfish", "Tuna",
    "Stingray", "Electric Eel", "Manta Ray", "Squid", "Lobster",
    "Piranha", "Seahorse", "Penguin", "Clam", "Nautilus",
    "Shrimp", "Hermit Crab", "Manatee", "Hippopotamus", "Megalodon", "Kraken"
  },
  air = {
    "Falcon", "Eagle", "Owl", "Pigeon", "Hummingbird", "Crow", "Vulture",
    "Bat", "Dragonfly", "Butterfly", "Mosquito", "Wasp", "Bee", "Swan",
    "Phoenix", "Griffin", "Dragon"
  }
}

local base_animals_list = {
  -- Turtles and animals with shells (defense bonus)
  {
    name = "Turtle",
    emoji = "🐢",
    environment = "ground",
    cost = 0.02,
    base_speed = 0.02,  -- m/s
    base_health = 0.35,
    base_attack = 0,
    base_defense = 0.15,  -- +15% of base HP as defense
    special = "+X defense",
    weakness = "Bear, Wolf, Crocodile"
  },
  {
    name = "Tortoise",
    emoji = "🐢",
    environment = "ground",
    cost = 0.02,
    base_speed = 0.02,  -- m/s
    base_health = 0.40,
    base_attack = 0,
    base_defense = 0.18,  -- +18% of base HP as defense
    special = "+X defense",
    weakness = "Bear, Wolf, Crocodile"
  },

  -- Animals with claws (attack bonus)
  {
    name = "Lion",
    emoji = "🦁",
    environment = "ground",
    cost = 0.05,
    base_speed = 2.05,  -- m/s
    base_health = 0.75,
    base_attack = 0.12,  -- +12% of base HP as attack
    base_defense = 0.05,
    special = "+Y attack",
    weakness = "Hyena, Crocodile, Elephant"
  },
  {
    name = "Tiger",
    emoji = "🐯",
    environment = "ground",
    cost = 0.05,
    base_speed = 1.67,  -- m/s
    base_health = 0.78,
    base_attack = 0.13,  -- +13% of base HP as attack
    base_defense = 0.06,
    special = "+Y attack",
    weakness = "Elephant, Bear, Crocodile"
  },
  {
    name = "Bear",
    emoji = "🐻",
    environment = "ground",
    cost = 0.05,
    base_speed = 1.23,  -- m/s
    base_health = 0.85,
    base_attack = 0.14,  -- +14% of base HP as attack
    base_defense = 0.08,
    special = "+Y attack",
    weakness = "Wolf, Tiger, Polar Bear"
  },
  {
    name = "Cat",
    emoji = "🐱",
    environment = "ground",
    cost = 0.03,
    base_speed = 1.23,  -- m/s
    base_health = 0.25,
    base_attack = 0.08,  -- +8% of base HP as attack
    base_defense = 0.04,
    special = "+Y attack",
    weakness = "Dog, Eagle, Owl"
  },
  {
    name = "Panther",
    emoji = "🐆",
    environment = "ground",
    cost = 0.05,
    base_speed = 2.46,  -- m/s
    base_health = 0.70,
    base_attack = 0.15,  -- +15% of base HP as attack
    base_defense = 0.07,
    special = "+Y attack",
    weakness = "Crocodile, Snake, Lion"
  },

  -- Fast animals (speed bonus)
  {
    name = "Cheetah",
    emoji = "🐆",
    environment = "ground",
    cost = 0.05,
    base_speed = 3.08,  -- m/s
    base_health = 0.65,
    base_attack = 0.10,
    base_defense = 0.03,
    special = "+Z speed",
    weakness = "Lion, Hyena, Leopard"
  },
  {
    name = "Falcon",
    emoji = "🦅",
    environment = "air",
    cost = 0.04,
    base_speed = 10.00,  -- m/s (diving speed)
    base_health = 0.20,
    base_attack = 0.11,
    base_defense = 0.02,
    special = "+Z speed",
    weakness = "Owl, Eagle"
  },
  {
    name = "Horse",
    emoji = "🐎",
    environment = "ground",
    cost = 0.04,
    base_speed = 2.26,  -- m/s
    base_health = 0.70,
    base_attack = 0.06,
    base_defense = 0.05,
    special = "+Z speed",
    weakness = "Wolf, Lion, Tiger"
  },
  {
    name = "Rabbit",
    emoji = "🐰",
    environment = "ground",
    cost = 0.02,
    base_speed = 1.23,  -- m/s
    base_health = 0.15,
    base_attack = 0.05,
    base_defense = 0.03,
    special = "+Z speed",
    weakness = "Falcon, Snake, Cat, Owl"
  },
  {
    name = "Deer",
    emoji = "🦌",
    environment = "ground",
    cost = 0.03,
    base_speed = 2.05,  -- m/s
    base_health = 0.50,
    base_attack = 0.04,
    base_defense = 0.04,
    special = "+Z speed",
    weakness = "Wolf, Lion, Tiger"
  },

  -- Other animals with shells (defense bonus)
  {
    name = "Snail",
    emoji = "🐌",
    environment = "water",
    cost = 0.01,
    base_speed = 0.01,  -- m/s
    base_health = 0.10,
    base_attack = 0,
    base_defense = 0.10,  -- +10% of base HP as defense
    special = "+X defense",
    weakness = "Frog, Beetle, Crow"
  },
  {
    name = "Crab",
    emoji = "🦀",
    environment = "water",
    cost = 0.02,
    base_speed = 0.01,  -- m/s
    base_health = 0.18,
    base_attack = 0.07,  -- +7% of base HP as attack (claws)
    base_defense = 0.09,  -- +9% of base HP as defense (shell)
    special = "+X defense, +Y attack",
    weakness = "Octopus, Shark, Lobster"
  },

  -- More clawed animals
  {
    name = "Wolf",
    emoji = "🐺",
    environment = "ground",
    cost = 0.05,
    base_speed = 1.67,  -- m/s
    base_health = 0.60,
    base_attack = 0.10,  -- +10% of base HP as attack
    base_defense = 0.06,
    special = "+Y attack",
    weakness = "Bear, Tiger, Wolf"
  },
  {
    name = "Dog",
    emoji = "🐕",
    environment = "ground",
    cost = 0.03,
    base_speed = 0.82,  -- m/s
    base_health = 0.35,
    base_attack = 0.06,  -- +6% of base HP as attack
    base_defense = 0.05,
    special = "+Y attack",
    weakness = "Wolf, Bear, Lion"
  },
  {
    name = "Eagle",
    emoji = "🦅",
    environment = "air",
    cost = 0.05,
    base_speed = 4.87,  -- m/s (level flight)
    base_health = 0.30,
    base_attack = 0.09,  -- +9% of base HP as attack
    base_defense = 0.03,
    special = "+Y attack, +Z speed",
    weakness = "Owl, Eagle, Falcon"
  },

  -- More fast animals
  {
    name = "Ostrich",
    emoji = "🦢",
    environment = "air",
    cost = 0.03,
    base_speed = 1.79,  -- m/s
    base_health = 0.45,
    base_attack = 0.03,
    base_defense = 0.04,
    special = "+Z speed",
    weakness = "Lion, Leopard, Hyena"
  },
  {
    name = "Gazelle",
    emoji = "🦌",
    environment = "ground",
    cost = 0.03,
    base_speed = 2.05,  -- m/s
    base_health = 0.40,
    base_attack = 0.04,
    base_defense = 0.05,
    special = "+Z speed",
    weakness = "Cheetah, Lion, Leopard"
  },
  {
    name = "Antelope",
    emoji = "🦌",
    environment = "ground",
    cost = 0.03,
    base_speed = 2.26,  -- m/s
    base_health = 0.45,
    base_attack = 0.05,
    base_defense = 0.04,
    special = "+Z speed",
    weakness = "Lion, Cheetah, Dog"
  },

  -- Sea animals
  {
    name = "Shark",
    emoji = "🦈",
    environment = "water",
    cost = 0.06,
    base_speed = 1.28,  -- m/s
    base_health = 0.90,
    base_attack = 0.16,  -- +16% of base HP as attack
    base_defense = 0.07,
    special = "+Y attack",
    weakness = "Whale, Shark, Kraken"
  },
  {
    name = "Dolphin",
    emoji = "🐬",
    environment = "water",
    cost = 0.03,
    base_speed = 0.95,  -- m/s
    base_health = 0.55,
    base_attack = 0.07,
    base_defense = 0.08,
    special = "+Z speed",
    weakness = "Shark, Whale, Dolphin"
  },
  {
    name = "Whale",
    emoji = "🐋",
    environment = "water",
    cost = 0.05,
    base_speed = 0.90,  -- m/s
    base_health = 1.00,
    base_attack = 0.09,
    base_defense = 0.12,  -- High defense due to size
    special = "+X defense",
    weakness = "Shark, Kraken, Whale"
  },
  {
    name = "Octopus",
    emoji = "🐙",
    environment = "water",
    cost = 0.04,
    base_speed = 1.03,  -- m/s (when jet propulsion)
    base_health = 0.35,
    base_attack = 0.08,
    base_defense = 0.06,
    special = "+Y attack",
    weakness = "Shark, Electric Eel, Dolphin"
  },
  {
    name = "Jellyfish",
    emoji = "🪼",
    environment = "water",
    cost = 0.02,
    base_speed = 0.05,  -- m/s
    base_health = 0.08,
    base_attack = 0.05,
    base_defense = 0.03,
    special = "+Y attack",
    weakness = "Turtle, Shark, Dolphin"
  },
  {
    name = "Starfish",
    emoji = "⭐",
    environment = "water",
    cost = 0.01,
    base_speed = 0.01,  -- m/s
    base_health = 0.12,
    base_attack = 0.02,
    base_defense = 0.08,
    special = "+X defense",
    weakness = "Crab, Shark, Dolphin"
  },
  {
    name = "Seahorse",
    emoji = "🐴",
    environment = "water",
    cost = 0.01,
    base_speed = 0.01,  -- m/s
    base_health = 0.08,
    base_attack = 0.01,
    base_defense = 0.05,
    special = "+X defense",
    weakness = "Crab, Shark, Dolphin"
  },
  {
    name = "Penguin",
    emoji = "🐧",
    environment = "water",
    cost = 0.02,
    base_speed = 0.15,  -- m/s (swimming)
    base_health = 0.25,
    base_attack = 0.04,
    base_defense = 0.07,
    special = "+X defense",
    weakness = "Shark, Dolphin, Whale"
  },

  -- Insects
  {
    name = "Ant",
    emoji = "🐜",
    environment = "air",
    cost = 0.02,
    base_speed = 0.01,  -- m/s
    base_health = 0.05,
    base_attack = 0.03,
    base_defense = 0.09,  -- High defense due to colony strength
    special = "+X defense",
    weakness = "Ant, Spider, Wasp"
  },
  {
    name = "Bee",
    emoji = "🐝",
    environment = "air",
    cost = 0.02,
    base_speed = 0.17,  -- m/s
    base_health = 0.06,
    base_attack = 0.06,  -- Stinger
    base_defense = 0.04,
    special = "+Y attack",
    weakness = "Eagle, Spider, Wasp"
  },
  {
    name = "Beetle",
    emoji = "🪲",
    environment = "air",
    cost = 0.02,
    base_speed = 0.02,  -- m/s
    base_health = 0.10,
    base_attack = 0.04,
    base_defense = 0.10,  -- Hard shell
    special = "+X defense",
    weakness = "Eagle, Frog, Spider"
  },
  {
    name = "Butterfly",
    emoji = "🦋",
    environment = "air",
    cost = 0.01,
    base_speed = 0.07,  -- m/s
    base_health = 0.04,
    base_attack = 0.01,
    base_defense = 0.02,
    special = "+Z speed",
    weakness = "Eagle, Spider, Mantis"
  },
  {
    name = "Dragonfly",
    emoji = "🪰",
    environment = "air",
    cost = 0.03,
    base_speed = 0.26,  -- m/s
    base_health = 0.08,
    base_attack = 0.07,  -- Predatory insect
    base_defense = 0.03,
    special = "+Y attack, +Z speed",
    weakness = "Eagle, Spider, Wasp"
  },
  {
    name = "Spider",
    emoji = "🕷️",
    environment = "ground",
    cost = 0.03,
    base_speed = 0.01,  -- m/s
    base_health = 0.08,
    base_attack = 0.08,  -- Venomous bite
    base_defense = 0.05,
    special = "+Y attack",
    weakness = "Wasp, Eagle, Lizard"
  },
  {
    name = "Scorpion",
    emoji = "🦂",
    environment = "ground",
    cost = 0.03,
    base_speed = 0.02,  -- m/s
    base_health = 0.12,
    base_attack = 0.09,  -- Venomous sting
    base_defense = 0.07,
    special = "+Y attack",
    weakness = "Owl, Snake, Scorpion"
  },

  -- More mammals
  {
    name = "Elephant",
    emoji = "🐘",
    environment = "ground",
    cost = 0.06,
    base_speed = 0.18,  -- m/s
    base_health = 1.00,
    base_attack = 0.08,
    base_defense = 0.14,  -- High defense due to size
    special = "+X defense",
    weakness = "Lion, Tiger, Elephant"
  },
  {
    name = "Rhino",
    emoji = "🦏",
    environment = "ground",
    cost = 0.06,
    base_speed = 1.28,  -- m/s
    base_health = 0.95,
    base_attack = 0.10,
    base_defense = 0.13,  -- Thick skin
    special = "+X defense",
    weakness = "Lion, Tiger, Rhino"
  },
  {
    name = "Hippopotamus",
    emoji = "🦛",
    environment = "ground",
    cost = 0.05,
    base_speed = 0.21,  -- m/s
    base_health = 0.90,
    base_attack = 0.11,
    base_defense = 0.11,
    special = "+Y attack",
    weakness = "Crocodile, Hippopotamus, Lion"
  },

  -- Birds
  {
    name = "Owl",
    emoji = "🦉",
    environment = "air",
    cost = 0.03,
    base_speed = 1.64,  -- m/s
    base_health = 0.22,
    base_attack = 0.07,
    base_defense = 0.06,
    special = "+Y attack",
    weakness = "Eagle, Falcon, Owl"
  },
  {
    name = "Peacock",
    emoji = "🦚",
    environment = "air",
    cost = 0.02,
    base_speed = 0.10,  -- m/s
    base_health = 0.20,
    base_attack = 0.04,
    base_defense = 0.08,
    special = "+X defense",
    weakness = "Snake, Cat, Peacock"
  },

  -- Reptiles
  {
    name = "Crocodile",
    emoji = "🐊",
    environment = "ground",
    cost = 0.05,
    base_speed = 0.26,  -- m/s
    base_health = 0.80,
    base_attack = 0.13,
    base_defense = 0.10,
    special = "+Y attack",
    weakness = "Hippopotamus, Crocodile, Tiger"
  },
  {
    name = "Snake",
    emoji = "🐍",
    environment = "ground",
    cost = 0.03,
    base_speed = 0.02,  -- m/s
    base_health = 0.18,
    base_attack = 0.08,
    base_defense = 0.04,
    special = "+Y attack",
    weakness = "Eagle, Falcon, Snake"
  },

  -- Amphibians
  {
    name = "Frog",
    emoji = "🐸",
    environment = "water",
    cost = 0.02,
    base_speed = 0.13,  -- m/s
    base_health = 0.10,
    base_attack = 0.03,
    base_defense = 0.03,
    special = "+Z speed",
    weakness = "Eagle, Snake, Shark"
  },

  -- Fish
  {
    name = "Swordfish",
    emoji = "🐟",
    environment = "water",
    cost = 0.05,
    base_speed = 3.31,  -- m/s
    base_health = 0.50,
    base_attack = 0.12,  -- Sword-like bill
    base_defense = 0.05,
    special = "+Y attack, +Z speed",
    weakness = "Shark, Dolphin, Swordfish"
  },
  {
    name = "Tuna",
    emoji = "🐟",
    environment = "water",
    cost = 0.04,
    base_speed = 1.90,  -- m/s
    base_health = 0.40,
    base_attack = 0.09,
    base_defense = 0.06,
    special = "+Z speed",
    weakness = "Shark, Dolphin, Tuna"
  },

  -- More sea animals
  {
    name = "Stingray",
    emoji = "🐟",
    environment = "water",
    cost = 0.03,
    base_speed = 0.05,  -- m/s
    base_health = 0.30,
    base_attack = 0.06,  -- Venomous barb
    base_defense = 0.07,
    special = "+Y attack",
    weakness = "Shark, Dolphin, Stingray"
  },
  {
    name = "Electric Eel",
    emoji = "🐟",
    environment = "water",
    cost = 0.03,
    base_speed = 0.04,  -- m/s
    base_health = 0.25,
    base_attack = 0.08,  -- Electric shock
    base_defense = 0.05,
    special = "+Y attack",
    weakness = "Shark, Electric Eel, Dolphin"
  },
  {
    name = "Manta Ray",
    emoji = "🐟",
    environment = "water",
    cost = 0.03,
    base_speed = 0.21,  -- m/s
    base_health = 0.45,
    base_attack = 0.03,
    base_defense = 0.09,
    special = "+X defense",
    weakness = "Shark, Whale, Manta Ray"
  },
  {
    name = "Lobster",
    emoji = "🦞",
    environment = "water",
    cost = 0.03,
    base_speed = 0.01,  -- m/s
    base_health = 0.20,
    base_attack = 0.05,  -- Strong claws
    base_defense = 0.11,  -- Hard shell
    special = "+X defense, +Y attack",
    weakness = "Octopus, Electric Eel, Shark"
  },
  {
    name = "Squid",
    emoji = "🦑",
    environment = "water",
    cost = 0.03,
    base_speed = 0.26,  -- m/s (when jet propulsion)
    base_health = 0.28,
    base_attack = 0.06,
    base_defense = 0.05,
    special = "+Y attack",
    weakness = "Shark, Dolphin, Whale"
  },

  -- More mammals
  {
    name = "Giraffe",
    emoji = "🦒",
    environment = "ground",
    cost = 0.04,
    base_speed = 1.44,  -- m/s
    base_health = 0.75,
    base_attack = 0.06,  -- Powerful kick
    base_defense = 0.08,
    special = "+Y attack",
    weakness = "Lion, Hyena, Crocodile"
  },
  {
    name = "Gorilla",
    emoji = "🦍",
    environment = "ground",
    cost = 0.05,
    base_speed = 1.03,  -- m/s
    base_health = 0.80,
    base_attack = 0.12,
    base_defense = 0.10,
    special = "+Y attack",
    weakness = "Leopard, Gorilla, Lion"
  },
  {
    name = "Kangaroo",
    emoji = "🦘",
    environment = "ground",
    cost = 0.04,
    base_speed = 1.79,  -- m/s
    base_health = 0.55,
    base_attack = 0.07,  -- Powerful kicks
    base_defense = 0.06,
    special = "+Y attack, +Z speed",
    weakness = "Dog, Kangaroo, Wolf"
  },
  {
    name = "Polar Bear",
    emoji = "🐻",
    environment = "ground",
    cost = 0.06,
    base_speed = 1.03,  -- m/s
    base_health = 0.88,
    base_attack = 0.15,
    base_defense = 0.09,
    special = "+Y attack",
    weakness = "Bear, Polar Bear, Tiger"
  },
  {
    name = "Leopard",
    emoji = "🐆",
    environment = "ground",
    cost = 0.05,
    base_speed = 1.49,  -- m/s
    base_health = 0.68,
    base_attack = 0.14,
    base_defense = 0.07,
    special = "+Y attack",
    weakness = "Lion, Hyena, Crocodile"
  },
  {
    name = "Hyena",
    emoji = "🐺",
    environment = "ground",
    cost = 0.04,
    base_speed = 1.54,  -- m/s
    base_health = 0.55,
    base_attack = 0.11,
    base_defense = 0.06,
    special = "+Y attack",
    weakness = "Lion, Leopard, Hyena"
  },
  {
    name = "Zebra",
    emoji = "🦓",
    environment = "ground",
    cost = 0.03,
    base_speed = 1.67,  -- m/s
    base_health = 0.50,
    base_attack = 0.04,  -- Kick
    base_defense = 0.07,
    special = "+Z speed",
    weakness = "Lion, Hyena, Crocodile"
  },
  {
    name = "Koala",
    emoji = "🐨",
    environment = "ground",
    cost = 0.02,
    base_speed = 0.18,  -- m/s
    base_health = 0.22,
    base_attack = 0.03,
    base_defense = 0.09,
    special = "+X defense",
    weakness = "Dog, Koala, Cat"
  },
  {
    name = "Armadillo",
    emoji = "🦔",
    environment = "ground",
    cost = 0.03,
    base_speed = 1.23,  -- m/s
    base_health = 0.30,
    base_attack = 0.04,
    base_defense = 0.12,  -- Armored shell
    special = "+X defense",
    weakness = "Dog, Armadillo, Wolf"
  },

  -- More birds
  {
    name = "Pigeon",
    emoji = "🐦",
    environment = "air",
    cost = 0.02,
    base_speed = 1.23,  -- m/s
    base_health = 0.12,
    base_attack = 0.02,
    base_defense = 0.04,
    special = "+Z speed",
    weakness = "Falcon, Eagle, Cat"
  },
  {
    name = "Swan",
    emoji = "🦢",
    environment = "air",
    cost = 0.03,
    base_speed = 0.23,  -- m/s
    base_health = 0.28,
    base_attack = 0.06,  -- Aggressive when protecting young
    base_defense = 0.07,
    special = "+Y attack",
    weakness = "Eagle, Falcon, Swan"
  },
  {
    name = "Hummingbird",
    emoji = "🐦",
    environment = "air",
    cost = 0.02,
    base_speed = 1.23,  -- m/s
    base_health = 0.05,
    base_attack = 0.02,
    base_defense = 0.01,
    special = "+Z speed",
    weakness = "Spider, Mantis, Hummingbird"
  },
  {
    name = "Crow",
    emoji = "🐦",
    environment = "air",
    cost = 0.02,
    base_speed = 1.28,  -- m/s
    base_health = 0.15,
    base_attack = 0.04,
    base_defense = 0.05,
    special = "+Y attack",
    weakness = "Falcon, Eagle, Owl"
  },

  -- More reptiles
  {
    name = "Lizard",
    emoji = "🦎",
    environment = "ground",
    cost = 0.02,
    base_speed = 0.17,  -- m/s
    base_health = 0.12,
    base_attack = 0.03,
    base_defense = 0.04,
    special = "+Y attack",
    weakness = "Eagle, Snake, Cat"
  },
  {
    name = "Chameleon",
    emoji = "🦎",
    environment = "ground",
    cost = 0.02,
    base_speed = 0.01,  -- m/s
    base_health = 0.10,
    base_attack = 0.02,
    base_defense = 0.08,
    special = "+X defense",
    weakness = "Eagle, Snake, Chameleon"
  },
  {
    name = "Komodo Dragon",
    emoji = "🐉",
    environment = "ground",
    cost = 0.05,
    base_speed = 0.13,  -- m/s
    base_health = 0.70,
    base_attack = 0.13,
    base_defense = 0.10,
    special = "+Y attack",
    weakness = "Komodo Dragon, Dragon, Tiger"
  },

  -- More amphibians
  {
    name = "Salamander",
    emoji = "🐸",
    environment = "water",
    cost = 0.01,
    base_speed = 0.01,  -- m/s
    base_health = 0.10,
    base_attack = 0.01,
    base_defense = 0.05,
    special = "+X defense",
    weakness = "Eagle, Snake, Shark"
  },
  {
    name = "Newt",
    emoji = "🐸",
    environment = "water",
    cost = 0.01,
    base_speed = 0.01,  -- m/s
    base_health = 0.08,
    base_attack = 0.01,
    base_defense = 0.04,
    special = "+X defense",
    weakness = "Shark, Eagle, Snake"
  },

  -- More insects and arachnids
  {
    name = "Mosquito",
    emoji = "🦟",
    environment = "air",
    cost = 0.01,
    base_speed = 0.01,  -- m/s
    base_health = 0.03,
    base_attack = 0.02,  -- Blood-sucking
    base_defense = 0.01,
    special = "+Y attack",
    weakness = "Bat, Dragonfly, Eagle"
  },
  {
    name = "Wasp",
    emoji = "🐝",
    environment = "air",
    cost = 0.02,
    base_speed = 0.18,  -- m/s
    base_health = 0.06,
    base_attack = 0.07,  -- Painful sting
    base_defense = 0.03,
    special = "+Y attack",
    weakness = "Eagle, Spider, Wasp"
  },
  {
    name = "Termite",
    emoji = "🐜",
    environment = "air",
    cost = 0.01,
    base_speed = 0.01,  -- m/s
    base_health = 0.04,
    base_attack = 0.01,
    base_defense = 0.08,
    special = "+X defense",
    weakness = "Ant, Eagle, Termite"
  },
  {
    name = "Mantis",
    emoji = "🦗",
    environment = "air",
    cost = 0.03,
    base_speed = 0.02,  -- m/s
    base_health = 0.10,
    base_attack = 0.09,  -- Raptorial forelegs
    base_defense = 0.03,
    special = "+Y attack",
    weakness = "Eagle, Spider, Frog"
  },
  {
    name = "Centipede",
    emoji = "🐛",
    environment = "ground",
    cost = 0.02,
    base_speed = 0.01,  -- m/s
    base_health = 0.08,
    base_attack = 0.06,  -- Venomous bite
    base_defense = 0.04,
    special = "+Y attack",
    weakness = "Eagle, Centipede, Spider"
  },
  {
    name = "Millipede",
    emoji = "🐛",
    environment = "ground",
    cost = 0.02,
    base_speed = 0.01,  -- m/s
    base_health = 0.06,
    base_attack = 0.01,
    base_defense = 0.10,  -- Defensive curling and toxins
    special = "+X defense",
    weakness = "Ant, Beetle, Millipede"
  },

  -- More crustaceans
  {
    name = "Shrimp",
    emoji = "🦐",
    environment = "water",
    cost = 0.01,
    base_speed = 0.05,  -- m/s
    base_health = 0.08,
    base_attack = 0.02,
    base_defense = 0.03,
    special = "+Y attack",
    weakness = "Shark, Crab, Shrimp"
  },
  {
    name = "Hermit Crab",
    emoji = "🦀",
    environment = "water",
    cost = 0.02,
    base_speed = 0.01,  -- m/s
    base_health = 0.15,
    base_attack = 0.03,
    base_defense = 0.10,  -- Borrowed shell protection
    special = "+X defense",
    weakness = "Octopus, Crab, Hermit Crab"
  },

  -- More mollusks
  {
    name = "Clam",
    emoji = "🦪",
    environment = "water",
    cost = 0.02,
    base_speed = 0.01,  -- m/s
    base_health = 0.12,
    base_attack = 0,
    base_defense = 0.12,  -- Hard shell
    special = "+X defense",
    weakness = "Starfish, Crab, Clam"
  },
  {
    name = "Nautilus",
    emoji = "🐙",
    environment = "water",
    cost = 0.02,
    base_speed = 0.01,  -- m/s
    base_health = 0.15,
    base_attack = 0.01,
    base_defense = 0.09,  -- Protective shell
    special = "+X defense",
    weakness = "Shark, Octopus, Nautilus"
  },

  -- Additional animals
  {
    name = "Bat",
    emoji = "🦇",
    environment = "air",
    cost = 0.03,
    base_speed = 1.54,  -- m/s
    base_health = 0.18,
    base_attack = 0.05,
    base_defense = 0.04,
    special = "+Z speed",
    weakness = "Owl, Falcon, Bat"
  },
  {
    name = "Rhinoceros Beetle",
    emoji = "🪲",
    environment = "air",
    cost = 0.03,
    base_speed = 0.03,  -- m/s
    base_health = 0.15,
    base_attack = 0.06,
    base_defense = 0.12,  -- Extremely hard shell
    special = "+X defense",
    weakness = "Ant, Eagle, Rhinoceros Beetle"
  },
  {
    name = "Piranha",
    emoji = "🐟",
    environment = "water",
    cost = 0.04,
    base_speed = 1.15,  -- m/s
    base_health = 0.20,
    base_attack = 0.11,
    base_defense = 0.03,
    special = "+Y attack",
    weakness = "Shark, Dolphin, Piranha"
  },
  {
    name = "Platypus",
    emoji = "🦆",
    environment = "ground",
    cost = 0.03,
    base_speed = 0.25,  -- m/s (swimming)
    base_health = 0.25,
    base_attack = 0.04,  -- Males have venomous spurs
    base_defense = 0.07,
    special = "+Y attack",
    weakness = "Snake, Platypus, Dog"
  },
  {
    name = "Axolotl",
    emoji = "🦎",
    environment = "water",
    cost = 0.02,
    base_speed = 0.01,  -- m/s
    base_health = 0.12,
    base_attack = 0.02,
    base_defense = 0.06,
    special = "+X defense",
    weakness = "Shark, Eagle, Axolotl"
  },
  {
    name = "Pangolin",
    emoji = "🦔",
    environment = "ground",
    cost = 0.04,
    base_speed = 0.21,  -- m/s
    base_health = 0.35,
    base_attack = 0.02,
    base_defense = 0.13,  -- Protective scales
    special = "+X defense",
    weakness = "Tiger, Leopard, Pangolin"
  },
  {
    name = "Manatee",
    emoji = "🦭",
    environment = "water",
    cost = 0.03,
    base_speed = 0.05,  -- m/s
    base_health = 0.60,
    base_attack = 0.01,
    base_defense = 0.09,
    special = "+X defense",
    weakness = "Shark, Manatee, Whale"
  },
  {
    name = "Iguana",
    emoji = "🦎",
    environment = "ground",
    cost = 0.03,
    base_speed = 0.17,  -- m/s
    base_health = 0.25,
    base_attack = 0.05,  -- Strong tail and claws
    base_defense = 0.06,
    special = "+Y attack",
    weakness = "Eagle, Snake, Iguana"
  },
  {
    name = "Tarantula",
    emoji = "🕷️",
    environment = "ground",
    cost = 0.03,
    base_speed = 0.01,  -- m/s
    base_health = 0.12,
    base_attack = 0.07,  -- Venomous bite
    base_defense = 0.06,
    special = "+Y attack",
    weakness = "Wasp, Eagle, Tarantula"
  },
  {
    name = "Vulture",
    emoji = "🦅",
    environment = "air",
    cost = 0.04,
    base_speed = 3.08,  -- m/s
    base_health = 0.35,
    base_attack = 0.05,
    base_defense = 0.06,
    special = "+Z speed",
    weakness = "Eagle, Falcon, Vulture"
  },

  -- Extinct animals
  {
    name = "T-Rex",
    emoji = "🦖",
    environment = "ground",
    cost = 0.08,
    base_speed = 0.21,  -- m/s
    base_health = 1.00,
    base_attack = 0.18,
    base_defense = 0.10,
    special = "+Y attack",
    weakness = "T-Rex, Dragon, Kraken"
  },
  {
    name = "Triceratops",
    emoji = "🦕",
    environment = "ground",
    cost = 0.06,
    base_speed = 0.16,  -- m/s
    base_health = 0.90,
    base_attack = 0.08,
    base_defense = 0.15,
    special = "+X defense",
    weakness = "T-Rex, Triceratops, Brontosaurus"
  },
  {
    name = "Velociraptor",
    emoji = "🦕",
    environment = "ground",
    cost = 0.05,
    base_speed = 1.64,  -- m/s
    base_health = 0.55,
    base_attack = 0.12,
    base_defense = 0.05,
    special = "+Y attack, +Z speed",
    weakness = "T-Rex, Velociraptor, Tiger"
  },
  {
    name = "Brontosaurus",
    emoji = "🦕",
    environment = "ground",
    cost = 0.06,
    base_speed = 0.10,  -- m/s
    base_health = 0.95,
    base_attack = 0.06,
    base_defense = 0.14,
    special = "+X defense",
    weakness = "T-Rex, Brontosaurus, Triceratops"
  },
  {
    name = "Mammoth",
    emoji = "🦣",
    environment = "ground",
    cost = 0.05,
    base_speed = 0.18,  -- m/s
    base_health = 0.85,
    base_attack = 0.09,
    base_defense = 0.12,
    special = "+X defense",
    weakness = "Tiger, Mammoth, Elephant"
  },
  {
    name = "Sabertooth Tiger",
    emoji = "🐅",
    environment = "ground",
    cost = 0.06,
    base_speed = 1.28,  -- m/s
    base_health = 0.75,
    base_attack = 0.16,
    base_defense = 0.07,
    special = "+Y attack",
    weakness = "Sabertooth Tiger, Tiger, Lion"
  },
  {
    name = "Dodo",
    emoji = "🦤",
    environment = "air",
    cost = 0.01,
    base_speed = 0.06,  -- m/s
    base_health = 0.15,
    base_attack = 0.01,
    base_defense = 0.03,
    special = "",
    weakness = "Dodo, Falcon, Eagle"
  },
  {
    name = "Megalodon",
    emoji = "🦈",
    environment = "water",
    cost = 0.08,
    base_speed = 1.28,  -- m/s
    base_health = 0.95,
    base_attack = 0.19,
    base_defense = 0.11,
    special = "+Y attack",
    weakness = "Megalodon, Kraken"
  },

  -- Mythological animals
  {
    name = "Dragon",
    emoji = "🐉",
    environment = "air",
    cost = 0.10,
    base_speed = 3.85,  -- m/s (flying)
    base_health = 1.00,
    base_attack = 0.20,
    base_defense = 0.16,
    special = "+Y attack, +Z speed",
    weakness = "Dragon, Kraken, Unicorn"
  },
  {
    name = "Unicorn",
    emoji = "🦄",
    environment = "ground",
    cost = 0.04,
    base_speed = 1.79,  -- m/s
    base_health = 0.50,
    base_attack = 0.07,
    base_defense = 0.09,
    special = "+Z speed",
    weakness = "Unicorn, Dragon"
  },
  {
    name = "Kraken",
    emoji = "🐙",
    environment = "water",
    cost = 0.08,
    base_speed = 0.21,  -- m/s (swimming)
    base_health = 1.00,
    base_attack = 0.17,
    base_defense = 0.14,
    special = "+Y attack",
    weakness = "Kraken, Dragon"
  }
}

local animals = base_animals_list
-- /home/s1eep1ess/workspace/lua/echeckers/game/assets/biomes.lua
local biomes = {
    [1] = {
        name = 'Desert',
        color = '#dddd00',
        effect = '-5% speed [ground] [enemy]'
    },
    [2] = {
        name = 'Forest',
        color = '#228B22',
        effect = '+5% defense [ground]'
    },
    [3] = {
        name = 'Mountain',
        color = '#808080',
        effect = '+5% attack [air]'
    },
    [4] = {
        name = 'Ocean',
        color = '#4646FF',
        effect = '+5% attack [water]'
    },
    [5] = {
        name = 'Tundra',
        color = '#ADD8E6',
        effect = '-5% speed [enemy]'
    },
    [6] = {
        name = 'Swamp',
        color = '#556B2F',
        effect = '+5% defense [water]'
    },
    [7] = {
        name = 'Volcano',
        color = 'FF551700',
        effect = '-5% defense [ground]'
    },
    [8] = {
        name = 'Jungle',
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

-- /home/s1eep1ess/workspace/lua/echeckers/game/assets/buildings.lua
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

-- /home/s1eep1ess/workspace/lua/echeckers/game/assets/items.lua
--food
--weapons
-- anything that can change attack, speed or defense
-- /home/s1eep1ess/workspace/lua/echeckers/game/battle/functions/random_deck_generator.lua
local random = math.random

local function generate_random_deck()
    local deck = {}

    local index
    for i=1, DECK_SIZE do
        index = random(1, #animals)
        deck[i] = animals[index]
    end

    return deck
end


-- /home/s1eep1ess/workspace/lua/echeckers/game/battle/functions/get_random_biomes.lua
local random = math.random

local function get_random_biomes()
    local _selected_biomes = {}
    local max_biomes = 6

    local index
    for i=1, max_biomes do
        index = random(1, #biomes)
        _selected_biomes[i] = biomes[index]
    end

    return _selected_biomes
end
-- /home/s1eep1ess/workspace/lua/echeckers/game/battle/functions/card_processor.lua
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
-- /home/s1eep1ess/workspace/lua/echeckers/game/battle/functions/draw_card.lua
local _draw_card = function(turn)
    if #Decks[turn] == 0 then
        UI.display('No cards on deck, skipping')
        return
    end

    local idx = 1
    local deck_size = #Decks[turn]

    Hands[turn][(#Hands[turn])+1] = process_card(Decks[turn][idx])

    -- O(1) removal: swap with last element instead of shifting
    if deck_size > 0 then
        Decks[turn][idx] = Decks[turn][deck_size]
        Decks[turn][deck_size] = nil
    end
end
-- /home/s1eep1ess/workspace/lua/echeckers/game/battle/functions/select_deck.lua

-- /home/s1eep1ess/workspace/lua/echeckers/game/battle/functions/update_players.lua
-- Update when player joins the room

-- /home/s1eep1ess/workspace/lua/echeckers/game/battle/board/board.lua
--- Board module - flat table structure
-- Uses globals: Player_turn, Board
-- NOTE: This file is concatenated in build - module available to subsequent files
-- Index mapping:
--   1-6:  Player 2 fields
--   7-12: Player 1 fields

local boardModule = {}

--- Get field index for player
-- @param player number (1 or 2)
-- @param index number (1-6)
-- @return number Flat table index
function boardModule.field_index(player, index)
    if player == 1 then
        return 7 + index - 1
    else
        return 1 + index - 1
    end
end

--- Get player from field index
-- @param index number (1-12)
-- @return number Player (1 or 2)
function boardModule.field_player(index)
    if index <= 6 then return 2 end
    return 1
end

--- Get field slot (1-6) from flat index
-- @param index number (1-12)
-- @return number Field slot
function boardModule.field_slot(index)
    if index <= 6 then return index end
    return index - 6
end

--- Initialize board with flat structure
-- @param fields_p1 table Player 1's fields (array of 6)
-- @param fields_p2 table Player 2's fields (array of 6)
-- @return table Board instance
function boardModule.init(fields_p1, fields_p2)
    local board = {}

    -- Fields: {def, card}
    -- P2 fields (1-6), P1 fields (7-12)
    for i = 1, 6 do
        board[i] = { def = fields_p2[i], card = nil }
        board[i + 6] = { def = fields_p1[i], card = nil }
    end

    -- Special zones
    board.deck_p2 = 'Deck'
    board.trash_p2 = 'Trash'
    board.deck_p1 = 'Deck'
    board.trash_p1 = 'Trash'
    board.life_p2 = 2000
    board.biomatter_p2 = 3
    board.life_p1 = 2000
    board.biomatter_p1 = 3

    return board
end

--- Get field by player and slot
-- Uses global: Player_turn
-- @param slot number (1-6)
-- @return table|nil Field {def, card}
function boardModule.get_field(slot)
    if not Board then return nil end
    local idx = boardModule.field_index(Player_turn, slot)
    return Board[idx]
end

--- Set field card
-- Uses global: Player_turn
-- @param slot number (1-6)
-- @param card table|nil
function boardModule.set_field_card(slot, card)
    local field = boardModule.get_field(slot)
    if field then
        field.card = card
    end
end

--- Get visual layout row for UI
-- @param player number (1 or 2)
-- @return table Layout row (10 cells)
function boardModule.get_layout_row(player)
    if not Board then return {} end

    if player == 2 then
        -- P2 row: fields 1-3, Deck, Trash, fields 4-6, LIFE, BIOMATTER
        return {
            Board[1], Board[2], Board[3],
            Board.deck_p2, Board.trash_p2,
            Board[4], Board[5], Board[6],
            Board.life_p2, Board.biomatter_p2
        }
    else
        -- P1 row: fields 1-3, LIFE, BIOMATTER, fields 4-6, Deck, Trash
        return {
            Board[7], Board[8], Board[9],
            Board.life_p1, Board.biomatter_p1,
            Board[10], Board[11], Board[12],
            Board.deck_p1, Board.trash_p1
        }
    end
end

--- Get middle layout row
-- @return table Middle row (5 cells)
function boardModule.get_middle_row()
    return { '', 'SETUP', '', '', '' }
end

--- Swap two fields
-- Uses global: Player_turn
-- @param slot1 number (1-6)
-- @param slot2 number (1-6)
function boardModule.swap_fields(slot1, slot2)
    local idx1 = boardModule.field_index(Player_turn, slot1)
    local idx2 = boardModule.field_index(Player_turn, slot2)
    Board[idx1], Board[idx2] = Board[idx2], Board[idx1]
end

-- Module is local, available to files after this in build order
-- No export needed - files are concatenated in build_battle.txt

-- /home/s1eep1ess/workspace/lua/echeckers/game/battle/board/fields.lua
--- Fields operations module
-- Works with flat board structure
-- Uses globals: Player_turn, Board, boardModule
-- NOTE: This file is concatenated in build - module available to subsequent files

local fieldsOps = {}

--- Check if field has no card
-- Uses globals: Player_turn, Board, boardModule
-- @param slot number (1-6)
-- @return boolean
function fieldsOps.is_empty(slot)
    local field = boardModule.get_field(slot)
    return not field or field.card == nil
end

--- Place card on field
-- Uses globals: Player_turn, Board, boardModule
-- @param slot number (1-6)
-- @param card table
function fieldsOps.set_card(slot, card)
    boardModule.set_field_card(slot, card)
end

--- Remove card from field
-- Uses globals: Player_turn, Board, boardModule
-- @param slot number (1-6)
-- @return table|nil Removed card
function fieldsOps.remove_card(slot)
    local field = boardModule.get_field(slot)
    if not field or not field.card then return nil end

    local removed = field.card
    field.card = nil
    return removed
end

--- Swap two fields
-- Uses globals: Player_turn, Board, boardModule
-- @param from number (1-6)
-- @param to number (1-6)
function fieldsOps.move(from, to)
    if from == to then return end
    boardModule.swap_fields(from, to)
end

--- Get card on field
-- Uses globals: Player_turn, Board, boardModule
-- @param slot number (1-6)
-- @return table|nil
function fieldsOps.get_card(slot)
    local field = boardModule.get_field(slot)
    return field and field.card
end

--- Get field definition
-- Uses globals: Player_turn, Board, boardModule
-- @param slot number (1-6)
-- @return table|nil
function fieldsOps.get_def(slot)
    local field = boardModule.get_field(slot)
    return field and field.def
end

-- Module is local, available to files after this in build order
-- No export needed - files are concatenated in build_battle.txt

-- /home/s1eep1ess/workspace/lua/echeckers/game/battle/validation/2_standby_validation.lua
--- Validation for standby phase operations
-- Uses global state directly (Player_turn, Hands, Board)
-- Functions do not receive arguments except indices

local standbyValidation = {}

--- Validate field index is in range 1-6
-- @param index number Field slot to validate
-- @return boolean True if valid
function standbyValidation.valid_field_index(index)
    return type(index) == 'number' and index >= 1 and index <= 6
end

--- Validate set animal operation
-- Uses globals: Player_turn, Hands, Board
-- @param hand_index number Index in current player's hand
-- @param field_index number Field slot (1-6)
-- @return boolean valid
-- @return string|nil error message
function standbyValidation.validate_set_card(hand_index, field_index)
    -- Validate field index
    if not standbyValidation.valid_field_index(field_index) then
        return false, 'Invalid field index (1-6)'
    end
    
    -- Validate board initialized
    if not Board then
        return false, 'Board not initialized'
    end
    
    -- Validate hand and card
    local hand = Hands[Player_turn]
    if not hand or not hand[hand_index] then
        return false, 'Invalid card in hand'
    end
    
    -- Validate field is empty
    if not fieldsOps.is_empty(field_index) then
        return false, 'Field already occupied'
    end

    return true
end

--- Validate remove animal operation
-- Uses globals: Player_turn, Board, fieldsOps
-- @param field_index number Field slot (1-6)
-- @return boolean valid
-- @return string|nil error message
function standbyValidation.validate_remove_card(field_index)
    -- Validate field index
    if not standbyValidation.valid_field_index(field_index) then
        return false, 'Invalid field index (1-6)'
    end

    -- Validate board initialized
    if not Board then
        return false, 'Board not initialized'
    end

    -- Validate field has animal
    if fieldsOps.is_empty(field_index) then
        return false, 'No animal on field'
    end
    
    return true
end

--- Validate field move (swap positions) operation
-- Uses globals: Player_turn, Board
-- @param from_field number Source field slot (1-6)
-- @param to_field number Destination field slot (1-6)
-- @return boolean valid
-- @return string|nil error message
function standbyValidation.validate_field_move(from_field, to_field)
    -- Validate field indices
    if not standbyValidation.valid_field_index(from_field) then
        return false, 'Invalid source field (1-6)'
    end
    if not standbyValidation.valid_field_index(to_field) then
        return false, 'Invalid destination field (1-6)'
    end
    
    -- Validate different fields
    if from_field == to_field then
        return false, 'Source and destination must differ'
    end
    
    -- Validate board initialized
    if not Board then
        return false, 'Board not initialized'
    end
    
    return true
end

-- /home/s1eep1ess/workspace/lua/echeckers/game/battle/phases/0_setup.lua
--[[
This file should be called when duel starts
Fields, decks and items should be saved as globals
The rest should be unloaded
]]

local function _setup_fields()
    Fields = {}
    Fields[1] = get_random_fields()
    Fields[2] = get_random_fields()
end

local function _setup_decks()
    Decks = { true, true }
    Decks[1] = generate_random_deck()
    Decks[2] = generate_random_deck()
end

local function _setup_items()
    return
end

local function _setup_starter()
    if math.random(1, 2) == 1 then
        UI.display('Player 1 goes 1st')
        Player_turn = 1
        return
    end

    UI.display('Player 2 goes 1st')
    Player_turn = 2
end

local function _setup_board(MODE)
    if MODE == 'basic' then
        Board = boardModule.init(Fields[1], Fields[2])
    end
end

local function _setup_hands()
    if MODE == 'basic' then
        Hands = {}
        Hands[1] = {}
        Hands[2] = {}

        for i = 1, 2 do
            for j = 1, HAND_SIZE do
                _draw_card(i)
            end
        end
    end
end

local function _setup_ui()
    UI.update_hand(Hands[2], 'hidden')
    UI.update_board(Board)
    UI.update_hand(Hands[1])
end

local _setup_trash = function()
    Trash = { {}, {} }
end

local function setup()
    if MODE == 'basic' then
        _setup_fields()
        _setup_decks()
        _setup_starter()
        _setup_board(MODE)
        _setup_hands()
        _setup_trash()
        _setup_ui()
    end

    if MODE == 'elemental' then
        return 2
    end

    if MODE == 'astrological' then
        return 3
    end

    if MODE == 'advanced' then
        return 4
    end
end

-- /home/s1eep1ess/workspace/lua/echeckers/game/battle/phases/1_draw_phase.lua
local _update_ui = function ()
    -- Each player should not see the other hand
    UI.update_hand(Hands[2], 'hidden')
    UI.update_board(Board)
    UI.update_hand(Hands[1])
end

local _discard = function ()
    if #Hands[Player_turn] > HAND_LIMIT then
        UI.display("Discard one card (not yet implemented)")
    end
end

local draw = function ()
    if MODE == 'basic' then
        _draw_card(Player_turn)
        _update_ui()
        return
    end
end
-- /home/s1eep1ess/workspace/lua/echeckers/game/battle/phases/2_standby_phase.lua
-- Skip standby phase
local _skip_standby = function ()
    UI.display("Skipped Standby turn")
    return 0
end

--- Send current hand to deck and draw a new hand of same size
-- Uses globals: Player_turn, Hands, Decks
-- @return number 0 on success
local _shuffle_hand = function()
    local hand = Hands[Player_turn]
    local deck = Decks[Player_turn]
    local hand_size = #hand

    -- Return all cards from hand to deck
    for i = 1, hand_size do
        deck[#deck + 1] = hand[i]
    end

    -- Draw new cards, overwriting existing indices
    for i = 1, hand_size do
        _draw_card(Player_turn)
        hand[i] = hand[#hand]
    end

    return 0
end

--- Place a card from hand onto a field
-- Uses globals: Player_turn, Hands, Board
-- @param hand_index number Index in hand (1-4)
-- @param field_index number Field slot (1-6)
-- @return boolean Success
local _set_card = function(hand_index, field_index)
    hand_index = hand_index or 1
    field_index = field_index or 1

    local hand = Hands[Player_turn]
    local len = #hand
    local card = hand[hand_index]

    local valid, err = standbyValidation.validate_set_card(hand_index, field_index)
    if not valid then
        UI.display('Invalid move: ' .. err)
        return false
    end

    fieldsOps.set_card(field_index, card)

    -- Remove card from hand by swapping with last element
    if hand_index < len then
        hand[hand_index] = hand[len]
    end
    hand[len] = nil

    return true
end

--- Remove a card from a field and send it to trash
-- Uses globals: Player_turn, Hands, Board
-- @param field_index number Field slot (1-6)
-- @return boolean Success
local _remove_card = function(field_index)
    field_index = field_index or 1

    local trash = Trash[Player_turn]

    local valid, err = standbyValidation.validate_remove_card(field_index)
    if not valid then
        UI.display('Invalid move: ' .. err)
        return false
    end

    local removed = fieldsOps.remove_card(field_index)
    if removed then
        trash[#trash + 1] = removed
    end

    return true
end

--- Move a card from one field to another (swap positions)
-- Uses globals: Player_turn, Board, fieldsOps, UI, standbyValidation
-- @param from_field number Source field slot (1-6)
-- @param to_field number Destination field slot (1-6)
-- @return boolean Success
local _move_card = function(from_field, to_field)
    from_field = from_field or 1
    to_field = to_field or 2

    -- Validate source field has a card
    if fieldsOps.is_empty(from_field) then
        UI.display('Invalid move: No card on source field')
        return false
    end

    -- Validate destination field is empty and index is valid
    if fieldsOps.is_empty(to_field) == false then
        UI.display('Invalid move: Destination field is occupied')
        return false
    end

    if not standbyValidation.valid_field_index(to_field) then
        UI.display('Invalid move: Destination field must be 1-6')
        return false
    end

    if from_field == to_field then
        UI.display('Invalid move: Source and destination must differ')
        return false
    end

    fieldsOps.move(from_field, to_field)
    return true
end

--- Move/swap two fields (change their positions)
-- Uses globals: Player_turn, Board
-- @param from_field number Source field slot (1-6)
-- @param to_field number Destination field slot (1-6)
-- @return boolean Success
local _move_field = function(from_field, to_field)
    from_field = from_field or 1
    to_field = to_field or 2

    local valid, err = standbyValidation.validate_field_move(from_field, to_field)
    if not valid then
        UI.display('Invalid move: ' .. err)
        return false
    end

    return fieldsOps.move(from_field, to_field)
end

--- Update UI display
local _update_ui = function()
    UI.update_hand(Hands[2], 'hidden')
    UI.update_board(Board)
    UI.update_hand(Hands[1])
end

-- Action options and handlers (file-level constants)
local options = { 'Set Card', 'Move Card', 'Remove Card',
                  'Move Field', 'Shuffle Hand', 'Skip Phase' }
local actions = { _set_card, _move_card, _remove_card,
                  _move_field, _shuffle_hand, _skip_standby }

--- Standby phase - player action phase
-- Uses globals: Player_turn, Hands, Board, UI, BUILD
-- Players can set cards, remove cards, move cards, or move fields
-- NOTE: This file is concatenated in build - do NOT return at file end
local standby = function()
    -- Build menu output using string concatenation
    local output = "\nStandby Phase - Player " .. Player_turn ..
        "\n\nSelect Action:\n" ..
        "  [1] " .. options[1] .. "\n" ..
        "  [2] " .. options[2] .. "\n" ..
        "  [3] " .. options[3] .. "\n" ..
        "  [4] " .. options[4] .. "\n" ..
        "  [5] " .. options[5] .. "\n" ..
        "  [6] " .. options[6] .. "\n"

    UI.update_menu(output)
    _update_ui()

    -- Get player input (1-6)
    local input = 1  -- Default placeholder
    if BUILD == 'TUI' then
        -- TODO: Integrate with UI.input() for actual input
    end

    -- Validate input and execute selected action
    local action_count = #actions
    if input >= 1 and input <= action_count then
        -- Execute action with default parameters
        -- TODO: Pass actual parameters from user input
        actions[input]()
        _update_ui()
        return
    end

    UI.display('Invalid selection')
end
-- DO NOT add 'return standby' - this file is concatenated in build process

-- /home/s1eep1ess/workspace/lua/echeckers/game/battle/phases/3_battle_phase.lua
-- Must be automatic,
-- Air attacks Air, ground attacks ground and etc.




-- Apply biomes buffs
-- Apply Items buffs
-- Apply Buildings items
-- Apply class buffs
-- Use attack X defense,  

-- /home/s1eep1ess/workspace/lua/echeckers/game/battle/phases/4_end_phase.lua
-- cards in hand > 6, discard 
-- /home/s1eep1ess/workspace/lua/echeckers/game/battle/ui/tui_colors.lua
--- Convert hex color to RGB values
---@param hex string Hex color string (e.g., '#dddd00' or 'FF551700')
---@return number r, number g, number b
local function hex_to_rgb(hex)
    hex = hex:gsub('^#', '')
    if #hex == 8 then
        hex = hex:sub(3)  -- ARGB format
    end
    local r = tonumber(hex:sub(1, 2), 16) or 0
    local g = tonumber(hex:sub(3, 4), 16) or 0
    local b = tonumber(hex:sub(5, 6), 16) or 0
    return r, g, b
end

--- Convert RGB to ANSI 256-color code
---@param r number Red (0-255)
---@param g number Green (0-255)
---@param b number Blue (0-255)
---@return number ANSI color code (0-255)
local function rgb_to_ansi256(r, g, b)
    local r6 = math.floor((r / 256) * 6)
    local g6 = math.floor((g / 256) * 6)
    local b6 = math.floor((b / 256) * 6)
    return 16 + (r6 * 36) + (g6 * 6) + b6
end

--- Build ANSI escape sequences from color code
---@param color number|string ANSI code (0-255) or hex string
---@return string bg_ansi, string fg_ansi
local function build_cell_colors(color)
    local bg_ansi
    if type(color) == 'number' then
        bg_ansi = string.format('\27[48;5;%dm', color)
    else
        local r, g, b = hex_to_rgb(color)
        local code = rgb_to_ansi256(r, g, b)
        bg_ansi = string.format('\27[48;5;%dm', code)
    end
    return bg_ansi, '\27[38;5;15m'
end

local function format_emoji_field(emoji)
    if not emoji then return '❓' end

    local emoji_padding_overrides = {
        ['🦣'] = '🦣 ',
        ['🪲'] = '🪲 ',
        ['🕷️'] = '🕷️ ',
        ['⭐'] = '⭐',
        ['🪰'] = '🪰 ',
        ['🦭'] = '🦭 ',
        ['🐻'] = '🐻',
        ['🪼'] = '🪼 ',
        ['🦤'] = '🦤 ',
        ['🦈'] = '🦈'
    }

    return emoji_padding_overrides[emoji] or emoji
end
-- /home/s1eep1ess/workspace/lua/echeckers/game/battle/ui/UI.display.lua
-- @2, 
_TUI_display = function(message, separator)
    separator = separator or ''
    if type(message) == "table" then
        table.print(message,false,false,false,false,separator)
        return
    end

    print(message)
end

UI.display = function(message, separator)
    if BUILD == 'TUI' then
        _TUI_display(message, separator)
    end
end
-- /home/s1eep1ess/workspace/lua/echeckers/game/battle/ui/UI.input.lua
-- Ask for input in the format:
-- {input_type, input_prompt}
_TUI_input = function (input_handler, is_menu)

    if is_menu then
        --[[
            [Menu name] <- arg_1 
            [option_1] <- arg_2
            [Pick an option]
            ...

            return selection
        ]]
        return
    end

    if type(input_handler) ~="table" then
        _TUI_display("You must provide a table")
    end

    local input_type = input_handler[1]
    local input_prompt = input_handler[2]

    _TUI_display(input_prompt)
    if input_type == "number" then
        return io.read('n')
    end

    return io.read(1,30)
end

UI.input = function(input_handler, is_menu)
    if BUILD == 'TUI' then
        _TUI_display(input_handler, is_menu)
    end
end
-- /home/s1eep1ess/workspace/lua/echeckers/game/battle/ui/UI.update_board.lua
--- Center text ignoring ANSI escape codes
---@param text string
---@param width number
---@return string
local function center_ansi(text, width)
    text = tostring(text)
    local clean = text:gsub('\27%[[%d;]*m', '')
    local padding = width - #clean
    if padding <= 0 then return text end
    local left = math.floor(padding / 2)
    return string.rep(' ', left) .. text .. string.rep(' ', padding - left)
end

--- Render board with styling
local function _TUI_update_board(board)
    local ANSI_RESET = '\27[0m'
    local GREY_ROW3 = 235
    local DECK_COLOR = 238
    local BIOMATTER_COLOR = 226
    local HEALTH_COLOR = 22
    local TRASH_COLOR = 94
    local CELL_SIZES = {14, 14, 14, 16, 16}

    local CELL_COLORS = {
        [1] = {nil, nil, nil, DECK_COLOR, TRASH_COLOR},
        [2] = {nil, nil, nil, HEALTH_COLOR, BIOMATTER_COLOR},
        [3] = {GREY_ROW3, GREY_ROW3, GREY_ROW3, GREY_ROW3, GREY_ROW3},
        [4] = {nil, nil, nil, HEALTH_COLOR, BIOMATTER_COLOR},
        [5] = {nil, nil, nil, DECK_COLOR, TRASH_COLOR},
    }

    local grey_bg = '\27[48;5;235m'
    local sep_bg, sep_fg = build_cell_colors(GREY_ROW3)
    local separator = sep_bg .. sep_fg .. ' ' .. ANSI_RESET

    local function build_colored_text(text, color)
        local bg, fg = build_cell_colors(color)
        return bg .. fg .. text .. ANSI_RESET
    end

    local VISUAL_MAP = {
        [1] = {row_func = 'get_layout_row', player = 2, cols = {1, 2, 3, 4, 5}},
        [2] = {row_func = 'get_layout_row', player = 2, cols = {6, 7, 8, 9, 10}},
        [3] = {row_func = 'get_middle_row', cols = {1, 2, 3, 4, 5}},
        [4] = {row_func = 'get_layout_row', player = 1, cols = {1, 2, 3, 4, 5}},
        [5] = {row_func = 'get_layout_row', player = 1, cols = {6, 7, 8, 9, 10}},
    }

    local board_width = 2
    for i = 1, 5 do
        board_width = board_width + CELL_SIZES[i]
    end

    local border_line = sep_bg .. sep_fg .. string.rep(' ', board_width) .. ANSI_RESET
    local lines = {border_line}

    -- Cell content extraction: returns {text, color, is_card}
    local cell_extractors = {
        -- Animal on biome: {def, animal}
        function(cell)
            if cell.animal and cell.animal.name then
                return format_emoji_field(cell.animal.emoji or cell.animal.name),
                       cell.def.color, true
            end
        end,
        -- Biome definition
        function(cell)
            if cell.def and cell.def.name then
                return center_ansi(cell.def.name, CELL_SIZES[1]), cell.def.color, false
            end
        end,
        -- Empty/occupied state
        function(cell)
            if cell.def then
                return center_ansi(cell.animal and 'occupied' or 'empty', CELL_SIZES[1]), nil, false
            end
        end,
        -- Plain table with name
        function(cell)
            if cell.name then
                return center_ansi(cell.name, CELL_SIZES[1]), nil, false
            end
        end,
    }

    local function get_cell_content(cell, row, col)
        -- String cells: use CELL_COLORS
        if type(cell) ~= 'table' then
            return center_ansi(cell or '', CELL_SIZES[col]), CELL_COLORS[row][col], false
        end

        -- Table cells: use extractors
        local size = #cell_extractors
        for i = 1, size do
            local text, color, is_card = cell_extractors[i](cell)
            if text then return text, color, is_card end
        end

        return center_ansi(tostring(cell), CELL_SIZES[col]), nil, false
    end

    local function render_cell(row, col, cell)
        local text, color, is_card = get_cell_content(cell, row, col)
        local cell_size = CELL_SIZES[col]

        if is_card then
            local padding = cell_size - 2
            local left = math.floor(padding / 2)
            if color then
                local bg, fg = build_cell_colors(color)
                return bg .. fg .. string.rep(' ', left) .. grey_bg .. text .. ANSI_RESET ..
                       bg .. fg .. string.rep(' ', padding - left) .. ANSI_RESET
            end
            return grey_bg .. text .. ANSI_RESET
        end

        if color then
            return build_colored_text(text, color)
        end

        return text .. ANSI_RESET
    end

    for visual_row = 1, 5 do
        local row_parts = {separator}
        local mapping = VISUAL_MAP[visual_row]
        local layout_row

        if mapping.row_func == 'get_layout_row' then
            layout_row = boardModule.get_layout_row(mapping.player)
        else
            layout_row = boardModule.get_middle_row()
        end

        for col = 1, 5 do
            local cell = layout_row and layout_row[mapping.cols[col]]
            row_parts[col + 1] = render_cell(visual_row, col, cell)
        end

        row_parts[7] = separator
        lines[visual_row + 1] = table.concat(row_parts)
    end

    lines[7] = border_line
    print('\n' .. table.concat(lines, '\n') .. '\n')
end

---@diagnostic disable-next-line: duplicate-set-field
UI.update_board = function(board)
    if BUILD == 'TUI' then
        _TUI_update_board(board)
    end
end

-- /home/s1eep1ess/workspace/lua/echeckers/game/battle/ui/UI.update_hand.lua
---@diagnostic disable: duplicate-set-field
local function _build_hidden_hand(hand, start_index, end_index, show_prev, show_next, hand_bg, hand_fg, nav_bg, nav_fg, ANSI_RESET)
    local hidden_card = hand_bg .. hand_fg .. '🂠' .. ANSI_RESET
    local card_sep = '  '
    local nav_prev = nav_bg .. nav_fg .. '[<<]' .. ANSI_RESET .. card_sep
    local nav_next = card_sep .. nav_bg .. nav_fg .. '[>>]' .. ANSI_RESET

    local cards = {}
    for i = start_index, end_index do
        cards[#cards + 1] = hidden_card
    end

    return (show_prev and nav_prev or '') .. table.concat(cards, card_sep) .. (show_next and nav_next or '')
end

local function _build_card_lines(card, wrap_empty, side_border, card_prefix, card_suffix, hand_bg, hand_fg, cost_fg, health_fg, speed_fg, attack_fg, defense_fg, ANSI_RESET)
    local name = card.name or ''
    if #name > 10 then name = name:sub(1, 10) end
    local name_centered = string.center(name, 13)
    local emoji_field = format_emoji_field(card.emoji or '❓')
    local cost = card.cost or 0
    local health = card.health or 0
    local speed = card.speed or 0
    local attack = card.attack or 0
    local defense = card.defense or 0

    return {
        wrap_empty,
        side_border .. hand_bg .. hand_fg .. name_centered .. ANSI_RESET .. side_border,
        side_border .. hand_bg .. string.rep(' ', 13) .. ANSI_RESET .. side_border,
        card_prefix .. string.format('  %s%s%8d ', emoji_field, cost_fg, cost) .. card_suffix,
        card_prefix .. string.format('%s%4d  %s%6d ', health_fg, health, speed_fg, speed) .. card_suffix,
        card_prefix .. string.format('%s%4d  %s%6d ', attack_fg, attack, defense_fg, defense) .. card_suffix,
        wrap_empty,
    }
end

local function _apply_navigation(lines, nav_prefix, nav_suffix, show_prev, show_next)
    if show_prev then
        lines[4][#lines[4] + 1] = nav_prefix .. '  '
    end
    if show_next then
        lines[4][#lines[4] + 1] = '  ' .. nav_suffix
    end
    return lines
end

local function _TUI_update_hand(hand, is_hidden, start_index, end_index)
    local ANSI_RESET = '\27[0m'
    local HAND_BACKGROUND = 235
    local CARD_PADDING_COLOR = 245
    local NAV_COLOR = 22
    local COST_COLOR = 226
    local HEALTH_COLOR = 46
    local SPEED_COLOR = 159
    local ATTACK_COLOR = 160
    local DEFENSE_COLOR = 17

    local hand_bg, hand_fg = build_cell_colors(HAND_BACKGROUND)
    local padding_bg, padding_fg = build_cell_colors(CARD_PADDING_COLOR)
    local nav_bg, nav_fg = build_cell_colors(NAV_COLOR)
    local cost_fg = '\27[38;5;' .. COST_COLOR .. 'm'
    local health_fg = '\27[38;5;' .. HEALTH_COLOR .. 'm'
    local speed_fg = '\27[38;5;' .. SPEED_COLOR .. 'm'
    local attack_fg = '\27[38;5;' .. ATTACK_COLOR .. 'm'
    local defense_fg = '\27[38;5;' .. DEFENSE_COLOR .. 'm'

    start_index = start_index or 1
    end_index = end_index or math.min(4, #hand)

    local show_prev = start_index > 1
    local show_next = end_index < #hand

    if is_hidden == "hidden" then
        print(_build_hidden_hand(hand, start_index, end_index, show_prev, show_next, hand_bg, hand_fg, nav_bg, nav_fg, ANSI_RESET))
        return
    end

    local lines = { {}, {}, {}, {}, {}, {}, {} }
    local card_count = 0

    local card_prefix = padding_bg .. padding_fg .. ' ' .. ANSI_RESET .. hand_bg .. hand_fg
    local card_suffix = ANSI_RESET .. padding_bg .. padding_fg .. ' ' .. ANSI_RESET
    local nav_prefix = nav_bg .. nav_fg .. '[<<]' .. ANSI_RESET .. '  '
    local nav_suffix = '  ' .. nav_bg .. nav_fg .. '[>>]' .. ANSI_RESET
    local card_sep = '  '
    local wrap_empty = padding_bg .. string.rep(' ', 15) .. ANSI_RESET
    local side_border = padding_bg .. padding_fg .. ' ' .. ANSI_RESET

    for i = start_index, end_index do
        if card_count > 0 then
            for l = 1, 7 do
                lines[l][#lines[l] + 1] = card_sep
            end
        end

        local card_lines = _build_card_lines(hand[i], wrap_empty, side_border, card_prefix, card_suffix, hand_bg, hand_fg, cost_fg, health_fg, speed_fg, attack_fg, defense_fg, ANSI_RESET)

        for l = 1, 7 do
            lines[l][#lines[l] + 1] = card_lines[l]
        end

        card_count = card_count + 1
    end

    lines = _apply_navigation(lines, nav_prefix, nav_suffix, show_prev, show_next)

    for l = 1, 7 do
        lines[l] = table.concat(lines[l])
    end

    print(table.concat(lines, '\n') .. '\n')
end

UI.update_hand = function(hand, is_hidden, start_index, end_index)
    if BUILD == 'TUI' then
        _TUI_update_hand(hand, is_hidden, start_index, end_index)
    end
end

-- /home/s1eep1ess/workspace/lua/echeckers/game/battle/decks/default.lua
DECK = {
	-- Max: 100 cartas
	basic = {
		{"red","n0"},
		{"red","n1"},{"red","n2"},{"red","n3"},{"red","n4"},{"red","n5"},{"red","n6"},{"red","n7"},{"red","n8"},{"red","n9"},
		{"red","n1"},{"red","n2"},{"red","n3"},{"red","n4"},{"red","n5"},{"red","n6"},{"red","n7"},{"red","n8"},{"red","n9"},
		{"red","draw2"},{"red","draw2"},{"red","skip"},{"red","skip"},{"red","reverse"},{"red","reverse"},
		{"blue","n0"},
		{"blue","n1"},{"blue","n2"},{"blue","n3"},{"blue","n4"},{"blue","n5"},{"blue","n6"},{"blue","n7"},{"blue","n8"},{"blue","n9"},
		{"blue","n1"},{"blue","n2"},{"blue","n3"},{"blue","n4"},{"blue","n5"},{"blue","n6"},{"blue","n7"},{"blue","n8"},{"blue","n9"},
		{"blue","draw2"},{"blue","draw2"},{"blue","skip"},{"blue","skip"},{"blue","reverse"},{"blue","reverse"},
		{"yellow","n0"},
		{"yellow","n1"},{"yellow","n2"},{"yellow","n3"},{"yellow","n4"},{"yellow","n5"},{"yellow","n6"},{"yellow","n7"},{"yellow","n8"},{"yellow","n9"},
		{"yellow","n1"},{"yellow","n2"},{"yellow","n3"},{"yellow","n4"},{"yellow","n5"},{"yellow","n6"},{"yellow","n7"},{"yellow","n8"},{"yellow","n9"},
		{"yellow","draw2"},{"yellow","draw2"},{"yellow","skip"},{"yellow","skip"},{"yellow","reverse"},{"yellow","reverse"},
		{"green","n0"},
		{"green","n1"},{"green","n2"},{"green","n3"},{"green","n4"},{"green","n5"},{"green","n6"},{"green","n7"},{"green","n8"},{"green","n9"},
		{"green","n1"},{"green","n2"},{"green","n3"},{"green","n4"},{"green","n5"},{"green","n6"},{"green","n7"},{"green","n8"},{"green","n9"},
		{"green","draw2"},{"green","draw2"},{"green","skip"},{"green","skip"},{"green","reverse"},{"green","reverse"},
		{"black","wild"},{"black","wild"},{"black","wild"},{"black","wild"},
		{"black","draw4"},{"black","draw4"},{"black","draw4"},{"black","draw4"}
	},
}
-- /home/s1eep1ess/workspace/lua/echeckers/game/battle/battle.lua
local _start_battle = function ()
    UI.display('Setting up:')
    setup()

    for i=1, MAX_TURNS do
        UI.display({'Turn: ', i})
        UI.display({'Player turn: ', Player_turn})
        UI.display('Phase: DRAW!')
        draw()
        UI.display('Phase: Standby!')
        standby()
        print()
    end
end

_start_battle()
