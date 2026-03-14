# ECHECKERS - Project Context

## Project Overview

**ECHECKERS** is a work-in-progress cross-platform card game written in Lua. The game features:

- **Animal-based cards** with emoji representations, each having unique stats (attack, defense, speed, special abilities)
- **Biome system** with 8 different biomes (Desert, Forest, Mountain, Ocean, Tundra, Swamp, Volcano, Jungle) that provide various buffs
- **5x5 game board** with TUI (Text User Interface) display using emoji rendering
- **Multiple game modes**: `basic`, `elemental`, and `advanced`
- **Player hands** with hidden/opponent hand visibility mechanics

### Architecture

The project uses a **concatenation-based build system** that combines all Lua source files into a single `processed_script.lua` file for execution.

```
echeckers/
├── assets/          # Game data (animals, biomes, buildings, items)
├── functions/       # Helper functions (deck generator, biome selector)
├── modes/           # Game mode configurations
├── phases/          # Game phase logic (setup, duel, etc.)
├── ui/              # User interface functions
│   └── functions/   # UI rendering (board, hand updates)
├── utils/           # Utility functions
│   ├── string/      # String utilities
│   └── table/       # Table utilities
├── build_system     # Bash build script
├── build_files.txt  # Build configuration
└── duel.lua         # Main entry point
```

## Building and Running

### Build System

The project uses a custom Bash-based concatenation build system:

```bash
# Build the project
./build_system

# Run the built script
lua processed_script.lua
```

**Build Process:**
1. Reads `build_files.txt` for the list of files/directories to include
2. Concatenates all listed files into `processed_script.lua`
3. Directories are recursively scanned for all `.lua` files

### Configuration

**`build_files.txt`** - Controls which files are included in the build:
```
configuration.lua
assets/animals.lua
assets/biomes.lua
functions/random_deck_generator.lua
functions/get_random_biomes.lua
modes/basic.lua
utils/table.print.lua
utils/string.split.lua
utils/string.center.lua
ui/functions/update_board.lua
ui/functions/update_hand.lua
phases/0_setup.lua
duel.lua
```

**`configuration.lua`** - Global game settings:
```lua
BUILD = 'TUI'      -- Build target: 'TUI' for text interface
MODE = 'basic'     -- Game mode: 'basic', 'elemental', 'advanced'
UI = {}            -- UI namespace (populated by UI modules)
```

### Running

```bash
# Quick test
./build_system && lua processed_script.lua
```

## Key Components

### Assets

- **`animals.lua`** - ~150+ animal cards with emoji, stats, and abilities
  - Emojis with variation selectors (🕷️, 🐻 ❄️) have trailing spaces for consistent terminal rendering
- **`biomes.lua`** - 8 biomes with emoji, color, and effect modifiers
- **`buildings.lua`** - Building cards with special effects
- **`items.lua`** - Item definitions

### Game Modes

- **`basic`** - Standard gameplay with biomes, decks, and board setup
- **`elemental`** - Extended mode with items
- **`advanced`** - Placeholder for future features

### UI Functions

- **`update_board(board)`** - Renders the 5x5 game board with emoji cells
- **`update_hand(hand, is_hidden)`** - Renders player hand (or hidden opponent hand)

### Utilities

- **`string.center(s, width)`** - Centers text with emoji-aware width calculation (emoji = 2 visual chars)
- **`string.split()`** - String splitting utility
- **`table.print()`** - Recursive table printing with visual width handling
- **`table.copy()`** - Deep table copying
- **`StringReference.lua`** - String reference utilities

## Development Conventions

### Emoji Handling

**Important:** Emojis with variation selectors (U+FE0E/U+FE0F) render as 1 character width in terminals, while others render as 2. To ensure consistent visual spacing:

- Emojis with variation selectors in `animals.lua` have a trailing space: `emoji = "🕷️ "`
- `string.center()` strips trailing spaces before centering to maintain proper board layout

### Coding Style

- **Globals:** `Board`, `Hands`, `Biomes_p1/p2`, `Deck_p1/p2` are intentionally global for game state
- **UI namespace:** All UI functions are attached to `UI` table
- **Phase functions:** Prefixed with `_setup_`, `_TUI_` for internal/TUI-specific logic
- **Diagnostics:** Uses `---@diagnostic disable: duplicate-set-field` for UI method definitions

### File Organization

- **`phases/`** - Game lifecycle phases (numbered prefix for execution order)
- **`modes/`** - Mode-specific constants and configurations
- **`assets/`** - Pure data files (no logic)
- **`utils/`** - Reusable utility functions extending built-in types

## Current Status

- **Phase:** Setup phase implemented, duel phase pending
- **TODO:** Add `setup_hand()` logic in `phases/0_setup.lua`
- **Platform:** Currently TUI-only, cross-platform build systems planned

## Contact

- Author: vgois032@gmail.com
- Note: Single-maintainer project, suggestions welcome but no active help needed
