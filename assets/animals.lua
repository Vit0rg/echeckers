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