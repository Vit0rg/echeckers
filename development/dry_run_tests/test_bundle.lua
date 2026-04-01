#!/usr/bin/env lua
--
-- Dry-Run Test Suite for echeckers build bundles
-- Detects issues that only appear when files are concatenated
--

local DryRunTest = {}

-- Mock global state required by battle module
local function create_mock_globals()
    -- Core game state
    Board = {}
    Hands = { {}, {} }
    Deck_p1 = {}
    Deck_p2 = {}
    Player_turn = 1
    
    -- Configuration
    BUILD = 'TUI'
    MODE = 'basic'
    SCALE = 100
    BIOMATTER = 3
    MAX_BIOMATTER = 10
    HAND_SIZE = 4
    MAX_TURNS = 5
    HAND_LIMIT = 6
    
    -- UI stub
    UI = {
        display = function(msg) print("[UI.display] " .. tostring(msg)) end,
        update_menu = function(msg) print("[UI.update_menu]") end,
        update_board = function(board) print("[UI.update_board]") end,
        update_hand = function(hand, mode) print("[UI.update_hand]") end,
        input = function(handler, is_menu) return 1 end,
    }
    
    -- Stub modules (will be defined by bundle)
    BoardModule = {}
    BiomesOps = {}
    StandbyValidation = {}
    
    -- Functions that should be defined by bundle
    setup = function() print("[setup called]") end
    draw = function() print("[draw called]") end
    standby = function() print("[standby called]") end
end

--- Check file for premature return statements at file scope
-- Only flags 'return <identifier>' at end of file which indicates module pattern
-- This is invalid for files that will be concatenated in build
-- @param file_path string Path to Lua file
-- @return boolean Success (true if no premature returns)
-- @return string|nil Error message if issue found
function DryRunTest.check_premature_returns(file_path)
    local file = io.open(file_path, "r")
    if file == nil then
        return false, "File not found: " .. file_path
    end
    
    local content = file:read("*all")
    file:close()
    
    -- Get all non-empty, non-comment lines from the end
    local lines = {}
    for line in content:gmatch("[^\n]+") do
        local trimmed = line:match("^%s*(.-)%s*$")
        if trimmed ~= "" and not trimmed:match("^%-%-") then
            table.insert(lines, trimmed)
        end
    end
    
    -- Check if the last line is 'return <identifier>' pattern
    -- This indicates the file is using module pattern (invalid for concatenation)
    if #lines > 0 then
        local last_line = lines[#lines]
        
        -- Pattern: line starts with 'return' followed by an identifier
        -- Examples that should be flagged:
        --   return standby
        --   return ModuleName
        --   return setup
        if last_line:match("^return%s+%w+%s*$") then
            return false, string.format(
                "Module return pattern at end of file: '%s' - This file is concatenated in build, do not use 'return <name>'", 
                last_line
            )
        end
    end
    
    return true, nil
end

--- Check file for function definition pattern
-- @param file_path string Path to Lua file
-- @param func_name string Expected function name
-- @return boolean True if function is defined
function DryRunTest.check_function_defined(file_path, func_name)
    local file = io.open(file_path, "r")
    if file == nil then
        return false, "File not found: " .. file_path
    end
    
    local content = file:read("*all")
    file:close()
    
    -- Check for local function definition
    if content:match("local%s+" .. func_name .. "%s*=") or
       content:match("local%s+function%s+" .. func_name) then
        return true, nil
    end
    
    return false, string.format("Function '%s' not defined in %s", func_name, file_path)
end

--- Test all phase files
-- @return boolean Success
-- @return table List of errors
function DryRunTest.test_phase_files()
    local errors = {}
    
    local phases = {
        { file = "0_setup.lua", func = "setup" },
        { file = "1_draw_phase.lua", func = "draw" },
        { file = "2_standby_phase.lua", func = "standby" },
        { file = "3_battle_phase.lua", func = nil },  -- No main function
        { file = "4_end_phase.lua", func = nil },     -- No main function
    }
    
    for _, phase in ipairs(phases) do
        local file_path = "game/battle/phases/" .. phase.file
        
        -- Check for premature returns
        local ok, err = DryRunTest.check_premature_returns(file_path)
        if not ok then
            table.insert(errors, {
                file = file_path,
                issue = "premature_return",
                message = err
            })
        end
        
        -- Check function definition if expected
        if phase.func then
            local ok, err = DryRunTest.check_function_defined(file_path, phase.func)
            if not ok then
                table.insert(errors, {
                    file = file_path,
                    issue = "undefined_function",
                    message = err
                })
            end
        end
    end
    
    return #errors == 0, errors
end

--- Test build artifact
-- @param bundle_path string Path to bundled file
-- @return boolean Success
-- @return string|nil Error message
function DryRunTest.test_bundle(bundle_path)
    local ok, err = DryRunTest.check_premature_returns(bundle_path)
    if not ok then
        return false, "Bundle has premature returns: " .. err
    end
    return true, nil
end

--- Run all dry-run tests
-- @return boolean Success (true if all tests pass)
function DryRunTest.run_all()
    print("========================================")
    print("  DRY-RUN TEST SUITE")
    print("========================================")
    print("")
    
    local all_passed = true
    local total_checks = 0
    local passed_checks = 0
    
    -- Test 1: Check phase files for premature returns
    print("Test 1: Checking for premature returns in phase files...")
    local phases = {
        "0_setup.lua",
        "1_draw_phase.lua",
        "2_standby_phase.lua",
        "3_battle_phase.lua",
        "4_end_phase.lua",
    }
    
    for _, phase in ipairs(phases) do
        local file_path = "game/battle/phases/" .. phase
        total_checks = total_checks + 1
        local ok, err = DryRunTest.check_premature_returns(file_path)
        if ok then
            print("  ✓ " .. phase)
            passed_checks = passed_checks + 1
        else
            print("  ✗ " .. phase .. ": " .. err)
            all_passed = false
        end
    end
    print("")
    
    -- Test 2: Check build artifact
    print("Test 2: Checking build artifact...")
    local bundle_path = "game/battle/processed_battle.lua"
    if io.open(bundle_path, "r") then
        total_checks = total_checks + 1
        local ok, err = DryRunTest.check_premature_returns(bundle_path)
        if ok then
            print("  ✓ No premature returns in bundle")
            passed_checks = passed_checks + 1
        else
            print("  ✗ Bundle has premature returns: " .. err)
            all_passed = false
        end
    else
        print("  ⊘ Bundle not found (run build first)")
    end
    print("")
    
    -- Test 3: Verify function definitions
    print("Test 3: Verifying function definitions...")
    local expected_functions = {
        ["0_setup.lua"] = "setup",
        ["1_draw_phase.lua"] = "draw",
        ["2_standby_phase.lua"] = "standby",
    }
    
    for file, func_name in pairs(expected_functions) do
        local file_path = "game/battle/phases/" .. file
        total_checks = total_checks + 1
        local ok, err = DryRunTest.check_function_defined(file_path, func_name)
        if ok then
            print("  ✓ " .. func_name .. " defined in " .. file)
            passed_checks = passed_checks + 1
        else
            print("  ✗ " .. func_name .. " NOT defined in " .. file)
            all_passed = false
        end
    end
    print("")
    
    -- Summary
    print("========================================")
    print(string.format("  RESULTS: %d/%d checks passed", passed_checks, total_checks))
    if all_passed then
        print("  ALL DRY-RUN TESTS PASSED")
    else
        print("  DRY-RUN TESTS FAILED")
    end
    print("========================================")
    
    return all_passed
end

-- Run if executed directly
if arg and arg[0] and arg[0]:match("test_bundle.lua") then
    local success = DryRunTest.run_all()
    os.exit(success and 0 or 1)
end

return DryRunTest
