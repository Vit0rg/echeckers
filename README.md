# ECHECKERS - Project Context

## Project Overview

**ECHECKERS** is a work-in-progress cross-platform card game written in Lua. The game features:

- **Animal-based cards** with emoji representations, each having unique stats (attack, defense, speed, special abilities)
- **Biome system** with 8 different biomes (Desert, Forest, Mountain, Ocean, Tundra, Swamp, Volcano, Jungle) that provide various buffs
- **Game board** with TUI (Text User Interface) display using emoji rendering
- **Multiple game modes**: `basic`, `elemental`, and `advanced`
- **Player hands** with hidden/opponent hand visibility mechanics

### Architecture

The project uses a **concatenation-based build system** that combines all Lua source files into separate bundles for the main game and battle module.

```
echeckers/
├── settings/        # Configuration and game settings
│   ├── configuration.lua
│   ├── modes/
│   │   └── basic.lua
│   └── player_options.lua
├── battle/          # Battle gameplay module
│   ├── assets/      # Game data (animals, biomes, buildings, items)
│   ├── board/       # Board management modules
│   ├── decks/       # Deck definitions
│   ├── functions/   # Game logic functions
│   ├── phases/      # Game phase implementations
│   ├── ui/          # UI rendering functions
│   └── validation/  # Input and move validation
├── build_systems/   # Build scripts and configurations
│   ├── build_system      # Bash build script
│   ├── build.ps1         # PowerShell build script
│   ├── build_main.txt    # Main game build configuration
│   └── build_battle.txt  # Battle module build configuration
├── events/          # Event handlers
├── menus/           # Menu system files
├── sketches/        # Sketches and prototypes
├── src/             # Source initialization files
├── ui/              # User interface files
└── utils/           # Utility functions
    ├── string/      # String utilities
    └── table/       # Table utilities
```

## Building and Running

### Build System

The project uses a custom multi-step build system supporting both Bash (Linux/macOS) and PowerShell (Windows):

```bash
# Build the project (from project root)
./build_systems/build_system

# Or on Windows PowerShell
.\build_systems\build.ps1

# Run the built script
lua processed_script.lua          # Main game
lua battle/processed_battle.lua   # Battle module
```

**Build Process:**
1. Reads configuration files (`build_main.txt`, `build_battle.txt`)
2. Concatenates all listed files into separate bundles
3. Directories are recursively scanned for all `.lua` files
4. Outputs:
   - `processed_script.lua` - Main game bundle
   - `battle/processed_battle.lua` - Battle module bundle

### Configuration

**`build_systems/build_main.txt`** - Core game files:
```
settings/configuration.lua
settings/modes/basic.lua
settings/player_options.lua
utils/string/string.center.lua
utils/string/string.split.lua
utils/table/table.print.lua
ui/main_menu.lua
menus/main_menu.lua
events/*.lua
src/*.lua
```

**`build_systems/build_battle.txt`** - Battle gameplay module:
```
settings/configuration.lua
battle/assets/*.lua
battle/functions/*.lua
battle/board/*.lua
battle/phases/*.lua
battle/ui/*.lua
battle/decks/*.lua
battle/battle.lua
```

**`settings/configuration.lua`** - Global game settings:
```lua
BUILD = 'TUI'      -- Build target: 'TUI' for text interface
MODE = 'basic'     -- Game mode: 'basic', 'elemental', 'advanced'
UI = {}            -- UI namespace (populated by UI modules)
```

### Running

```bash
# Quick test
./build_systems/build_system && lua processed_script.lua
```

## Key Components

### Settings

- **`configuration.lua`** - Global game settings (BUILD, MODE, UI)
- **`modes/basic.lua`** - Basic game mode constants and configurations
- **`player_options.lua`** - Player-specific options and settings

### Assets (battle/)

- **`animals.lua`** - ~150+ animal cards with emoji, stats, and abilities
  - Emojis with variation selectors (🕷️, 🐻 ❄️) have trailing spaces for consistent terminal rendering
- **`biomes.lua`** - 8 biomes with emoji, color, and effect modifiers
- **`buildings.lua`** - Building cards with special effects
- **`items.lua`** - Item definitions

### Game Phases (battle/phases/)

- **`0_setup.lua`** - Game setup phase (biome selection, hand drawing)
- **`1_draw_phase.lua`** - Card drawing logic
- **`2_standby_phase.lua`** - Player action phase (place/move animals)
- **`3_battle_phase.lua`** - Battle resolution
- **`4_end_phase.lua`** - Turn end and cleanup

### UI Functions (battle/ui/)

- **`UI.display.lua`** - General display utilities
- **`UI.input.lua`** - Handles terminal input for numbers and text, with menu support
- **`UI.update_board(board)`** - Renders the game board with emoji cells, biome colors, and special cell highlighting
- **`UI.update_hand(hand, is_hidden, start_index, end_index)`** - Renders player hand with pagination, detailed stats, and navigation indicators
- **`tui_colors.lua`** - ANSI color utilities for TUI rendering

### Utilities

- **`string/`** - String utilities:
  - `string.center(s, width)` - Centers text with emoji-aware width calculation
  - `string.split()` - String splitting utility
  - `string.replace()` - String replacement utility
  - `char_width.lua` - Character width calculation
- **`table/`** - Table utilities:
  - `table.print()` - Recursive table printing with visual width handling
  - `table.copy()` - Deep table copying
  - `table.unpack()` - Table unpacking utility

### Events

- **`chatCommand.lua`** - Chat command event handler
- **`keyboard.lua`** - Keyboard input event handler
- **`loop.lua`** - Game loop event handler
- **`newPlayer.lua`** - New player event handler
- **`playerLeft.lua`** - Player disconnect event handler
- **`textAreaCallback.lua`** - Text area callback handler

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

- **`battle/phases/`** - Game lifecycle phases (numbered prefix for execution order)
- **`settings/modes/`** - Mode-specific constants and configurations
- **`battle/assets/`** - Pure data files (no logic)
- **`utils/`** - Reusable utility functions organized by type (string/table)

## Current Status

- **Phases:** Setup, Draw, Standby, Battle, and End phases implemented
- **Board:** Flat structure with 6 biomes per player + special cells (Deck, Trash, LIFE, BIOMATTER)
- **UI:** Enhanced TUI with color support, pagination, and detailed card stats
- **Input:** Basic input system implemented (`_TUI_input`)
- **Build System:** Multi-step build with Bash and PowerShell support
- **TODO:** Full integration testing, battle phase polish, input integration
- **Platform:** Currently TUI-only, cross-platform build systems included

## Contact

- Author: vgois032@gmail.com
- Note: Single-maintainer project, suggestions welcome but no active help needed
