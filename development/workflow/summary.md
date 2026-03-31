# Development Cycle Summary

## Overview

This document summarizes the typical development cycle for the echeckers project based on historical commit patterns and development practices.

---

## Current Development Cycle

### Phase 1: Planning (Pre-Development)

1. **Task Definition**
   - Review `development/TODO_macro.md` for high-level objectives
   - Check `development/TODO_micro.md` for detailed implementation tasks
   - Identify scope of the current "Step" (feature/refactoring cycle)

2. **Architecture Review**
   - Consult `development/project_architecture.md` for structural constraints
   - Review `development/reviews.md` for known issues from previous cycles
   - Identify potential side effects on global state

### Phase 2: Implementation

1. **Code Development**
   - Create/modify source files in `game/` directory
   - Follow module pattern with explicit exports
   - Use internal function prefix `_` for private functions
   - Maintain separation: `game/` for source, `development/` for tools

2. **Build Configuration**
   - Update `development/build_systems/build_main.txt` for main game files
   - Update `development/build_systems/build_battle.txt` for battle module
   - Ensure path consistency across build configurations

3. **Documentation Updates**
   - Update `development/changelog.md` with changes under current Step
   - Mark completed items in TODO files
   - Update architecture documentation if structure changed

### Phase 3: Verification

1. **Build Testing**
   ```bash
   ./development/build_systems/build_system  # Linux/macOS
   .\development\build_systems\build.ps1     # Windows
   ```
   - Verify no errors in build output
   - Check file counts and line counts
   - Review WARNING messages for missing files

2. **Code Quality**
   - Manual review of changes
   - Check for circular references in table operations
   - Validate nil checks on public APIs
   - Ensure consistent parameter naming

3. **Git Hygiene**
   ```bash
   git status          # Review all changes
   git add -A          # Stage all changes
   git diff --staged   # Verify staged changes
   ```

### Phase 4: Commit

1. **Commit Message Format**
   ```
   Step X: [Short title describing the change]
   
   - Change 1
   - Change 2
   - Change 3
   
   [Benefits/Impact section if applicable]
   
   Co-authored-by: Qwen-Coder <qwen-coder@alibabacloud.com>
   ```

2. **Author Information**
   ```bash
   git commit -m "..." --author="Vit0rg <vgois032@gmail.com>"
   ```

3. **Post-Commit Verification**
   ```bash
   git status          # Should show clean working tree
   git log -n 1        # Verify commit message and author
   ```

---

## Historical Patterns

### Step Numbering Convention

| Pattern | Usage |
|---------|-------|
| `Step N` | Major feature/architecture changes |
| `Step N.M` | Incremental improvements within same scope |
| `Step N.M.P` | Hotfixes or minor adjustments |

**Examples from history:**
- Step 4 & 5: Phase logic and UI architecture
- Step 6: Draw system implementation
- Step 6.2: Standby phase and input system
- Step 6.3: Board refactoring
- Step 6.4: Multi-step build system
- Step 6.5: Flat board structure
- Step 7: Project reorganization
- Step 8: Source/development separation

### Common Change Patterns

1. **Feature Implementation** (Steps 4, 5, 6, 6.2)
   - Add new phase files (`phases/N_phase_name.lua`)
   - Update battle loop to include new phase
   - Add UI rendering functions
   - Update build configuration

2. **Refactoring** (Steps 6.3, 6.5, 7, 8)
   - Restructure existing modules
   - Update import paths in build configs
   - Maintain backward compatibility during transition
   - Document benefits in changelog

3. **Build System Changes** (Step 6.4, 7, 8)
   - Update path resolution in build scripts
   - Modify build configuration files
   - Ensure cross-platform compatibility (Bash/PowerShell)

4. **Bug Fixes** (Throughout all steps)
   - Fix identified in `development/reviews.md`
   - Applied across affected modules
   - Documented in changelog under current Step

---

## Global State Considerations

### Current Global Variables

```lua
-- Game State
Board = {}           -- Flat board structure (12 biomes)
Hands = {}           -- Player hands
Deck_p1 = {}         -- Player 1 deck
Deck_p2 = {}         -- Player 2 deck
Player_turn = number -- Current player (1 or 2)

-- Configuration
BUILD = "TUI"        -- Build target
MODE = "basic"       -- Game mode
SCALE = 100          -- Stat scaling factor

-- Constants
MAX_TURNS = 5
BIOMATTER = 3
HAND_SIZE = 4
```

### Side Effect Patterns

1. **Board Operations**
   - Changing `Board` structure affects:
     - UI rendering (`UI.update_board.lua`)
     - Validation logic (`validation/*.lua`)
     - Phase operations (`phases/*.lua`)

2. **Phase Changes**
   - Modifying phase execution affects:
     - Battle loop order (`battle.lua`)
     - State transitions
     - Turn management

3. **Build Configuration**
   - Path changes affect:
     - Both Bash and PowerShell scripts
     - File discovery logic
     - Output locations

---

## Pain Points Identified

### From Code Reviews (reviews.md)

1. **Priority 1-3 (Critical)**
   - Input system broken (wrong function call)
   - No turn switching logic
   - Git state management issues

2. **Priority 4-6 (High)**
   - Circular reference crash risk in `table.copy()`
   - String replacement bug (double-escaping)
   - Inconsistent return values

3. **Priority 7-14 (Medium)**
   - Missing nil checks
   - No input validation
   - Duplicated logic
   - Table allocation on every call
   - Empty/placeholder files
   - Hardcoded test values

4. **Priority 15-17 (Low)**
   - Outdated comments
   - Random seed on every include
   - Build artifacts in repo

### From Development Process

1. **Manual Verification**
   - No automated testing
   - Manual build verification required
   - Code review findings tracked manually

2. **Documentation Lag**
   - TODO files not always updated
   - Changelog updates sometimes forgotten
   - Architecture docs may be outdated

3. **Cross-Platform Issues**
   - Bash and PowerShell scripts can diverge
   - Path resolution differences
   - Testing on both platforms not automated

---

## Metrics

### Typical Step Duration

| Step Type | Commits | Files Changed | Lines Changed |
|-----------|---------|---------------|---------------|
| Feature | 1-3 | 5-15 | 200-1000 |
| Refactor | 1-2 | 10-30 | 100-500 |
| Build | 1 | 2-5 | 50-200 |
| Hotfix | 1 | 1-3 | 10-50 |

### Build Output Growth

| Step | Main Game | Battle Module |
|------|-----------|---------------|
| Step 6 | ~230 lines | ~2506 lines |
| Step 7 | ~350 lines | ~2500 lines |
| Step 8 | ~350 lines | ~2500 lines |

---

## Recommendations for Improvement

See `improved_development.md` for detailed suggestions on:
- Automated CI/CD pipelines
- Agent-based development workflow
- Separation of concerns with global state awareness
- Automated testing and validation
- Documentation automation
