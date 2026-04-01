# Changelog

All notable changes to this project will be documented in this file.

## [Unreleased]

### Step 8.3 - Validation Module Localization

### Changed
- **Standby Validation** (`game/battle/validation/2_standby_validation.lua`)
  - Localized module: `StandbyValidation` → `local standbyValidation`
  - Functions now access global state directly (no arguments for player/hand)
  - Simplified function signatures:
    - `validate_set_animal(hand_index, biome_index)` - Uses `Player_turn`, `Hands`
    - `validate_remove_animal(biome_index)` - Uses `Player_turn`
    - `validate_biome_move(from_biome, to_biome)` - Uses `Player_turn`
  - Module exported at end: `StandbyValidation = standbyValidation`

- **Standby Phase** (`game/battle/phases/2_standby_phase.lua`)
  - Updated validation calls to use simplified signatures
  - Removed redundant `turn` variable, uses `Player_turn` directly
  - Added `Uses globals:` documentation comments

### Benefits
- **Cleaner API** - Validation functions don't need redundant arguments
- **Consistent pattern** - Matches project convention of global state access
- **Localized module** - Internal functions not polluting global scope
- **Simpler calls** - Less boilerplate in standby phase functions

### Step 8.2 - Dry-Run Test Agent and Bundle Validation

### Added
- **Dry-Run Test Agent** (`development/roles/dry-run-test-agent.md`)
  - New agent role for bundle-level validation
  - Detects premature `return` statements in concatenated files
  - Validates function definitions in phase files
  - Tests build artifact integrity
- **Dry-Run Test Suite** (`development/dry_run_tests/test_bundle.lua`)
  - Checks phase files for module return patterns
  - Verifies bundle has no file-scope returns
  - Validates expected function definitions
  - 9/9 tests passing

### Fixed
- **Standby Phase** (`game/battle/phases/2_standby_phase.lua`)
  - Removed `return standby` at end of file
  - Added comment warning against module pattern in concatenated files
  - Changed from module return to script pattern

### Changed
- **Workflow** (`development/workflow/current_workflow.md`)
  - Added Dry-Run Test Agent to validation phase
  - Updated handoff sequences to include bundle validation
  - Added agent communication channels for Dry-Run Test Agent

### Benefits
- **Early detection** - Bundle-level issues caught before commit
- **Prevents crashes** - No more premature returns in concatenated files
- **Validated integration** - Phase files work correctly when bundled
- **Clear patterns** - Script pattern vs module pattern documented

### Step 8.1 - Standby Phase Implementation

### Fixed
- **Standby Phase** (`game/battle/phases/2_standby_phase.lua`)
  - Replaced undefined `fieldsOps` with `BiomesOps` module
  - Fixed function names to match biome terminology:
    - `_set_card()` → `_set_animal()`
    - `_remove_card()` → `_remove_animal()`
    - `_move_card()` → `_move_animal()` (was placeholder, now implemented)
    - `_move_field()` → `_move_biome()`
  - Implemented `_move_animal()` with full validation
  - Added proper input handling structure (TODO: integrate UI.input())
  - Added LuaDoc style documentation for all functions
  - Fixed validation function calls to use correct names

### Changed
- **Standby Phase** (`game/battle/phases/2_standby_phase.lua`)
  - Updated menu options to reflect correct terminology
  - Improved UI output with player turn indicator
  - Added return value for success/failure tracking
  - Consistent parameter naming (biome_index instead of field_index)

### Benefits
- **Correct module usage** - BiomesOps instead of undefined fieldsOps
- **Complete implementation** - All 4 standby actions now functional
- **Better documentation** - All functions have doc comments
- **Consistent terminology** - Aligns with board/biomes.lua naming

### Step 6.5 - Flat Board Structure

### Changed
- **Board Structure** (`battle/board/board.lua`)
  - Replaced nested tables (`Board.biomes[player][index]`) with flat table
  - Index mapping: 1-6 = Player 2 biomes, 7-12 = Player 1 biomes
  - Direct access: `Board[1]` = P2 biome 1, `Board[7]` = P1 biome 1
  - Removed redundant `Board.layout` table - layout generated on-demand
  - Added helper functions:
    - `BoardModule.biome_index(player, slot)` - Convert player/slot to flat index
    - `BoardModule.biome_player(index)` - Get player from flat index
    - `BoardModule.biome_slot(index)` - Get slot from flat index
    - `BoardModule.get_layout_row(player)` - Generate visual row for UI
    - `BoardModule.get_middle_row()` - Get middle SETUP row
    - `BoardModule.swap_biomes(player, slot1, slot2)` - Swap two biomes

- **Biome Operations** (`battle/board/biomes.lua`)
  - Simplified to use flat board access via `BoardModule.get_biome()`
  - Removed `BoardModule.sync()` call (no separate layout to sync)
  - All operations now directly modify the flat board table

- **UI Rendering** (`battle/ui/UI.update_board.lua`)
  - Updated to use `BoardModule.get_layout_row()` for visual data
  - Removed `board.layout` and `board.rows` references
  - VISUAL_MAP now calls board module functions directly

- **Setup Phase** (`battle/phases/0_setup.lua`)
  - Updated to use `BoardModule.init()` with flat structure

### Benefits
- **Simpler access** - `Board[1]` instead of `Board.biomes[2][1]`
- **Less memory** - No duplicate layout tables
- **Faster operations** - Direct index access, no nested lookups
- **Cleaner code** - Helper functions encapsulate index mapping logic

### Step 6.4 - Multi-Step Build System and Project Reorganization

### Implemented
- **Multi-Step Build System** (`build_system`, `build.ps1`)
  - Refactored from single-file to multi-step build process
  - Separate build configurations for main game and battle module
  - Bash script: Supports associative arrays for build steps with error handling
  - PowerShell script: Parallel functionality for Windows development
  - Build output shows file count and line count per step
  - Clear visual separation between build steps with formatted output

- **Build Configuration Files**
  - `build_main.txt` - Core game files (configuration, events, src, utils, ui/main_menu)
  - `build_battle.txt` - Battle gameplay module (all battle/ folder content)

- **Build Outputs**
  - `processed_script.lua` - Main game bundle (230 lines)
  - `battle/processed_battle.lua` - Battle module bundle (2506 lines)

### Changed
- **Project Structure** - All battle gameplay files moved to `battle/` directory:
  - `battle/assets/` - Game assets (animals, biomes, buildings, items)
  - `battle/functions/` - Game logic functions
  - `battle/board/` - Board management modules
  - `battle/phases/` - Game phase implementations
  - `battle/ui/` - UI rendering functions
  - `battle/validation/` - Input and move validation
  - `battle/decks/` - Deck definitions

- **Main Game Scope** - Core framework files remain at root level:
  - `configuration.lua` - Global configuration
  - `modes/` - Game mode definitions
  - `utils/` - Utility functions
  - `events/` - Event handlers
  - `src/` - Source initialization files
  - `ui/main_menu.lua` - Main menu UI

### Removed
- `build_files.txt` - Replaced by separate build configurations
- Root-level game logic files (moved to `battle/`)

### Build System Features
- Automatic file discovery from config entries
- Directory scanning for `.lua` files
- Warning messages for missing files
- Build failure detection and reporting
- Cross-platform support (Bash for Linux/macOS, PowerShell for Windows)

### Step 6.3 - Board Refactoring

### Implemented
- **Board Module** (`board/board.lua`)
  - Added `BoardModule.init()` - Initialize board with separated biome data and visual layout
  - Added `BoardModule.get_biome()` - Get biome by player and index
  - Added `BoardModule.get_row()` - Get player's visual row (1 for P2, 3 for P1)
  - Added `BoardModule.get_column()` - Get column index for biome in layout
  - Added `BoardModule.sync()` - Sync layout with biome changes
  - New structure: `Board.biomes` for game logic, `Board.layout` for UI rendering

- **Biome Operations** (`board/biomes.lua`)
  - Added `BiomesOps.is_empty()` - Check if biome has no animal
  - Added `BiomesOps.set_animal()` - Place animal on biome
  - Added `BiomesOps.remove_animal()` - Remove animal from biome
  - Added `BiomesOps.move()` - Swap two biomes
  - Added `BiomesOps.get_animal()` - Get animal on biome
  - Added `BiomesOps.get_def()` - Get biome definition

- **Validation Module** (`board/validation.lua`)
  - Added `Validation.valid_biome_index()` - Validate biome index (1-6)
  - Added `Validation.valid_player()` - Validate player index (1 or 2)
  - Added `Validation.validate_biome_move()` - Validate biome swap operation
  - Added `Validation.validate_set_animal()` - Validate placing animal
  - Added `Validation.validate_remove_animal()` - Validate removing animal

### Changed
- **Board Structure** (`phases/0_setup.lua`)
  - Refactored to use `BoardModule.init()` for board initialization
  - Changed from flat array to structured `{biomes, layout}` format
  - Biome data now stored as `{def, animal}` instead of `{biome, state}`

- **Standby Phase** (`phases/2_standby_phase.lua`)
  - Refactored to use `BiomesOps` and `Validation` modules
  - Removed redundant validation logic
  - Simplified `_set_animal()`, `_remove_animal()`, `_move_biome()` functions

- **Board Rendering** (`ui/functions/UI.update_board.lua`)
  - Refactored to use table-driven dispatch with `cell_extractors`
  - Removed if-elseif chains for cell content detection
  - Removed legacy format support
  - Added proper color handling for string cells (Deck, Trash, LIFE, BIOMATTER)
  - Changed `Board.rows` to `Board.layout` for better naming

- **Build Files** (`build_files.txt`)
  - Added `board/board.lua`, `board/biomes.lua`, `board/validation.lua`

### Removed
- **Redundant State Tracking** - Biome state now represented by `animal` field only (nil = empty)
- **ui/board.lua** - Removed redundant static board file
- **Legacy Cell Format Support** - Removed `{biome, index, card}` format handling

### Fixed
- **Colorless Setup/Layout** - String cells now properly colored via `CELL_COLORS[row][col]`

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

### Step 7 - Project Structure Reorganization and Build System Update

### Changed
- **Project Structure** - Reorganized directory layout for better separation of concerns:
  - `settings/` - Configuration and game mode definitions
    - `settings/configuration.lua` (moved from root)
    - `settings/modes/basic.lua` (moved from `modes/`)
    - `settings/player_options.lua` (new)
  - `menus/` - Menu system files
    - `menus/main_menu.lua`
  - `utils/` - Utility functions organized by type:
    - `utils/string/` - String utilities (`string.center.lua`, `string.split.lua`, `string.replace.lua`, `char_width.lua`)
    - `utils/table/` - Table utilities (`table.print.lua`, `table.copy.lua`, `table.unpack.lua`)
  - `events/` - Event handlers (unchanged location)
  - `src/` - Source initialization files (unchanged location)
  - `ui/` - UI files (`ui/main_menu.lua`)
  - `battle/` - Battle gameplay module (unchanged)

- **Build System** (`build_systems/`)
  - Updated `build_system` (Bash) to navigate to project root before building
  - Updated `build.ps1` (PowerShell) to navigate to project root before building
  - Updated `build_main.txt` with new file paths:
    - Added `settings/`, `menus/`, `utils/string/`, `utils/table/` paths
    - Added new utility files: `char_width.lua`, `string.replace.lua`, `table.unpack.lua`
    - Added `menus/main_menu.lua` and `ui/main_menu.lua`
  - Updated `build_battle.txt` to include `settings/configuration.lua`

- **Build Configuration Files**
  - Removed `build_systems/build_files.txt` (obsolete, replaced by `build_main.txt` and `build_battle.txt`)

### Benefits
- **Better organization** - Configuration and settings separated from game logic
- **Clearer structure** - Utils organized by type (string vs table)
- **Scalable** - Easier to add new utilities and settings
- **Maintainable** - Related files grouped together

### Review Summary

**Code Review Completed** - 17 issues identified across 4 dimensions:

**Critical (Need to Fix):**
- Priority 1: Input system broken (`UI.input()` calls wrong function)
- Priority 2: No turn switching logic (game cannot progress)
- Priority 3: Git state broken (reorganization not committed)
- Priority 4: Circular reference crash risk (`table.copy()`)
- Priority 5: String replacement bug (double-escaping)
- Priority 6: Inconsistent return values (`setup()`)

**Suggestions (Recommended):** 8 issues (Priority 7-14)
- Missing nil checks, input validation, duplicated logic, obsolete files

**Nice to Have (Optional):** 3 issues (Priority 15-17)
- Outdated comments, random seed placement, build artifacts in repo

**Verdict:** Request Changes - Critical issues prevent game from functioning correctly.
See `reviews.md` for detailed findings and fix recommendations.

### Step 8 - Source Code and Development Separation

### Changed
- **Project Structure** - Separated source code from development files:
  - `game/` - All runtime source code (assets, battle, events, menus, settings, src, ui, utils)
  - `development/` - Build tools, documentation, and development artifacts
  - Clear boundary between deployable and non-deployable files

- **Build System** (`development/build_systems/`)
  - Updated `build_system` (Bash) to navigate two levels up to project root
  - Updated `build.ps1` (PowerShell) to navigate two levels up to project root
  - Updated `build_main.txt` paths to use `game/` prefix:
    - `settings/` → `game/settings/`
    - `utils/` → `game/utils/`
    - `ui/` → `game/ui/`
    - `menus/` → `game/menus/`
    - `events/` → `game/events/`
    - `src/` → `game/src/`
  - Updated `build_battle.txt` paths to use `game/` prefix:
    - All battle module paths now prefixed with `game/battle/`

- **Build Outputs**
  - `processed_script.lua` → `game/processed_script.lua`
  - `battle/processed_battle.lua` → `game/battle/processed_battle.lua`

- **Documentation**
  - Created `development/project_architecture.md` - Comprehensive architecture documentation
  - Updated `development/TODO_macro.md` - Added Step 8 tasks
  - Updated `development/changelog.md` - This entry

### Benefits
- **Clean separation** - Development tools don't clutter source tree
- **Easier deployment** - Only `game/` folder needed for distribution
- **Better organization** - Clear boundary between code and tools
- **Simplified CI/CD** - Build artifacts stay within `game/` folder
- **Scalable structure** - Easy to add new development tools without affecting source

### File Movements
- `build_systems/` → `development/build_systems/`
- `changelog.md` → `development/changelog.md`
- `reviews.md` → `development/reviews.md`
- `TODO_macro.md` → `development/TODO_macro.md`
- `TODO_micro.md` → `development/TODO_micro.md`
- `sketches/` → `development/sketches/`
- All source code → `game/` folder
