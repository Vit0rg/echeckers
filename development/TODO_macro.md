# Macro TODO - High Level Tasks

## Step 1: Project Setup
[x] Update and sanitize project structure

## Step 2: Core Battle Logic
[x] Finish dry-run basic logic of 'battle' gameplay
[x] Implement input logic

## Step 3: Polish
[x] Polish and optimize 'battle' gameplay

## Step 4: Reorganization
[x] Reorganize project structure (settings/, menus/, utils/)
[x] Implement multi-step build system
[x] Implement flat board structure (Step 6.4, 6.5)
[x] Update build system for new project structure
[x] Code review and documentation (reviews.md)

## Step 5: Source Separation
[x] Separate source code (game/) from development files (development/)
[x] Update build system to use game/ folder exclusively

## Step 6: Standby Phase Fixes
[x] Fix valid_field_index always returning true (P1)
[x] Fix Trashs vs Trash global name mismatch (P2)
[x] Fix missing validate_remove_card function (P3)
[x] Fix _discard infinite recursion (P4)
[x] Fix input nil for non-TUI builds (P5)
[x] Optimize _shuffle_hand global lookup (P6)
[x] Add destination occupancy check to _move_card (P7)
[x] Move action tables to file scope (P8)

## Step 7: Remaining Work
[ ] Implement remaining battle phase logic
[ ] Full integration testing
[ ] Implement proper input handling (UI.input integration)
[ ] Implement battle phase combat resolution
[ ] Implement end phase cleanup
