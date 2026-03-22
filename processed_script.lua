-- /home/s1eep1ess/workspace/lua/echeckers/configuration.lua
BUILD = 'TUI'
MODE = 'basic'
UI = {}
math.randomseed(os.time())
-- /home/s1eep1ess/workspace/lua/echeckers/assets/animals.lua
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
-- /home/s1eep1ess/workspace/lua/echeckers/assets/biomes.lua
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

-- /home/s1eep1ess/workspace/lua/echeckers/functions/random_deck_generator.lua
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


-- /home/s1eep1ess/workspace/lua/echeckers/functions/get_random_biomes.lua
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
-- /home/s1eep1ess/workspace/lua/echeckers/modes/basic.lua
LIFE = 2000
BIOMATTER = 3
MAX_BIOMATTER = 10
MAX_TURNS = 5
DECK_SIZE = 10
HAND_SIZE = 4
HAND_LIMIT = DECK_SIZE/2
SCALE = 100
-- /home/s1eep1ess/workspace/lua/echeckers/utils/table.print.lua
local function _process_element(k, v, mode, separator, _print_table_recursive_fn, current_depth, current_visited, output, max_depth)
    -- Define behavior based on value type and mode
    local behaviors = {
        k = { table_func = function() output = output .. tostring(k) end, non_table_func = function() output = output .. tostring(k) end },
        v = { table_func = function() output = _print_table_recursive_fn(v, current_depth + 1, current_visited, mode, separator, max_depth, output) end, non_table_func = function() output = output .. tostring(v) end },
        kv = { table_func = function() output = output .. tostring(k) .. ":"; output = _print_table_recursive_fn(v, current_depth + 1, current_visited, mode, separator, max_depth, output) end, non_table_func = function() output = output .. tostring(k) .. ": " .. tostring(v) end }
    }

    local behavior = behaviors[mode] or behaviors.kv
    local value_type = type(v) == "table" and "table_func" or "non_table_func"
    behavior[value_type]()
    return output
end

local function _print_table_recursive(current_obj, current_depth, current_visited, mode, separator, max_depth, output)
    if current_depth >= max_depth then
        return output .. "<maximum depth reached>"
    end

    if current_visited[current_obj] then
        return output .. "<circular reference detected>"
    end

    current_visited[current_obj] = true

    -- Process all keys using ipairs for array part and a manual approach for hash part
    -- Array part: indices 1 to #current_obj
    for i = 1, #current_obj do
        output = _process_element(i, current_obj[i], mode, separator, _print_table_recursive, current_depth, current_visited, output, max_depth)
        if separator ~= "" then
            output = output .. separator
        end
    end

    -- Note: Accessing hash keys in Lua tables requires some form of iteration
    -- Using rawget with known keys would require knowing keys in advance
    -- The following is the most direct way to access non-array keys without pairs
    local key_map = {}

    -- Use next to collect all keys first
    local iter_key = nil
    repeat
        local k, v = next(current_obj, iter_key)
        iter_key = k
        if k ~= nil then
            local is_array_index = type(k) == "number" and k >= 1
                                    and k <= #current_obj and math.floor(k) == k
            if not is_array_index then
                key_map[k] = v  -- Store only non-array keys
            end
        end
    until iter_key == nil

    -- Then process only non-array keys using next
    local map_key = nil
    repeat
        local k, v = next(key_map, map_key)
        map_key = k
        if k ~= nil then
            output = _process_element(k, v, mode, separator, _print_table_recursive, current_depth, current_visited, output, max_depth)
            if separator ~= "" then
                output = output .. separator
            end
        end
    until map_key == nil

    current_visited[current_obj] = nil
    return output
end

-- @5: obj, mode, max_depth, visited, separator
table.print = function(...)
    local args = {...}
    local obj = args[1]
    local mode = args[2] or "v"
    local max_depth = args[3] or 10
    local visited = args[4] or {}
    local separator = args[5] or ""

    if type(obj) ~= "table" then
        error("First argument must be a table")
    end

    local output = ""

    output = _print_table_recursive(obj, 0, visited, mode, separator, max_depth, output)

    print(output)
end

-- /home/s1eep1ess/workspace/lua/echeckers/utils/string.split.lua
string.split = function(value, sep, f)
	if sep == nil or sep == "" then
		-- If no separator is provided, return each character
		local out = {}
		for i = 1, #value do
			out[i] = value:sub(i, i)
		end
		return out
	end

	local out = {}
	local index = 1

	-- Handle empty string case
	if value == "" then
		return {""}
	end

	-- Process the string by finding separators iteratively without a while loop
	local remaining_value = value
	local start_pos = 1

	-- Since we need to avoid while loops, we'll use a for loop with a large upper bound
	-- and break when no more separators are found
	for _ = 1, #value do
		local pos = string.find(remaining_value, sep, start_pos, true) -- plain text search
		if not pos then
			-- No more separators, add the rest of the string
			local chunk = string.sub(remaining_value, start_pos)
			out[index] = (f and type(f) == "function" and f(chunk) or chunk)
			break
		else
			-- Add the substring before the separator
			local chunk = string.sub(remaining_value, start_pos, pos - 1)
			out[index] = (f and type(f) == "function" and f(chunk) or chunk)
			index = index + 1
			start_pos = pos + #sep
			remaining_value = value
		end
	end

	return out
end
-- /home/s1eep1ess/workspace/lua/echeckers/utils/string.center.lua
-- Center text within given visual width (emoji = 2 chars)
string.center = function(s, width)
    -- Convert numbers to strings
    s = tostring(s)
    -- Remove trailing space if present (for emoji padding)
    local trimmed = s:gsub(' $', '')

    local vlen = 0
    local i = 1
    while i <= #trimmed do
        local b1 = string.byte(trimmed, i)
        if b1 < 128 then
            vlen = vlen + 1
            i = i + 1
        elseif b1 < 192 then
            i = i + 1
        else
            local char_bytes
            if b1 >= 240 then char_bytes = 4
            elseif b1 >= 224 then char_bytes = 3
            elseif b1 >= 192 then char_bytes = 2
            else char_bytes = 1 end
            -- Skip variation selector
            local next_i = i + char_bytes
            if next_i + 2 <= #trimmed then
                local b2, b3 = string.byte(trimmed, next_i, next_i + 1)
                if b2 == 239 and b3 == 184 then
                    local b4 = string.byte(trimmed, next_i + 2)
                    if b4 >= 128 and b4 <= 143 then
                        next_i = next_i + 3
                    end
                end
            end
            i = next_i
            vlen = vlen + 2
        end
    end

    local pad = width - vlen
    if pad < 0 then pad = 0 end
    local left_pad = math.ceil(pad / 2)
    local right_pad = pad - left_pad
    return string.rep(' ', left_pad) .. trimmed .. string.rep(' ', right_pad)
end

-- /home/s1eep1ess/workspace/lua/echeckers/ui/functions/tui_colors.lua
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
-- /home/s1eep1ess/workspace/lua/echeckers/ui/functions/UI.display.lua
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
-- /home/s1eep1ess/workspace/lua/echeckers/ui/functions/UI.input.lua
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
-- /home/s1eep1ess/workspace/lua/echeckers/ui/functions/UI.update_board.lua
--- Center text ignoring ANSI escape codes
---@param text string Text with possible ANSI codes
---@param width number Desired width
---@return string Centered text
local function center_ansi(text, width)
    text = tostring(text)
    local clean = text:gsub('\27%[[%d;]*m', '')
    local padding = width - #clean
    if padding <= 0 then return text end
    local left = math.floor(padding / 2)
    local right = padding - left
    return string.rep(' ', left) .. text .. string.rep(' ', right)
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

    -- Cell color configuration: CELL_COLORS[row][col] = color_code
    local CELL_COLORS = {
        [1] = {nil, nil, nil, DECK_COLOR, TRASH_COLOR},
        [2] = {nil, nil, nil, HEALTH_COLOR, BIOMATTER_COLOR},
        [3] = {GREY_ROW3, GREY_ROW3, GREY_ROW3, GREY_ROW3, GREY_ROW3},
        [4] = {nil, nil, nil, HEALTH_COLOR, BIOMATTER_COLOR},
        [5] = {nil, nil, nil, DECK_COLOR, TRASH_COLOR},
    }

    local grey_bg = '\27[48;5;235m'

    --- Build ANSI colored text
    ---@param text string
    ---@param color number
    ---@return string
    local function build_colored_text(text, color)
        local bg, fg = build_cell_colors(color)
        return bg .. fg .. text .. ANSI_RESET
    end

    --- Get cell color for special cells (Deck, Trash, LIFE, BIOMATTER)
    local function get_cell_color(row, col)
        return CELL_COLORS[row] and CELL_COLORS[row][col]
    end

    --- Extract biome from cell {biome, index, card}
    local function get_biome(cell)
        if type(cell) ~= 'table' then return nil end
        -- Cell structure: {biome_data, index, card}
        for i = 1, #cell do
            local v = cell[i]
            if type(v) == 'table' and v.name then
                return v
            end
        end
        return nil
    end

    --- Check if cell contains a card
    local function get_card(cell)
        if type(cell) ~= 'table' then return nil end
        -- Cell structure: {biome_data, index, card}
        for i = 1, #cell do
            local v = cell[i]
            if type(v) == 'table' and v.emoji then
                return v
            end
        end
        return nil
    end

    --- Render a single cell
    local function render_cell(row, col, cell)
        local cell_size = CELL_SIZES[col]
        local biome = get_biome(cell)
        local card = get_card(cell)
        local color

        -- Priority: biome color > special cell color (Deck, Trash, etc.)
        if biome and biome.color then
            color = biome.color
        else
            color = get_cell_color(row, col)
        end

        -- Card rendering: emoji centered with grey background
        if card and card.name then
            local emoji = format_emoji_field(card.emoji or card.name)
            local padding = cell_size - 2
            local left = math.floor(padding / 2)
            local right = padding - left

            if color then
                local bg, fg = build_cell_colors(color)
                return bg .. fg .. string.rep(' ', left) ..
                       grey_bg .. emoji .. ANSI_RESET ..
                       bg .. fg .. string.rep(' ', right) .. ANSI_RESET
            end
            return grey_bg .. emoji .. ANSI_RESET
        end

        -- Biome rendering
        local display_text
        if biome and biome.name then
            display_text = center_ansi(biome.name, cell_size)
        elseif type(cell) == 'table' then
            -- Non-biome table cell (LIFE, BIOMATTER, etc.)
            local value
            for i = 1, #cell do
                local v = cell[i]
                if type(v) ~= 'table' or not v.name then
                    value = v
                    break
                end
            end
            display_text = center_ansi(value or tostring(cell), cell_size)
        else
            display_text = center_ansi(cell or '', cell_size)
        end

        local result
        if color then
            result = build_colored_text(display_text, color)
        else
            result = display_text .. ANSI_RESET
        end
        return result
    end

    -- Board structure mapping:
    -- board[1] = {biomes2[1-3], Deck, Trash, biomes2[4-6], LIFE, BIOMATTER} (10 cells)
    -- board[2] = {'', 'SETUP', '', '', ''} (5 cells)
    -- board[3] = {biomes1[1-3], LIFE, BIOMATTER, biomes1[4-6], Deck, Trash} (10 cells)
    --
    -- Visual output (5 rows x 5 cols):
    -- Row 1: board[1][1-5]   -> biomes2[1-3], Deck, Trash
    -- Row 2: board[1][6-10]  -> biomes2[4-6], LIFE, BIOMATTER
    -- Row 3: board[2][1-5]   -> SETUP row
    -- Row 4: board[3][1-5]   -> biomes1[1-3], LIFE, BIOMATTER
    -- Row 5: board[3][6-10]  -> biomes1[4-6], Deck, Trash

    local VISUAL_MAP = {
        [1] = {board_row = 1, cols = {1, 2, 3, 4, 5}},
        [2] = {board_row = 1, cols = {6, 7, 8, 9, 10}},
        [3] = {board_row = 2, cols = {1, 2, 3, 4, 5}},
        [4] = {board_row = 3, cols = {1, 2, 3, 4, 5}},
        [5] = {board_row = 3, cols = {6, 7, 8, 9, 10}},
    }

    local lines = {}
    local COL_COUNT = 5
    local VISUAL_ROWS = 5

    -- Pre-calculate board width
    local board_width = 2
    for i = 1, COL_COUNT do
        board_width = board_width + CELL_SIZES[i]
    end

    local sep_bg, sep_fg = build_cell_colors(GREY_ROW3)
    local separator = sep_bg .. sep_fg .. ' ' .. ANSI_RESET

    local border_line = sep_bg .. sep_fg .. string.rep(' ', board_width) .. ANSI_RESET
    lines[1] = border_line

    for visual_row = 1, VISUAL_ROWS do
        local row_parts = {separator}
        local mapping = VISUAL_MAP[visual_row]
        local board_row = board[mapping.board_row]

        for col = 1, COL_COUNT do
            local board_col = mapping.cols[col]
            local cell = board_row and board_row[board_col]
            row_parts[col + 1] = render_cell(visual_row, col, cell)
        end

        row_parts[COL_COUNT + 2] = separator
        lines[visual_row + 1] = table.concat(row_parts)
    end

    lines[VISUAL_ROWS + 2] = border_line

    print('\n' .. table.concat(lines, '\n') .. '\n')
end

---@diagnostic disable-next-line: duplicate-set-field
UI.update_board = function (board)
    if BUILD == 'TUI' then
        _TUI_update_board(board)
    end
end

-- /home/s1eep1ess/workspace/lua/echeckers/ui/functions/UI.update_hand.lua
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

-- /home/s1eep1ess/workspace/lua/echeckers/functions/card_processor.lua
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
-- /home/s1eep1ess/workspace/lua/echeckers/functions/draw_card.lua
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
-- /home/s1eep1ess/workspace/lua/echeckers/phases/0_setup.lua
--[[
This file should be called when duel starts
Biomes, decks and items should be saved as globals
The rest should be unloaded
]]

local function _setup_biomes()
    Biomes = {}
    Biomes[1] = get_random_biomes()
    Biomes[2] = get_random_biomes()
    --[[
    print('BIOMES 1:\n')
    table.print(Biomes_p1, 'v')
    print('BIOMES 2:\n')
    table.print(Biomes_p2, 'v')
    ]]
end

local function _setup_decks()
    Decks={true,true}
    Decks[1] = generate_random_deck()
    Decks[2] = generate_random_deck()
    --[[
    print('DECK 1:\n')
    table.print(deck_p1, 'v')
    print('DECK 2\n')
    table.print(deck_p2, 'v')
    ]]
end

local function _setup_items()
    return
end


local function _setup_starter()
    if math.random(1, 2) == 1 then
        UI.display('Player 1 goes 1st')
        Player_turn=1
        return
    end

    UI.display('Player 2 goes 1st')
    Player_turn=2
end


-- Board should be global
local function _setup_board(MODE)
    if MODE == 'basic' then
        Board = {}

        Board[1] = {{Biomes[2][1], 1}, {Biomes[2][2], 2},
                    {Biomes[2][3], 3}, 'Deck', 'Trash',
                    {Biomes[2][4], 4}, {Biomes[2][5], 5},
                    {Biomes[2][6], 6}, LIFE, BIOMATTER}
        Board[2] = {'', 'SETUP', '','' , ''}
        Board[3] = {{Biomes[1][1], 1}, {Biomes[1][2], 2},
                    {Biomes[1][3], 3}, LIFE, BIOMATTER,
                    {Biomes[1][4], 4}, {Biomes[1][5], 5},
                    {Biomes[1][6], 6}, 'Deck', 'Trash'
                    }
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
    -- Each player should not see the other hand
    UI.update_hand(Hands[2], 'hidden')
    UI.update_board(Board)
    UI.update_hand(Hands[1])
end

local _setup_trash = function ()
    Trashs = {true, true}
    Trashs[1] = {}
    Trashs[2] = {}
end
-- @1: MODE(string)
local function setup()
    if MODE == 'basic' then
        _setup_biomes()
        _setup_decks()
        _setup_starter()
        _setup_board(MODE)
        _setup_hands()
        _setup_ui()
    end

    if MODE == 'elemental' then
        return
    end

    if MODE == 'advanced' then
        return
    end

end
-- /home/s1eep1ess/workspace/lua/echeckers/phases/1_draw_phase.lua
local _update_ui = function ()
    -- Each player should not see the other hand
    UI.update_hand(Hands[2], 'hidden')
    UI.update_board(Board)
    UI.update_hand(Hands[1])
end

local _discard = function ()
    return
end

local _check_hand_size = function ()
    if #Hands[Player_turn] > HAND_LIMIT then
        UI.display("Discard one")
        _discard()
    end
end

local draw = function ()
    if MODE == 'basic' then
        _draw_card(Player_turn)
        _update_ui()
        return
    end
end
-- /home/s1eep1ess/workspace/lua/echeckers/phases/2_standby_phase.lua
local _set_animal = function ()
    -- input 1
    local hand_index = 1
    -- input 2 (must be between 1 and 6)
    local biome_index = 1

    local turn = Player_turn
    local hand = Hands[turn]
    local len = #hand
    local card = hand[hand_index]

    -- Board row and column mapping based on player turn
    local board_row = (turn == 1) and 3 or 1
    local column = (biome_index <= 3) and biome_index or (biome_index + 2)

    -- Place the card on the board, keeping the biome structure {biome, index, card}
    local old_cell = Board[board_row][column]
    Board[board_row][column] = {old_cell[1], old_cell[2], card}

    -- Remove the card from hand
    if hand_index < len then
        hand[hand_index] = hand[len]
    end
    hand[len] = nil
end

local _remove_animal = function ()
    -- input 1 (must be between 1 and 6)
    local biome_index = 1

    local turn = Player_turn
    local hand = Hands[turn]

    -- Check if there is an animal on the biome
    -- Remove it
    
end


local _move_animal = function ()
    return 3
end

local _move_biome = function ()
    return 4
end

local _update_ui = function ()
    -- Each player should not see the other hand
    UI.update_hand(Hands[2], 'hidden')
    UI.update_board(Board)
    UI.update_hand(Hands[1])
end

local standby = function ()
    local actions = { _set_animal,
                      _remove_animal,
                      _move_animal,
                      _move_biome}
    local input

    if MODE == 'basic' then
        -- local input = _TUI_input({"number", "Set mode"}, false)
        input = 1
    end

    if input and actions[input] then
        actions[input]()
    end
    _update_ui()
end
-- /home/s1eep1ess/workspace/lua/echeckers/battle.lua
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
