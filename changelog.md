# Changelog

All notable changes to this project will be documented in this file.

## [Unreleased]

### Implemented
- **Standby Phase** (`phases/2_standby_phase.lua`)
  - Added `_set_animal()` - Place animal cards from hand to board biomes
  - Added `_remove_animal()` - Remove animals from biomes (placeholder)
  - Added `_move_animal()` - Move animals between biomes (placeholder)
  - Added `_move_biome()` - Move biome positions (placeholder)
  - Integrated standby phase into battle loop

- **Input System** (`ui/functions/UI.input.lua`)
  - Added `_TUI_input()` - Terminal input handler supporting number and text input
  - Added menu input structure (placeholder for future menu system)
  - Added `UI.input()` wrapper for build-target abstraction

- **Enhanced Board Rendering** (`ui/functions/UI.update_board.lua`)
  - Expanded board from 5 to 10 cells per row (6 biomes + Deck + Trash + LIFE + BIOMATTER)
  - Added visual mapping for complex board structure
  - Improved cell rendering with biome and card detection
  - Added ANSI color support for special cells (Deck, Trash, LIFE, BIOMATTER)
  - Added `center_ansi()` for proper text centering with escape codes

- **Enhanced Hand Display** (`ui/functions/UI.update_hand.lua`)
  - Added pagination navigation (`[<<]` and `[>>]` indicators)
  - Added `start_index` and `end_index` parameters for partial hand display
  - Improved card rendering with detailed stats (cost, health, speed, attack, defense)
  - Added color-coded stats display
  - Added hidden hand rendering with navigation

- **Color Utilities** (`ui/functions/tui_colors.lua`)
  - Added `hex_to_rgb()` - Convert hex colors to RGB values
  - Added `rgb_to_ansi256()` - Convert RGB to ANSI 256-color codes
  - Added `build_cell_colors()` - Build ANSI escape sequences
  - Added `format_emoji_field()` - Handle emoji padding for consistent rendering

- **Card Processing** (`functions/card_processor.lua`)
  - Added `process_card()` - Transform card data with SCALE multiplier
  - Converts base stats to game values (cost, health, speed, attack, defense)

- **Deck Management**
  - Updated `_draw_card()` to accept turn parameter
  - Improved deck handling with proper turn-based drawing

- **Configuration**
  - Added `BIOMATTER` and `MAX_BIOMATTER` globals
  - Added `HAND_SIZE` constant (default: 4)
  - Added `SCALE` constant (default: 100) for stat calculations

### Changed
- **Animal Stats** (`assets/animals.lua`)
  - Restructured animal data from `attack_base`/`defense_base` to `base_attack`/`base_defense`/`base_health`
  - Added `cost` attribute to all animals
  - Changed speed units from km/h to m/s
  - Updated all 150+ animal cards with new stat structure
  - Fixed emoji padding for consistent rendering

- **Board Structure** (`phases/0_setup.lua`)
  - Changed from 5-column to 10-column board layout
  - Biomes now span 6 positions (1-6) instead of 3
  - Updated board initialization to include all 6 biomes per player

- **Biome Selection** (`functions/get_random_biomes.lua`)
  - Increased `max_biomes` from 3 to 6

- **Game Mode** (`modes/basic.lua`)
  - Changed `MAX_TURNS` from 20 to 5
  - Added `BIOMATTER = 3` and `MAX_BIOMATTER = 10`
  - Added `HAND_SIZE = 4`

- **Battle Loop** (`battle.lua`)
  - Renamed `start_battle()` to `_start_battle()` (internal function convention)
  - Added standby phase execution after draw phase

- **Build System** (`build_system`)
  - Fixed `SCRIPT_DIR` to use absolute path resolution with `cd` and `pwd`

- **VSCode Settings** (`.vscode/settings.json`)
  - Added `undefined-global` to disabled diagnostics
  - Added `draw` to global diagnostics

- **Ocean Biome Color** (`assets/biomes.lua`)
  - Changed from `#0000FF` to `#4646FF`

- **Setup Phase** (`phases/0_setup.lua`)
  - Updated `_setup_starter()` to use `math.random(1, 2) == 1`
  - Updated `_setup_hands()` to use `HAND_SIZE` constant
  - Fixed turn management in hand setup

- **UI Hand Rendering** (`ui/functions/UI.update_hand.lua`)
  - Refactored navigation application to use table concatenation
  - Improved line building with table-based approach

### Fixed
- **Build System Path Resolution** - Fixed script directory detection for reliable builds
- **Emoji Rendering** - Consistent padding for special emojis (🦣, 🪲, 🕷️, ⭐, 🪰, 🦭, 🐻, 🪼, 🦤, 🦈)
- **ANSI Color Formatting** - Proper string formatting for color codes
- **Hand Navigation Display** - Fixed navigation indicator positioning

### Build Files
- **Updated** `build_files.txt` to include:
  - `ui/functions/tui_colors.lua`
  - `ui/functions/UI.input.lua`
  - `phases/2_standby_phase.lua`
