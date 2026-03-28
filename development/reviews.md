# Code Review - Step 7: Project Structure Reorganization

## Review Summary

This review covers the major project reorganization changes including:
- Build system moved to `build_systems/` directory
- Project structure reorganized (settings/, menus/, utils/string/, utils/table/)
- Multi-step build system with separate configurations
- Comprehensive documentation updates (README.md, changelog.md, TODO_macro.md)

---

## Critical Issues - Need to Fix

### Priority 1: Input System Broken
**File:** `battle/ui/UI.input.lua:7`
**Issue:** `UI.input()` calls `_TUI_display()` instead of `_TUI_input()`
**Impact:** Input collection is completely broken; game cannot accept player input
**Fix:**
```lua
UI.input = function(input_handler, is_menu)
    if BUILD == 'TUI' then
        _TUI_input(input_handler, is_menu)  -- Changed from _TUI_display
    end
end
```

### Priority 2: No Turn Switching Logic
**File:** `battle/battle.lua`
**Issue:** `Player_turn` is set during setup but never toggles between turns
**Impact:** Game loop runs but always uses the same player; game cannot progress
**Fix:** Add turn switching after each iteration:
```lua
Player_turn = (Player_turn % 2) + 1  -- Toggle between 1 and 2
```

### Priority 3: Git State - Reorganization Not Committed
**Issue:** Files deleted from git tracking but new versions untracked
**Impact:** Repository is broken for collaborators; build will fail
**Fix:** Stage and commit all changes: `git add -A && git commit`

### Priority 4: Circular Reference Crash Risk
**File:** `utils/table/table.copy.lua`
**Issue:** Deep copy has no circular reference detection
**Impact:** Stack overflow on any table with circular references
**Fix:** Add visited table tracking (see `table.print.lua` for pattern)

### Priority 5: String Replacement Bug
**File:** `utils/string/string.replace.lua:4`
**Issue:** Double-escapes `%` in replacement string
**Impact:** Replacements produce wrong output (`%%` becomes `%%%%`)
**Fix:** Remove the replacement escaping line

### Priority 6: Inconsistent Return Values
**File:** `battle/phases/0_setup.lua:74-87`
**Issue:** Returns `nil` for 'basic' mode but `1, 2, 3` for others; return values never consumed
**Impact:** Type inconsistency could cause bugs; dead code
**Fix:** Either remove returns or make consistent with `return 0` for success

---

## Suggestions - Recommended Improvements

### Priority 7: Missing Nil Check
**File:** `battle/board/board.lua:117`
**Issue:** `swap_biomes()` has no initialization check before accessing `Board[idx1]`
**Fix:** Add `if not Board then return end`

### Priority 8: No Input Validation
**File:** `battle/board/board.lua:24-30`
**Issue:** `biome_index()` doesn't validate `index` is 1-6 range
**Fix:** Add bounds checking with error message

### Priority 9: Duplicated Logic
**File:** `utils/string/string.center.lua`
**Issue:** ~40 lines duplicated from `char_width.lua`
**Fix:** Call `string.char_width()` instead

### Priority 10: Table Allocation on Every Call
**File:** `battle/ui/tui_colors.lua:38`
**Issue:** `emoji_padding_overrides` created fresh on each `format_emoji_field()` call
**Fix:** Move to module scope as constant

### Priority 11: Obsolete File
**File:** `build_systems/build_files.txt`
**Issue:** Still exists but marked as obsolete in changelog
**Fix:** Remove the file

### Priority 12: Empty File
**File:** `settings/player_options.lua`
**Issue:** File exists but has no content (0 bytes)
**Fix:** Add content or remove if unused

### Priority 13: Hardcoded Test Value
**File:** `menus/main_menu.lua:43`
**Issue:** `local input = 1` bypasses menu selection
**Fix:** Implement actual input handling

### Priority 14: Inconsistent Parameter Naming
**File:** `battle/validation/2_standby_validation.lua`
**Issue:** Uses `index` while `BiomesOps` uses `slot`
**Fix:** Rename to `slot` for consistency

---

## Nice to Have - Optional Improvements

### Priority 15: Outdated Comments
**File:** `battle/board/board.lua:2-7`
**Issue:** Comments mention indices 13-20 that don't exist (now named fields)
**Fix:** Update comments to reflect actual structure

### Priority 16: Random Seed on Every Include
**File:** `settings/configuration.lua:4`
**Issue:** `math.randomseed(os.time())` runs on every file include
**Fix:** Move to `src/main.lua` entry point

### Priority 17: Build Artifacts in Repo
**Files:** `processed_script.lua`, `battle/processed_battle.lua`
**Issue:** Generated files should be in `.gitignore`
**Fix:** Add to `.gitignore`

---

## Review Dimensions

### Correctness & Security
- ✅ No security vulnerabilities found
- ❌ Input system broken (Priority 1)
- ❌ Circular reference crash risk (Priority 4)
- ❌ String replacement bug (Priority 5)

### Code Quality
- ✅ Good separation of concerns
- ✅ Consistent coding style
- ❌ Inconsistent parameter naming (Priority 14)
- ❌ Duplicated logic (Priority 9)
- ❌ Outdated comments (Priority 15)

### Performance & Efficiency
- ✅ Flat board structure improves access speed
- ✅ Separate build bundles reduce memory footprint
- ❌ Table allocation on every call (Priority 10)
- ❌ No color caching in UI rendering

### Undirected Audit
- ❌ No turn switching logic (Priority 2)
- ❌ Git state broken (Priority 3)
- ❌ Empty/placeholder files exist (Priority 12)
- ❌ Hardcoded test values (Priority 13)

---

## Verdict

**Request Changes** — Has 6 critical issues that need fixing before the game can function correctly.

The architectural improvements (flat board structure, better organization, multi-step build) are excellent, but the critical bugs prevent the game from functioning correctly.

---

## Next Steps

1. Fix Priority 1-3 issues immediately (input system, turn switching, commit changes)
2. Address Priority 4-6 before next development cycle
3. Work through Priority 7-14 as time permits
4. Consider Priority 15-17 for polish and optimization
