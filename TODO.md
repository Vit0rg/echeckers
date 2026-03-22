# Starting phase (TUI)

## Step 1:
[OK] Prototype and brainstorm possible mechanics

## Step 2:
[OK] Create initial project structure

## Step 3:
[OK] Setup board

## Step 4:
[OK] Phase logic, ui and architecture:
- Add setup_hand() in ./phases/0_setup.lua

## Step 5:
[OK] Separate logic from visual in the setup phase

## Step 6:
[OK] Create draw system (1_draw_phase.lua)
[] Add proper navigation to hand (UI.update_hand)

## Step 7:
[OK] Create Standby (set animals on board, apply specials)
    -- Implemented: _set_animal(), _remove_animal(), _move_animal(), _move_biome()
    -- Input integration pending (Step 10)

## Step 8:
[] Create Battle logic and ui

## Step 9:
[] Create End phase logic and ui

## Step 10:
[] Add input mechanic
    -- [OK] _TUI_input (basic implementation)
    -- [ ] _TUI_menu_input
    -- [ ] Integrate input into Standby phase actions

## Step 11:
[] Test and Optimize
