# Project Architecture

## Overview

**ECHECKERS** is organized into two main directories:
- **`game/`** - All source code and runtime files
- **`development/`** - Build tools, documentation, and development artifacts

This separation ensures clean boundaries between deployable game code and development infrastructure.

---

## Directory Structure

```
echeckers/
├── game/                          # Source code (deployable)
│   ├── assets/                    # Game data definitions
│   │   ├── animals.lua            # 150+ animal cards with stats and abilities
│   │   ├── biomes.lua             # 8 biome definitions with effects
│   │   ├── buildings.lua          # Building card definitions
│   │   └── items.lua              # Item card definitions
│   │
│   ├── battle/                    # Battle gameplay module
│   │   ├── assets/                # Battle-specific assets
│   │   ├── board/                 # Board management
│   │   │   ├── board.lua          # Flat board structure and helpers
│   │   │   └── biomes.lua         # Biome operations (set, remove, move)
│   │   ├── decks/                 # Deck definitions
│   │   │   └── default.lua        # Default deck configuration
│   │   ├── functions/             # Game logic functions
│   │   │   ├── card_processor.lua # Transform card data with SCALE
│   │   │   ├── draw_card.lua      # Card drawing logic
│   │   │   ├── get_random_biomes.lua # Biome selection
│   │   │   ├── random_deck_generator.lua # Deck generation
│   │   │   ├── select_deck.lua    # Deck selection
│   │   │   └── update_players.lua # Player state updates
│   │   ├── phases/                # Game phase implementations
│   │   │   ├── 0_setup.lua        # Setup phase (biomes, hands, board)
│   │   │   ├── 1_draw_phase.lua   # Card drawing phase
│   │   │   ├── 2_standby_phase.lua # Player action phase
│   │   │   ├── 3_battle_phase.lua # Battle resolution
│   │   │   └── 4_end_phase.lua    # Turn end and cleanup
│   │   ├── ui/                    # Battle UI rendering
│   │   │   ├── tui_colors.lua     # ANSI color utilities
│   │   │   ├── UI.display.lua     # General display utilities
│   │   │   ├── UI.input.lua       # Terminal input handling
│   │   │   ├── UI.update_board.lua # Board rendering
│   │   │   └── UI.update_hand.lua # Hand rendering with pagination
│   │   ├── validation/            # Input and move validation
│   │   │   └── 2_standby_validation.lua # Standby phase validation
│   │   ├── battle.lua             # Main battle loop
│   │   └── processed_battle.lua   # Built battle module (generated)
│   │
│   ├── events/                    # Event handlers
│   │   ├── chatCommand.lua        # Chat command events
│   │   ├── keyboard.lua           # Keyboard input events
│   │   ├── loop.lua               # Game loop events
│   │   ├── newPlayer.lua          # New player events
│   │   ├── playerLeft.lua         # Player disconnect events
│   │   └── textAreaCallback.lua   # Text area callbacks
│   │
│   ├── menus/                     # Menu system
│   │   └── main_menu.lua          # Main menu entry point
│   │
│   ├── settings/                  # Configuration and settings
│   │   ├── configuration.lua      # Global settings (BUILD, MODE, UI)
│   │   ├── modes/
│   │   │   └── basic.lua          # Basic game mode constants
│   │   └── player_options.lua     # Player-specific options
│   │
│   ├── src/                       # Source initialization
│   │   ├── init.lua               # Game initialization
│   │   └── main.lua               # Main entry point
│   │
│   ├── ui/                        # User interface
│   │   ├── maps/                  # UI map definitions
│   │   │   └── default.xml        # Default UI layout
│   │   └── main_menu.lua          # Main menu UI
│   │
│   ├── utils/                     # Utility functions
│   │   ├── string/                # String utilities
│   │   │   ├── char_width.lua     # Character width calculation
│   │   │   ├── string.center.lua  # Center text with emoji support
│   │   │   ├── string.replace.lua # String replacement
│   │   │   └── string.split.lua   # String splitting
│   │   └── table/                 # Table utilities
│   │       ├── table.copy.lua     # Deep table copying
│   │       ├── table.print.lua    # Recursive table printing
│   │       └── table.unpack.lua   # Table unpacking
│   │
│   └── processed_script.lua       # Built main game (generated)
│
├── development/                   # Development tools and docs
│   ├── build_systems/             # Build system scripts
│   │   ├── build_system           # Bash build script (Linux/macOS)
│   │   ├── build.ps1              # PowerShell build script (Windows)
│   │   ├── build_main.txt         # Main game build configuration
│   │   ├── build_battle.txt       # Battle module build configuration
│   │   └── build_files.txt        # Legacy build config (obsolete)
│   │
│   ├── sketches/                  # Design sketches and prototypes
│   │   ├── board                  # Board layout sketches
│   │   └── main_menu              # Menu design sketches
│   │
│   ├── changelog.md               # Project changelog
│   ├── reviews.md                 # Code review findings
│   ├── TODO_macro.md              # High-level task tracking
│   ├── TODO_micro.md              # Detailed task tracking
│   └── project_architecture.md    # This file
│
├── .gitignore                     # Git ignore rules
└── README.md                      # Project overview
```

---

## Build System

### Location
Build scripts are located in `development/build_systems/` to separate development tools from game source code.

### Configuration Files

**`build_main.txt`** - Main game bundle:
- Includes: settings, utils, ui, menus, events, src
- Excludes: battle/ folder content
- Output: `game/processed_script.lua`

**`build_battle.txt`** - Battle module bundle:
- Includes: all battle/ folder content
- Output: `game/battle/processed_battle.lua`

### Build Process

```bash
# From project root
./development/build_systems/build_system      # Linux/macOS
.\development\build_systems\build.ps1         # Windows PowerShell
```

### Build Outputs
- `game/processed_script.lua` - Main game bundle (~350 lines)
- `game/battle/processed_battle.lua` - Battle module bundle (~2500 lines)

---

## Key Architectural Decisions

### 1. Source/Development Separation
**Decision:** All runtime code in `game/`, all development tools in `development/`

**Rationale:**
- Clear boundary between deployable and non-deployable files
- Easier to package and distribute game code
- Development tools don't clutter source tree
- Simplifies CI/CD pipelines

### 2. Flat Board Structure
**Decision:** Board uses flat array (indices 1-12) instead of nested tables

**Rationale:**
- Simpler access: `Board[1]` vs `Board.biomes[2][1]`
- Less memory: No duplicate layout tables
- Faster operations: Direct index access
- Cleaner code: Helper functions encapsulate mapping logic

### 3. Multi-Step Build
**Decision:** Separate builds for main game and battle module

**Rationale:**
- Modular development - work on battle independently
- Smaller build artifacts
- Faster iteration during development
- Clear separation of concerns

### 4. Utility Organization
**Decision:** Utils organized by type (string/, table/) with namespaced functions

**Rationale:**
- Extends Lua built-in types (string.*, table.*)
- Clear categorization of utilities
- Easy to find and add new utilities
- Consistent naming conventions

### 5. Phase-Based Game Loop
**Decision:** Numbered phase files (0_setup, 1_draw, 2_standby, etc.)

**Rationale:**
- Explicit execution order
- Easy to add/modify phases
- Clear separation of game logic
- Simplifies debugging and testing

---

## Data Flow

### Game Initialization
```
src/main.lua
    ↓
src/init.lua
    ↓
settings/configuration.lua (BUILD, MODE)
    ↓
menus/main_menu.lua
```

### Battle Flow
```
battle/battle.lua
    ↓
phases/0_setup.lua → phases/1_draw_phase.lua → phases/2_standby_phase.lua
    ↓                                              ↓
phases/4_end_phase.lua ← phases/3_battle_phase.lua
```

### Build Flow
```
development/build_systems/build_system
    ↓
Reads: build_main.txt, build_battle.txt
    ↓
Scans: game/**.lua
    ↓
Outputs: game/processed_script.lua, game/battle/processed_battle.lua
```

---

## Conventions

### File Naming
- **Modules:** `snake_case.lua` (e.g., `card_processor.lua`)
- **UI files:** `PascalCase` with prefix (e.g., `UI.update_board.lua`)
- **Phases:** Number prefix for order (e.g., `0_setup.lua`)
- **Utilities:** Type prefix (e.g., `string.center.lua`, `table.print.lua`)

### Code Style
- **Globals:** Intentional for game state (`Board`, `Hands`, `Deck_p1/p2`)
- **UI namespace:** All UI functions on `UI` table
- **Internal functions:** Prefix with `_` (e.g., `_setup_biomes()`)
- **Diagnostics:** Use `---@diagnostic disable` for intentional patterns

### Emoji Handling
- Emojis with variation selectors have trailing space for consistent rendering
- `string.center()` strips trailing spaces before centering
- Visual width: emoji = 2 chars, ASCII = 1 char

---

## Future Considerations

### Potential Improvements
1. **Dependency Injection** - Reduce global state coupling
2. **Module System** - Consider Lua modules for better encapsulation
3. **Testing Framework** - Add unit tests for core logic
4. **Asset Pipeline** - Automate asset processing and optimization
5. **Localization** - Separate text resources for multi-language support

### Scalability
- Current structure supports adding new game modes easily
- Battle module can be extended independently
- Build system can accommodate additional bundles
- Utility libraries can grow without affecting core logic
