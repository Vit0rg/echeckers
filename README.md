# ECHECKERS - Project Context

## Project Overview

**ECHECKERS** is a work-in-progress cross-platform card game written in Lua. The game features:

- **Animal-based cards** with emoji representations, each having unique stats (attack, defense, speed, special abilities)
- **Field system** with 8 different field types that provide various buffs
- **Game board** with TUI (Text User Interface) display using emoji rendering
- **Multiple game modes**: `basic`, `elemental`, and `advanced`
- **Player hands** with hidden/opponent hand visibility mechanics

### Architecture

The project uses a **concatenation-based build system** that combines all Lua source files into separate bundles for the main game and battle module.

```
echeckers/
├── game/                # Source code (deployable)
│   ├── settings/        # Configuration and game settings
│   │   ├── configuration.lua
│   │   ├── modes/
│   │   │   └── basic.lua
│   │   └── player_options.lua
│   ├── battle/          # Battle gameplay module
│   │   ├── assets/      # Game data (animals, fields, buildings, items)
│   │   ├── board/       # Board management (board.lua, fields.lua)
│   │   ├── decks/       # Deck definitions
│   │   ├── functions/   # Game logic functions
│   │   ├── phases/      # Game phase implementations
│   │   ├── ui/          # UI rendering functions
│   │   └── validation/  # Input and move validation
│   ├── menus/           # Menu system files
│   ├── src/             # Source initialization files
│   ├── ui/              # User interface files
│   └── utils/           # Utility functions
│       ├── string/      # String utilities
│       └── table/       # Table utilities
│
├── development/         # Development tools and docs
│   ├── build_systems/   # Build scripts and configurations
│   ├── dry_run_tests/   # Bundle validation tests
│   ├── project_standards/  # Coding standards
│   ├── roles/           # Agent role definitions
│   ├── workflow/        # Development workflow docs
│   ├── changelog.md     # Project changelog
│   └── TODO_micro.md    # Task tracking
│
└── game/
    ├── processed_script.lua       # Built main game (generated)
    └── battle/processed_battle.lua # Built battle module (generated)
```

## Building and Running

### Build System

The project uses a custom multi-step build system supporting both Bash (Linux/macOS) and PowerShell (Windows):

```bash
# Build the project (from project root)
./development/build_systems/build_system

# Or on Windows PowerShell
.\development\build_systems\build.ps1

# Run the built script
lua game/processed_script.lua          # Main game
lua game/battle/processed_battle.lua   # Battle module
```

**Build Process:**
1. Reads configuration files (`build_main.txt`, `build_battle.txt`)
2. Concatenates all listed files into separate bundles
3. Directories are recursively scanned for all `.lua` files
4. Outputs:
   - `game/processed_script.lua` - Main game bundle
   - `game/battle/processed_battle.lua` - Battle module bundle

### Configuration

**`development/build_systems/build_main.txt`** - Core game files:
```
game/settings/configuration.lua
game/settings/modes/basic.lua
game/settings/player_options.lua
game/utils/string/string.center.lua
game/utils/string/string.split.lua
game/utils/table/table.print.lua
game/ui/main_menu.lua
game/menus/main_menu.lua
game/events/*.lua
game/src/*.lua
```

**`development/build_systems/build_battle.txt`** - Battle gameplay module:
```
game/settings/configuration.lua
game/assets/*.lua
game/battle/functions/*.lua
game/battle/board/*.lua
game/battle/phases/*.lua
game/battle/ui/*.lua
game/battle/decks/*.lua
game/battle/battle.lua
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
./development/build_systems/build_system && lua game/processed_script.lua
```

## Key Components

### Settings

- **`configuration.lua`** - Global game settings (BUILD, MODE, UI)
- **`modes/basic.lua`** - Basic game mode constants and configurations
- **`player_options.lua`** - Player-specific options and settings

### Assets (game/battle/)

- **`animals.lua`** - ~150+ animal cards with emoji, stats, and abilities
  - Emojis with variation selectors (🕷️, 🐻 ❄️) have trailing spaces for consistent terminal rendering
- **`biomes.lua`** - 8 field types with emoji, color, and effect modifiers
- **`buildings.lua`** - Building cards with special effects
- **`items.lua`** - Item definitions

### Game Phases (game/battle/phases/)

- **`0_setup.lua`** - Game setup phase (field selection, hand drawing)
- **`1_draw_phase.lua`** - Card drawing logic
- **`2_standby_phase.lua`** - Player action phase (place/move cards)
- **`3_battle_phase.lua`** - Battle resolution
- **`4_end_phase.lua`** - Turn end and cleanup

### UI Functions (game/battle/ui/)

- **`UI.display.lua`** - General display utilities
- **`UI.input.lua`** - Handles terminal input for numbers and text, with menu support
- **`UI.update_board(board)`** - Renders the game board with emoji cells, field colors, and special cell highlighting
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

### Terminology

- **field** - Playing area slot (1-6 per player)
- **card** - Animal card placed on fields
- **Board** - Global game state table

### Coding Standards

See `development/project_standards/lua_best_practices.md` for complete guidelines.

**Key Points:**
- C-based for loops only (no ipairs/pairs)
- Local variables by default
- Globals only for game state (Board, Hands, Player_turn)
- No return statements (files are concatenated)
- String concatenation with `..` for small strings
- Minimize function arguments (exponential performance cost)

### Agent-Based Workflow

The project uses a multi-agent development workflow:
- **Code Agent** - Source code implementation
- **Build Agent** - Build system maintenance
- **Test Agent** - Automated testing
- **Quality Agent** - Code quality checks
- **Docs Agent** - Documentation synchronization
- **Architect Agent** - Architecture oversight
- **Dry-Run Test Agent** - Bundle validation
- **Release Agent** - Release coordination

See `development/roles/` for detailed agent documentation.

## Current Status

### Implemented
- **Phases:** Setup, Draw, Standby, Battle, and End phases
- **Board:** Flat structure with 6 fields per player + special cells (Deck, Trash, LIFE, BIOMATTER)
- **UI:** Enhanced TUI with color support, pagination, and detailed card stats
- **Input:** Basic input system implemented
- **Build System:** Multi-step build with Bash and PowerShell support
- **Validation:** Dry-run test suite for bundle validation
- **Documentation:** Complete agent-based workflow and coding standards

### Terminology
- **field** - Playing area (replaces "biome")
- **card** - Game piece (replaces "animal")
- **fieldsOps** - Field operations module
- **boardModule** - Board management module

### TODO
- Full integration testing
- Battle phase polish
- Input integration with UI.input()
- Platform: Currently TUI-only

## Contact

- Author: vgois032@gmail.com
- Note: Single-maintainer project, suggestions welcome but no active help needed
