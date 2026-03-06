-- ./assets/animals.lua
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
    speed = 0.25,  -- km/h
    attack_base = 0,
    defense_base = 0.15,  -- +15% of base HP as defense
    special = "+X defense",
    weakness = "Fox, Raccoon, Humans"
  },
  {
    name = "Tortoise",
    emoji = "🐢",
    environment = "ground",
    speed = 0.2,  -- km/h
    attack_base = 0,
    defense_base = 0.18,  -- +18% of base HP as defense
    special = "+X defense",
    weakness = "Birds, Humans"
  },
  
  -- Animals with claws (attack bonus)
  {
    name = "Lion",
    emoji = "🦁",
    environment = "ground",
    speed = 80,  -- km/h
    attack_base = 0.12,  -- +12% of base HP as attack
    defense_base = 0.05,
    special = "+Y attack",
    weakness = "Hyenas, Crocodiles"
  },
  {
    name = "Tiger",
    emoji = "🐯",
    environment = "ground",
    speed = 65,  -- km/h
    attack_base = 0.13,  -- +13% of base HP as attack
    defense_base = 0.06,
    special = "+Y attack",
    weakness = "Elephants, Bears, Crocodiles"
  },
  {
    name = "Bear",
    emoji = "🐻",
    environment = "ground",
    speed = 48,  -- km/h
    attack_base = 0.14,  -- +14% of base HP as attack
    defense_base = 0.08,
    special = "+Y attack",
    weakness = "Humans, Wolves (in packs)"
  },
  {
    name = "Cat",
    emoji = "🐱",
    environment = "ground",
    speed = 48,  -- km/h
    attack_base = 0.08,  -- +8% of base HP as attack
    defense_base = 0.04,
    special = "+Y attack",
    weakness = "Dogs, Large birds of prey"
  },
  {
    name = "Panther",
    emoji = "🐆",
    environment = "ground",
    speed = 96,  -- km/h
    attack_base = 0.15,  -- +15% of base HP as attack
    defense_base = 0.07,
    special = "+Y attack",
    weakness = "Crocodiles, Large snakes"
  },
  
  -- Fast animals (speed bonus)
  {
    name = "Cheetah",
    emoji = "🐆",
    environment = "ground",
    speed = 120,  -- km/h
    attack_base = 0.10,
    defense_base = 0.03,
    special = "+Z speed",
    weakness = "Lions, Hyenas, Leopards"
  },
  {
    name = "Falcon",
    emoji = "🦅",
    environment = "air",
    speed = 390,  -- km/h (diving speed)
    attack_base = 0.11,
    defense_base = 0.02,
    special = "+Z speed",
    weakness = "Owls, Eagles (larger raptors)"
  },
  {
    name = "Horse",
    emoji = "🐎",
    environment = "ground",
    speed = 88,  -- km/h
    attack_base = 0.06,
    defense_base = 0.05,
    special = "+Z speed",
    weakness = "Wolves, Lions, Tigers"
  },
  {
    name = "Rabbit",
    emoji = "🐰",
    environment = "ground",
    speed = 48,  -- km/h
    attack_base = 0.05,
    defense_base = 0.03,
    special = "+Z speed",
    weakness = "Foxes, Hawks, Snakes, Cats"
  },
  {
    name = "Deer",
    emoji = "🦌",
    environment = "ground",
    speed = 80,  -- km/h
    attack_base = 0.04,
    defense_base = 0.04,
    special = "+Z speed",
    weakness = "Wolves, Lions, Tigers, Humans"
  },
  
  -- Other animals with shells (defense bonus)
  {
    name = "Snail",
    emoji = "🐌",
    environment = "water",
    speed = 0.05,  -- km/h
    attack_base = 0,
    defense_base = 0.10,  -- +10% of base HP as defense
    special = "+X defense",
    weakness = "Birds, Frogs, Beetles"
  },
  {
    name = "Crab",
    emoji = "🦀",
    environment = "water",
    speed = 0.8,  -- km/h
    attack_base = 0.07,  -- +7% of base HP as attack (claws)
    defense_base = 0.09,  -- +9% of base HP as defense (shell)
    special = "+X defense, +Y attack",
    weakness = "Octopuses, Seagulls, Humans"
  },
  
  -- More clawed animals
  {
    name = "Wolf",
    emoji = "🐺",
    environment = "ground",
    speed = 65,  -- km/h
    attack_base = 0.10,  -- +10% of base HP as attack
    defense_base = 0.06,
    special = "+Y attack",
    weakness = "Bears, Humans, Cougars"
  },
  {
    name = "Dog",
    emoji = "🐕",
    environment = "ground",
    speed = 32,  -- km/h
    attack_base = 0.06,  -- +6% of base HP as attack
    defense_base = 0.05,
    special = "+Y attack",
    weakness = "Large predators, Wolves (in packs)"
  },
  {
    name = "Eagle",
    emoji = "🦅",
    environment = "air",
    speed = 190,  -- km/h (level flight)
    attack_base = 0.09,  -- +9% of base HP as attack
    defense_base = 0.03,
    special = "+Y attack, +Z speed",
    weakness = "Owls, Larger eagles, Humans"
  },
  
  -- More fast animals
  {
    name = "Ostrich",
    emoji = "🦢",
    environment = "air",
    speed = 70,  -- km/h
    attack_base = 0.03,
    defense_base = 0.04,
    special = "+Z speed",
    weakness = "Lions, Leopards, Hyenas"
  },
  {
    name = "Gazelle",
    emoji = "🦌",
    environment = "ground",
    speed = 80,  -- km/h
    attack_base = 0.04,
    defense_base = 0.05,
    special = "+Z speed",
    weakness = "Cheetahs, Lions, Leopards"
  },
  {
    name = "Antelope",
    emoji = "🦌",
    environment = "ground",
    speed = 88,  -- km/h
    attack_base = 0.05,
    defense_base = 0.04,
    special = "+Z speed",
    weakness = "Lions, Cheetahs, Wild Dogs"
  },
  
  -- Sea animals
  {
    name = "Shark",
    emoji = "🦈",
    environment = "water",
    speed = 50,  -- km/h
    attack_base = 0.16,  -- +16% of base HP as attack
    defense_base = 0.07,
    special = "+Y attack",
    weakness = "Orcas, Larger sharks, Humans"
  },
  {
    name = "Dolphin",
    emoji = "🐬",
    environment = "ground",
    speed = 37,  -- km/h
    attack_base = 0.07,
    defense_base = 0.08,
    special = "+Z speed",
    weakness = "Sharks, Orcas, Humans"
  },
  {
    name = "Whale",
    emoji = "🐋",
    environment = "ground",
    speed = 35,  -- km/h
    attack_base = 0.09,
    defense_base = 0.12,  -- High defense due to size
    special = "+X defense",
    weakness = "Orcas, Humans"
  },
  {
    name = "Octopus",
    emoji = "🐙",
    environment = "water",
    speed = 40,  -- km/h (when jet propulsion)
    attack_base = 0.08,
    defense_base = 0.06,
    special = "+Y attack",
    weakness = "Sharks, Eels, Humans"
  },
  {
    name = "Jellyfish",
    emoji = "🪼",
    environment = "water",
    speed = 6,  -- km/h
    attack_base = 0.05,
    defense_base = 0.03,
    special = "+Y attack",
    weakness = "Sea turtles, Sunfish, Humans"
  },
  {
    name = "Starfish",
    emoji = "⭐",
    environment = "water",
    speed = 0.03,  -- km/h
    attack_base = 0.02,
    defense_base = 0.08,
    special = "+X defense",
    weakness = "Sea otters, Crabs, Humans"
  },
  {
    name = "Seahorse",
    emoji = "🐴",
    environment = "water",
    speed = 0.01,  -- km/h
    attack_base = 0.01,
    defense_base = 0.05,
    special = "+X defense",
    weakness = "Crabs, Rays, Humans"
  },
  {
    name = "Penguin",
    emoji = "🐧",
    environment = "air",
    speed = 22,  -- km/h (swimming)
    attack_base = 0.04,
    defense_base = 0.07,
    special = "+X defense",
    weakness = "Seals, Sharks, Orcas"
  },
  
  -- Insects
  {
    name = "Ant",
    emoji = "🐜",
    environment = "air",
    speed = 0.9,  -- km/h
    attack_base = 0.03,
    defense_base = 0.09,  -- High defense due to colony strength
    special = "+X defense",
    weakness = "Anteaters, Spiders, Wasps"
  },
  {
    name = "Bee",
    emoji = "🐝",
    environment = "air",
    speed = 24,  -- km/h
    attack_base = 0.06,  -- Stinger
    defense_base = 0.04,
    special = "+Y attack",
    weakness = "Birds, Spiders, Wasps"
  },
  {
    name = "Beetle",
    emoji = "🪲",
    environment = "air",
    speed = 3.2,  -- km/h
    attack_base = 0.04,
    defense_base = 0.10,  -- Hard shell
    special = "+X defense",
    weakness = "Birds, Frogs, Spiders"
  },
  {
    name = "Butterfly",
    emoji = "🦋",
    environment = "air",
    speed = 10,  -- km/h
    attack_base = 0.01,
    defense_base = 0.02,
    special = "+Z speed",
    weakness = "Birds, Spiders, Praying Mantises"
  },
  {
    name = "Dragonfly",
    emoji = "🪰",
    environment = "air",
    speed = 36,  -- km/h
    attack_base = 0.07,  -- Predatory insect
    defense_base = 0.03,
    special = "+Y attack, +Z speed",
    weakness = "Birds, Spiders, Wasps"
  },
  {
    name = "Spider",
    emoji = "🕷️",
    environment = "ground",
    speed = 2,  -- km/h
    attack_base = 0.08,  -- Venomous bite
    defense_base = 0.05,
    special = "+Y attack",
    weakness = "Wasps, Birds, Lizards"
  },
  {
    name = "Scorpion",
    emoji = "🦂",
    environment = "ground",
    speed = 2.1,  -- km/h
    attack_base = 0.09,  -- Venomous sting
    defense_base = 0.07,
    special = "+Y attack",
    weakness = "Meerkats, Owls, Mongooses"
  },
  
  -- More mammals
  {
    name = "Elephant",
    emoji = "🐘",
    environment = "ground",
    speed = 25,  -- km/h
    attack_base = 0.08,
    defense_base = 0.14,  -- High defense due to size
    special = "+X defense",
    weakness = "Humans, Lions (young elephants)"
  },
  {
    name = "Rhino",
    emoji = "🦏",
    environment = "ground",
    speed = 50,  -- km/h
    attack_base = 0.10,
    defense_base = 0.13,  -- Thick skin
    special = "+X defense",
    weakness = "Humans, Lions (young rhinos)"
  },
  {
    name = "Hippopotamus",
    emoji = "🦛",
    environment = "ground",
    speed = 30,  -- km/h
    attack_base = 0.11,
    defense_base = 0.11,
    special = "+Y attack",
    weakness = "Crocodiles, Humans"
  },
  
  -- Birds
  {
    name = "Owl",
    emoji = "🦉",
    environment = "air",
    speed = 64,  -- km/h
    attack_base = 0.07,
    defense_base = 0.06,
    special = "+Y attack",
    weakness = "Eagles, Hawks, Humans"
  },
  {
    name = "Peacock",
    emoji = "🦚",
    environment = "air",
    speed = 16,  -- km/h
    attack_base = 0.04,
    defense_base = 0.08,
    special = "+X defense",
    weakness = "Snakes, Jackals, Wild cats"
  },
  
  -- Reptiles
  {
    name = "Crocodile",
    emoji = "🐊",
    environment = "ground",
    speed = 35,  -- km/h
    attack_base = 0.13,
    defense_base = 0.10,
    special = "+Y attack",
    weakness = "Big cats, Humans, Hippos"
  },
  {
    name = "Snake",
    emoji = "🐍",
    environment = "ground",
    speed = 3,  -- km/h
    attack_base = 0.08,
    defense_base = 0.04,
    special = "+Y attack",
    weakness = "Mongooses, Hawks, Eagles"
  },
  
  -- Amphibians
  {
    name = "Frog",
    emoji = "🐸",
    environment = "water",
    speed = 18,  -- km/h
    attack_base = 0.03,
    defense_base = 0.03,
    special = "+Z speed",
    weakness = "Birds, Snakes, Fish, Humans"
  },
  
  -- Fish
  {
    name = "Swordfish",
    emoji = "🐟",
    environment = "water",
    speed = 129,  -- km/h
    attack_base = 0.12,  -- Sword-like bill
    defense_base = 0.05,
    special = "+Y attack, +Z speed",
    weakness = "Sharks, Dolphins, Humans"
  },
  {
    name = "Tuna",
    emoji = "🐟",
    environment = "water",
    speed = 74,  -- km/h
    attack_base = 0.09,
    defense_base = 0.06,
    special = "+Z speed",
    weakness = "Sharks, Orcas, Humans"
  },
  
  -- More sea animals
  {
    name = "Stingray",
    emoji = "🐟",
    environment = "water",
    speed = 8,  -- km/h
    attack_base = 0.06,  -- Venomous barb
    defense_base = 0.07,
    special = "+Y attack",
    weakness = "Sharks, Seals, Humans"
  },
  {
    name = "Electric Eel",
    emoji = "🐟",
    environment = "water",
    speed = 6,  -- km/h
    attack_base = 0.08,  -- Electric shock
    defense_base = 0.05,
    special = "+Y attack",
    weakness = "Large fish, Humans"
  },
  {
    name = "Manta Ray",
    emoji = "🐟",
    environment = "water",
    speed = 30,  -- km/h
    attack_base = 0.03,
    defense_base = 0.09,
    special = "+X defense",
    weakness = "Sharks, Orcas"
  },
  {
    name = "Lobster",
    emoji = "🦞",
    environment = "water",
    speed = 0.3,  -- km/h
    attack_base = 0.05,  -- Strong claws
    defense_base = 0.11,  -- Hard shell
    special = "+X defense, +Y attack",
    weakness = "Octopuses, Eels, Humans"
  },
  {
    name = "Squid",
    emoji = "🦑",
    environment = "water",
    speed = 35,  -- km/h (when jet propulsion)
    attack_base = 0.06,
    defense_base = 0.05,
    special = "+Y attack",
    weakness = "Sharks, Dolphins, Whales, Humans"
  },
  
  -- More mammals
  {
    name = "Giraffe",
    emoji = "🦒",
    environment = "ground",
    speed = 56,  -- km/h
    attack_base = 0.06,  -- Powerful kick
    defense_base = 0.08,
    special = "+Y attack",
    weakness = "Lions, Hyenas, Crocodiles"
  },
  {
    name = "Gorilla",
    emoji = "🦍",
    environment = "ground",
    speed = 40,  -- km/h
    attack_base = 0.12,
    defense_base = 0.10,
    special = "+Y attack",
    weakness = "Humans, Leopards (young gorillas)"
  },
  {
    name = "Kangaroo",
    emoji = "🦘",
    environment = "ground",
    speed = 70,  -- km/h
    attack_base = 0.07,  -- Powerful kicks
    defense_base = 0.06,
    special = "+Y attack, +Z speed",
    weakness = "Dingoes, Humans, Foxes (young)"
  },
  {
    name = "Polar Bear",
    emoji = "🐻‍❄️",
    environment = "ground",
    speed = 40,  -- km/h
    attack_base = 0.15,
    defense_base = 0.09,
    special = "+Y attack",
    weakness = "Humans, Walruses (large groups)"
  },
  {
    name = "Leopard",
    emoji = "🐆",
    environment = "ground",
    speed = 58,  -- km/h
    attack_base = 0.14,
    defense_base = 0.07,
    special = "+Y attack",
    weakness = "Lions, Hyenas, Crocodiles"
  },
  {
    name = "Hyena",
    emoji = "🐺",
    environment = "ground",
    speed = 60,  -- km/h
    attack_base = 0.11,
    defense_base = 0.06,
    special = "+Y attack",
    weakness = "Lions, Leopards"
  },
  {
    name = "Zebra",
    emoji = "🦓",
    environment = "ground",
    speed = 65,  -- km/h
    attack_base = 0.04,  -- Kick
    defense_base = 0.07,
    special = "+Z speed",
    weakness = "Lions, Hyenas, Crocodiles"
  },
  {
    name = "Koala",
    emoji = "🐨",
    environment = "ground",
    speed = 25,  -- km/h
    attack_base = 0.03,
    defense_base = 0.09,
    special = "+X defense",
    weakness = "Dingoes, Domestic dogs, Humans"
  },
  {
    name = "Armadillo",
    emoji = "🦔",
    environment = "ground",
    speed = 48,  -- km/h
    attack_base = 0.04,
    defense_base = 0.12,  -- Armored shell
    special = "+X defense",
    weakness = "Coyotes, Bobcats, Humans"
  },
  
  -- More birds
  {
    name = "Pigeon",
    emoji = "🐦",
    environment = "air",
    speed = 48,  -- km/h
    attack_base = 0.02,
    defense_base = 0.04,
    special = "+Z speed",
    weakness = "Falcons, Hawks, Cats"
  },
  {
    name = "Swan",
    emoji = "🦢",
    environment = "air",
    speed = 34,  -- km/h
    attack_base = 0.06,  -- Aggressive when protecting young
    defense_base = 0.07,
    special = "+Y attack",
    weakness = "Foxes, Large birds of prey, Humans"
  },
  {
    name = "Hummingbird",
    emoji = "🐦",
    environment = "air",
    speed = 48,  -- km/h
    attack_base = 0.02,
    defense_base = 0.01,
    special = "+Z speed",
    weakness = "Spiders, Praying Mantises, Small birds"
  },
  {
    name = "Crow",
    emoji = "🐦",
    environment = "air",
    speed = 50,  -- km/h
    attack_base = 0.04,
    defense_base = 0.05,
    special = "+Y attack",
    weakness = "Hawks, Falcons, Owls"
  },
  
  -- More reptiles
  {
    name = "Lizard",
    emoji = "🦎",
    environment = "ground",
    speed = 24,  -- km/h
    attack_base = 0.03,
    defense_base = 0.04,
    special = "+Y attack",
    weakness = "Birds, Snakes, Cats"
  },
  {
    name = "Chameleon",
    emoji = "🦎",
    environment = "ground",
    speed = 0.5,  -- km/h
    attack_base = 0.02,
    defense_base = 0.08,
    special = "+X defense",
    weakness = "Birds, Snakes, Humans"
  },
  {
    name = "Komodo Dragon",
    emoji = "🐉",
    environment = "ground",
    speed = 20,  -- km/h
    attack_base = 0.13,
    defense_base = 0.10,
    special = "+Y attack",
    weakness = "Humans, Large mammals (when young)"
  },
  
  -- More amphibians
  {
    name = "Salamander",
    emoji = "🐸",
    environment = "water",
    speed = 1,  -- km/h
    attack_base = 0.01,
    defense_base = 0.05,
    special = "+X defense",
    weakness = "Birds, Snakes, Fish"
  },
  {
    name = "Newt",
    emoji = "🐸",
    environment = "water",
    speed = 0.5,  -- km/h
    attack_base = 0.01,
    defense_base = 0.04,
    special = "+X defense",
    weakness = "Fish, Birds, Snakes"
  },
  
  -- More insects and arachnids
  {
    name = "Mosquito",
    emoji = "🦟",
    environment = "air",
    speed = 2,  -- km/h
    attack_base = 0.02,  -- Blood-sucking
    defense_base = 0.01,
    special = "+Y attack",
    weakness = "Bats, Dragonflies, Birds"
  },
  {
    name = "Wasp",
    emoji = "🐝",
    environment = "air",
    speed = 25,  -- km/h
    attack_base = 0.07,  -- Painful sting
    defense_base = 0.03,
    special = "+Y attack",
    weakness = "Birds, Spiders, Wasps (other colonies)"
  },
  {
    name = "Termite",
    emoji = "🐜",
    environment = "air",
    speed = 0.5,  -- km/h
    attack_base = 0.01,
    defense_base = 0.08,
    special = "+X defense",
    weakness = "Ants, Anteaters, Birds"
  },
  {
    name = "Mantis",
    emoji = "🦗",
    environment = "air",
    speed = 2.5,  -- km/h
    attack_base = 0.09,  -- Raptorial forelegs
    defense_base = 0.03,
    special = "+Y attack",
    weakness = "Birds, Spiders, Amphibians"
  },
  {
    name = "Centipede",
    emoji = "🐛",
    environment = "ground",
    speed = 0.5,  -- km/h
    attack_base = 0.06,  -- Venomous bite
    defense_base = 0.04,
    special = "+Y attack",
    weakness = "Shrews, Toads, Humans"
  },
  {
    name = "Millipede",
    emoji = "🐛",
    environment = "ground",
    speed = 0.1,  -- km/h
    attack_base = 0.01,
    defense_base = 0.10,  -- Defensive curling and toxins
    special = "+X defense",
    weakness = "Ants, Beetles, Humans"
  },
  
  -- More crustaceans
  {
    name = "Shrimp",
    emoji = "🦐",
    environment = "water",
    speed = 8,  -- km/h
    attack_base = 0.02,
    defense_base = 0.03,
    special = "+Y attack",
    weakness = "Fish, Crabs, Humans"
  },
  {
    name = "Hermit Crab",
    emoji = "🦀",
    environment = "water",
    speed = 0.5,  -- km/h
    attack_base = 0.03,
    defense_base = 0.10,  -- Borrowed shell protection
    special = "+X defense",
    weakness = "Octopuses, Larger crabs, Humans"
  },
  
  -- More mollusks
  {
    name = "Clam",
    emoji = "🦪",
    environment = "water",
    speed = 0.01,  -- km/h
    attack_base = 0,
    defense_base = 0.12,  -- Hard shell
    special = "+X defense",
    weakness = "Starfish, Crabs, Humans"
  },
  {
    name = "Nautilus",
    emoji = "🐙",
    environment = "water",
    speed = 0.5,  -- km/h
    attack_base = 0.01,
    defense_base = 0.09,  -- Protective shell
    special = "+X defense",
    weakness = "Sharks, Octopuses, Humans"
  },
  
  -- Additional animals
  {
    name = "Bat",
    emoji = "🦇",
    environment = "ground",
    speed = 60,  -- km/h
    attack_base = 0.05,
    defense_base = 0.04,
    special = "+Z speed",
    weakness = "Owls, Hawks, Humans"
  },
  {
    name = "Rhinoceros Beetle",
    emoji = "🪲",
    environment = "air",
    speed = 5,  -- km/h
    attack_base = 0.06,
    defense_base = 0.12,  -- Extremely hard shell
    special = "+X defense",
    weakness = "Ants, Birds, Humans"
  },
  {
    name = "Piranha",
    emoji = "🐟",
    environment = "water",
    speed = 45,  -- km/h
    attack_base = 0.11,
    defense_base = 0.03,
    special = "+Y attack",
    weakness = "Caimans, Otters, Humans"
  },
  {
    name = "Platypus",
    emoji = "🦆",
    environment = "ground",
    speed = 35,  -- km/h (swimming)
    attack_base = 0.04,  -- Males have venomous spurs
    defense_base = 0.07,
    special = "+Y attack",
    weakness = "Snakes, Water rats, Humans"
  },
  {
    name = "Axolotl",
    emoji = "🦎",
    environment = "water",
    speed = 2,  -- km/h
    attack_base = 0.02,
    defense_base = 0.06,
    special = "+X defense",
    weakness = "Large fish, Birds, Humans"
  },
  {
    name = "Pangolin",
    emoji = "🦔",
    environment = "ground",
    speed = 30,  -- km/h
    attack_base = 0.02,
    defense_base = 0.13,  -- Protective scales
    special = "+X defense",
    weakness = "Humans, Large carnivores"
  },
  {
    name = "Manatee",
    emoji = "🦭",
    environment = "ground",
    speed = 8,  -- km/h
    attack_base = 0.01,
    defense_base = 0.09,
    special = "+X defense",
    weakness = "Boats, Sharks, Humans"
  },
  {
    name = "Iguana",
    emoji = "🦎",
    environment = "ground",
    speed = 25,  -- km/h
    attack_base = 0.05,  -- Strong tail and claws
    defense_base = 0.06,
    special = "+Y attack",
    weakness = "Birds of prey, Snakes, Humans"
  },
  {
    name = "Tarantula",
    emoji = "🕷️",
    environment = "ground",
    speed = 1.5,  -- km/h
    attack_base = 0.07,  -- Venomous bite
    defense_base = 0.06,
    special = "+Y attack",
    weakness = "Wasps, Birds, Tarantula hawks"
  },
  {
    name = "Vulture",
    emoji = "🦅",
    environment = "air",
    speed = 120,  -- km/h
    attack_base = 0.05,
    defense_base = 0.06,
    special = "+Z speed",
    weakness = "Other raptors, Humans"
  },

  -- Extinct animals
  {
    name = "T-Rex",
    emoji = "🦖",
    environment = "ground",
    speed = 29,  -- km/h
    attack_base = 0.18,
    defense_base = 0.10,
    special = "+Y attack",
    weakness = "Large sauropods (in theory), Environmental changes"
  },
  {
    name = "Triceratops",
    emoji = "🦕",
    environment = "ground",
    speed = 24,  -- km/h
    attack_base = 0.08,
    defense_base = 0.15,
    special = "+X defense",
    weakness = "Large theropods like T-Rex, Environmental changes"
  },
  {
    name = "Velociraptor",
    emoji = "🦕",
    environment = "ground",
    speed = 64,  -- km/h
    attack_base = 0.12,
    defense_base = 0.05,
    special = "+Y attack, +Z speed",
    weakness = "Larger predators, Environmental changes"
  },
  {
    name = "Brontosaurus",
    emoji = "🦕",
    environment = "ground",
    speed = 16,  -- km/h
    attack_base = 0.06,
    defense_base = 0.14,
    special = "+X defense",
    weakness = "Large theropods, Environmental changes"
  },
  {
    name = "Mammoth",
    emoji = "🦣",
    environment = "ground",
    speed = 25,  -- km/h
    attack_base = 0.09,
    defense_base = 0.12,
    special = "+X defense",
    weakness = "Humans, Climate change"
  },
  {
    name = "Sabertooth Tiger",
    emoji = "🐅",
    environment = "ground",
    speed = 50,  -- km/h
    attack_base = 0.16,
    defense_base = 0.07,
    special = "+Y attack",
    weakness = "Climate change, Prey scarcity"
  },
  {
    name = "Dodo",
    emoji = "🦤",
    environment = "air",
    speed = 10,  -- km/h
    attack_base = 0.01,
    defense_base = 0.03,
    special = "",
    weakness = "Humans, Introduced predators"
  },
  {
    name = "Megalodon",
    emoji = "🦈",
    environment = "water",
    speed = 50,  -- km/h
    attack_base = 0.19,
    defense_base = 0.11,
    special = "+Y attack",
    weakness = "Climate change, Prey scarcity"
  },

  -- Mythological animals
  {
    name = "Dragon",
    emoji = "🐉",
    environment = "air",
    speed = 150,  -- km/h (flying)
    attack_base = 0.20,
    defense_base = 0.16,
    special = "+Y attack, +Z speed",
    weakness = "Dragonslayers, Magic"
  },
  {
    name = "Unicorn",
    emoji = "🦄",
    environment = "ground",
    speed = 70,  -- km/h
    attack_base = 0.07,
    defense_base = 0.09,
    special = "+Z speed",
    weakness = "Human hunters, Loss of magical forests"
  },
  {
    name = "Kraken",
    emoji = "🐙",
    environment = "water",
    speed = 30,  -- km/h (swimming)
    attack_base = 0.17,
    defense_base = 0.14,
    special = "+Y attack",
    weakness = "Sailors with special weapons, Bright lights"
  }
}

local animals = base_animals_list
-- ./assets/biomes.lua
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

-- ./functions/random_deck_generator.lua
math.randomseed(1)
local random = math.random

local function generate_random_deck()
    local deck = {}
    local deck_size = 40

    local index
    for i=1, deck_size do
        index = random(1, #animals)
        deck[i] = animals[index]
    end

    return deck
end


-- ./functions/get_random_biomes.lua
math.randomseed(1)
local random = math.random

local function get_random_biomes()
    local _selected_biomes = {}
    local max_biomes = 3

    local index
    for i=1, max_biomes do
        index = random(1, #biomes)
        _selected_biomes[i] = biomes[index]
    end

    return _selected_biomes
end
-- ./utils/table.print.lua
-- @4: obj, mode, max_depth, visited
table.print = function(...)
    local args = {...}
    local obj = args[1]
    local mode = args[2] or "v"
    local max_depth = args[3] or 10
    local visited = args[4] or {}

    if type(obj) ~= "table" then
        error("First argument must be a table")
    end

    local function print_table_recursive(current_obj, current_depth, current_visited)
        if current_depth >= max_depth then
            print("<maximum depth reached>")
            return
        end

        if current_visited[current_obj] then
            print("<circular reference detected>")
            return
        end

        current_visited[current_obj] = true

        -- Process all elements in a single loop
        local function process_element(k, v)
            -- Define behavior based on value type and mode
            local behaviors = {
                k = { table_func = function() print(tostring(k)) end, non_table_func = function() print(tostring(k)) end },
                v = { table_func = function() print_table_recursive(v, current_depth + 1, current_visited) end, non_table_func = function() print(tostring(v)) end },
                kv = { table_func = function() print(tostring(k) .. ":"); print_table_recursive(v, current_depth + 1, current_visited) end, non_table_func = function() print(tostring(k) .. ": " .. tostring(v)) end }
            }

            local behavior = behaviors[mode] or behaviors.kv
            local value_type = type(v) == "table" and "table_func" or "non_table_func"
            behavior[value_type]()
        end

        -- Process all keys using ipairs for array part and a manual approach for hash part
        -- Array part: indices 1 to #current_obj
        for i = 1, #current_obj do
            process_element(i, current_obj[i])
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
                process_element(k, v)
            end
        until map_key == nil

        current_visited[current_obj] = nil
    end

    print_table_recursive(obj, 0, visited)
end
-- ./phases/0_setup.lua
local function _setup_biomes()
    Biomes_p1 = get_random_biomes()
    Biomes_p2 = get_random_biomes()
end

local function _setup_board(...)
    local args = {...}
    local mode = args[1] or 'easy'

    if mode == 'easy' then
        --[[
        table = [biome_1_p2], [biome_2_p2], [biome_3_p2],[animals_deck_p2]
                [],[phase],[]
                [biome_1_p1], [biome_2_p1], [biome_3_p1],[animals_deck_p1]
                
        ]]
    end
    --[[
    [1] = {
        name = 'Desert',
        emoji = '🏜️',
        color = '#dddd00',
        effect = '-5% speed [ground] [enemy]'
    },
    ]]
end

local function _setup_decks()
    local deck_p1 = generate_random_deck()
    local deck_p2 = generate_random_deck()
    -- table.print(deck_p1, 'v')
    -- table.print(deck_p2, 'v')
end

_setup_biomes()
table.print(Biomes_p1)
print()
table.print(Biomes_p2)
