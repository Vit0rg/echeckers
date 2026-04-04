# Code Review Findings

---

## Review - Step 9: Critical Bug Fixes (Resolved)

### Review Summary

All 5 critical issues and 3 suggestions from the previous review have been **resolved**. The codebase now passes build and dry-run tests.

### Resolved Issues

| Issue | Status | Fix Applied |
|-------|--------|-------------|
| P1: `valid_field_index` always true | ✅ Fixed | Now compares `index` against bounds |
| P2: `Trashs` vs `Trash` mismatch | ✅ Fixed | Renamed to `Trash`, simplified init |
| P3: Missing `validate_remove_card` | ✅ Fixed | Renamed from `validate_remove_animal` |
| P4: `_discard` infinite recursion | ✅ Fixed | Replaced with placeholder message |
| P5: `input` nil for non-TUI | ✅ Fixed | Default `input = 1` before BUILD check |
| P6: Redundant global lookup | ✅ Fixed | Uses `hand[#hand]` local reference |
| P7: No destination check | ✅ Fixed | Added `fieldsOps.is_empty(to_field)` check |
| P8: Tables recreated per call | ✅ Fixed | Moved to file-level scope |

### Verification
- Build: ✅ Succeeded (2636 lines battle, 387 lines main)
- Dry-Run Tests: ✅ 9/9 passed

---

## Review - Steps 8.14 to 8.18 (Archive)

### Review Summary

Review of the last 5 commits covering shuffle hand implementation, standby phase fixes, documentation cleanup, and README updates. 5 critical issues found that cause runtime crashes or logic failures.

---

### Critical Issues

#### P1: `valid_field_index` always returns true
**File:** `game/battle/validation/2_standby_validation.lua:11-14`
**Issue:** Compares constants to themselves (`min_index >= 1 and max_index <= 6`) instead of checking the `index` parameter. Always evaluates to `true`.
**Impact:** All field index validation is bypassed. Any value (including -100 or 999) passes validation, leading to out-of-bounds access.
**Fix:**
```lua
function standbyValidation.valid_field_index(index)
    return type(index) == 'number' and index >= 1 and index <= 6
end
```

#### P2: `Trash` vs `Trashs` global name mismatch
**File:** `game/battle/phases/0_setup.lua:61`
**Issue:** Setup creates `Trashs` (typo, extra 's'), but `_remove_card` in `2_standby_phase.lua` references `Trash`.
**Impact:** Removing a card crashes with "attempt to get length of a nil value".
**Fix:** Rename `Trashs` to `Trash` in `_setup_trash`:
```lua
Trash = { true, true }
Trash[1] = {}
Trash[2] = {}
```

#### P3: `validate_remove_card` function does not exist
**File:** `game/battle/phases/2_standby_phase.lua:69`
**Issue:** Calls `standbyValidation.validate_remove_card()`, but the validation file still defines `validate_remove_animal`.
**Impact:** "Remove Card" action crashes with "attempt to call a nil value".
**Fix:** Rename the function in `2_standby_validation.lua` to `validate_remove_card`.

#### P4: `_discard` infinite recursion
**File:** `game/battle/phases/1_draw_phase.lua:8-11`
**Issue:** `_discard` calls itself recursively with no base case change or card removal.
**Impact:** Stack overflow crash when hand exceeds `HAND_LIMIT`.
**Fix:** Replace recursion with a placeholder:
```lua
local _discard = function()
    if #Hands[Player_turn] > HAND_LIMIT then
        UI.display("Discard one card (not yet implemented)")
    end
end
```

#### P5: `input` is nil for non-TUI builds
**File:** `game/battle/phases/2_standby_phase.lua:158-161`
**Issue:** The `else` branch that set `input = 1` was removed. Only the `if BUILD == 'TUI'` branch assigns `input`.
**Impact:** Non-TUI builds silently fail at standby phase — no action can ever be selected.
**Fix:**
```lua
local input = 1  -- Default placeholder
if BUILD == 'TUI' then
    -- TODO: Integrate with UI.input()
end
```

---

### Suggestions

#### P6: `_shuffle_hand` uses redundant global lookup
**File:** `game/battle/phases/2_standby_phase.lua:22-24`
**Issue:** `hand[i] = Hands[Player_turn][#Hands[Player_turn]]` performs global lookup instead of using local `hand` reference.
**Fix:** `hand[i] = hand[#hand]`

#### P7: `_move_card` lacks destination occupancy check
**File:** `game/battle/phases/2_standby_phase.lua:90-108`
**Issue:** Does not check if destination field is occupied before moving.
**Fix:** Add `fieldsOps.is_empty(to_field)` check or document swap behavior.

---

### Nice to Have

#### P8: `options` and `actions` tables recreated every call
**File:** `game/battle/phases/2_standby_phase.lua:145-146`
**Fix:** Move to file-level scope since they are constant.

---

### Verdict

**Request Changes** — 5 critical issues that cause runtime crashes or logic failures. The "Remove Card" action is doubly broken (missing function + nil global), field validation is completely bypassed, and `_discard` will stack-overflow.

---

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
