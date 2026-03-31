# Lua Best Practices

## Project Context

This document defines Lua coding standards for the echeckers game project located in the `game/` directory.

---

## General Guidelines

### 1. File Structure

```lua
--
-- File: [filename.lua]
-- Description: [purpose]
--

-- Module declaration
local ModuleName = {}

-- Constants (UPPER_SNAKE_CASE)
local MAX_PLAYERS = 2
local DEFAULT_SCALE = 100

-- Dependencies (local references to globals)
local pairs = pairs
local tostring = tostring

-- Private functions (prefix with _)
local function _helper_function(param)
    -- Implementation
end

-- Public functions (PascalCase or snake_case)
function ModuleName.public_function(param)
    -- Implementation
end

-- Module initialization
function ModuleName.init()
    -- Setup code
end

return ModuleName
```

### 2. Variable Declarations

```lua
-- Use local variables by default
local player_count = 0
local players = {}

-- Globals only when necessary (game state)
Board = {}
Hands = {}
Deck_p1 = {}
Deck_p2 = {}

-- Constants in UPPER_SNAKE_CASE
local MAX_TURNS = 20
local BIOMATTER = 3

-- Multiple assignments
local x, y, z = 0, 0, 0
local has_value, value = pcall(get_value)
```

### 3. Function Definitions

```lua
-- Use descriptive names
-- Document parameters and return values
-- Validate parameters early

--- Process a card and apply scaling
-- @param card table The card data
-- @param scale number The scale factor (default: 100)
-- @return table Processed card with scaled stats
function process_card(card, scale)
    scale = scale or 100
    
    -- Validate input
    if not card then
        error("Card cannot be nil", 2)
    end
    
    -- Process card
    local processed = {
        name = card.name,
        health = card.base_health * scale / 100,
        attack = card.base_attack * scale / 100,
        defense = card.base_defense * scale / 100,
    }
    
    return processed
end

-- Internal functions prefixed with _
local function _internal_helper(param)
    -- Only called within this module
end
```

### 4. Table Operations

```lua
-- Use tables for namespacing
local Utils = {
    string = {},
    table = {},
}

-- Safe table copying with circular reference detection
function Utils.table.copy(original, seen)
    seen = seen or {}
    
    if type(original) ~= "table" then
        return original
    end
    
    -- Check for circular reference
    if seen[original] then
        return seen[original]
    end
    
    local copy = {}
    seen[original] = copy
    
    for key, value in pairs(original) do
        copy[Utils.table.copy(key, seen)] = Utils.table.copy(value, seen)
    end
    
    return setmetatable(copy, getmetatable(original))
end

-- Table printing with depth limit
function Utils.table.print(tbl, indent, max_depth)
    indent = indent or 0
    max_depth = max_depth or 5
    
    if indent > max_depth then
        print(string.rep("  ", indent) .. "{...}")
        return
    end
    
    for key, value in pairs(tbl) do
        if type(value) == "table" then
            print(string.rep("  ", indent) .. key .. ":")
            Utils.table.print(value, indent + 1, max_depth)
        else
            print(string.rep("  ", indent) .. key .. ": " .. tostring(value))
        end
    end
end
```

### 5. Error Handling

```lua
-- Use pcall for protected calls
local success, result = pcall(function()
    return risky_operation()
end)

if not success then
    print("Error: " .. result)
    return
end

-- Use error() with level parameter
function validate_input(value)
    if value == nil then
        error("Value cannot be nil", 2)  -- Level 2 points to caller
    end
end

-- Custom error types
local ErrorTypes = {
    VALIDATION_ERROR = 1,
    STATE_ERROR = 2,
    RESOURCE_ERROR = 3,
}

function raise_error(error_type, message)
    error({ type = error_type, message = message }, 2)
end
```

### 6. String Operations

```lua
-- Use string.format for formatting
local message = string.format("Player %d has %d cards", player_id, card_count)

-- String centering with emoji support
function string.center(text, width)
    -- Strip variation selectors for width calculation
    local clean_text = text:gsub("[%z\1-\127\194-\244][\128-\191]*", "")
    local text_width = calculate_visual_width(clean_text)
    local padding = math.floor((width - text_width) / 2)
    return string.rep(" ", padding) .. text
end

-- String splitting
function string.split(str, delimiter)
    local result = {}
    for part in str:gmatch("[^" .. delimiter .. "]+") do
        table.insert(result, part)
    end
    return result
end

-- Safe string replacement
function string.replace(str, pattern, replacement)
    -- Escape % in replacement to prevent pattern issues
    local escaped = replacement:gsub("%%", "%%%%")
    return str:gsub(pattern, escaped)
end
```

### 7. Game State Management

```lua
-- Centralize game state
local GameState = {
    turn = 1,
    phase = "setup",
    players = {},
}

-- Use modules for state operations
local StateModule = {}

function StateModule.get_player(player_id)
    return GameState.players[player_id]
end

function StateModule.set_player(player_id, data)
    GameState.players[player_id] = data
end

function StateModule.next_turn()
    GameState.turn = GameState.turn + 1
    GameState.phase = "draw"
end

-- Validate state transitions
function StateModule.transition_phase(new_phase)
    local valid_transitions = {
        setup = "draw",
        draw = "standby",
        standby = "battle",
        battle = "end",
        end = "draw",
    }
    
    if valid_transitions[GameState.phase] ~= new_phase then
        error("Invalid phase transition: " .. GameState.phase .. " -> " .. new_phase)
    end
    
    GameState.phase = new_phase
end
```

### 8. Module Pattern

```lua
-- Module with explicit exports
local BoardModule = {}

-- Private state
local Board = {}
local initialized = false

-- Public API
function BoardModule.init()
    if initialized then
        return
    end
    
    Board.biomes = {}
    Board.layout = {}
    initialized = true
end

function BoardModule.get_biome(player, index)
    if not initialized then
        error("Board not initialized", 2)
    end
    
    -- Flat index calculation
    local flat_index = BoardModule.biome_index(player, index)
    return Board.biomes[flat_index]
end

function BoardModule.biome_index(player, slot)
    -- Player 2: 1-6, Player 1: 7-12
    if player == 2 then
        return slot
    else
        return slot + 6
    end
end

-- Helper functions
local function _validate_index(index)
    return index >= 1 and index <= 12
end

return BoardModule
```

### 9. UI Rendering

```lua
-- Namespace UI functions
local UI = {}

-- Use table-driven approach for rendering
local CELL_COLORS = {
    [1] = { [7] = "#4646FF", [8] = "#FF4646" },  -- Deck, Trash
    [2] = { [7] = "#00FF00", [8] = "#FF0000" },  -- LIFE, BIOMATTER
}

function UI.update_board(board)
    local output = {}
    
    -- Table-driven cell extraction
    local extractors = {
        biome = function(row, col) return get_biome_content(row, col) end,
        card = function(row, col) return get_card_content(row, col) end,
        special = function(row, col) return get_special_content(row, col) end,
    }
    
    for row = 1, 3 do
        local line = {}
        for col = 1, 10 do
            local cell_type = get_cell_type(row, col)
            local content = extractors[cell_type](row, col)
            local color = CELL_COLORS[row] and CELL_COLORS[row][col]
            
            if color then
                table.insert(line, colorize(content, color))
            else
                table.insert(line, content)
            end
        end
        table.insert(output, table.concat(line, " | "))
    end
    
    return table.concat(output, "\n")
end

-- ANSI color utilities
function UI.colorize(text, hex_color)
    local r, g, b = hex_to_rgb(hex_color)
    local code = rgb_to_ansi256(r, g, b)
    return string.format("\27[38;5;%dm%s\27[0m", code, text)
end
```

### 10. Build System Integration

```lua
-- Configuration for build process
local BuildConfig = {
    main_files = {
        "game/settings/configuration.lua",
        "game/utils/string/string.center.lua",
        "game/utils/table/table.copy.lua",
        "game/menus/main_menu.lua",
        "game/src/main.lua",
    },
    battle_files = {
        "game/battle/battle.lua",
        "game/battle/phases/0_setup.lua",
        "game/battle/phases/1_draw_phase.lua",
        "game/battle/phases/2_standby_phase.lua",
    },
}

-- Module dependencies (for build ordering)
local Dependencies = {
    ["game/battle/battle.lua"] = {
        "game/settings/configuration.lua",
        "game/battle/phases/0_setup.lua",
    },
}

-- Build metadata
local BuildInfo = {
    version = "0.1.0",
    build_date = os.date("%Y-%m-%d"),
    commit = "unknown",  -- Populated by build script
}
```

---

## Anti-Patterns to Avoid

```lua
-- ❌ Don't: Global variables without intention
function my_function()
    temp = value  -- Creates global
end

-- ✅ Do: Local variables
function my_function()
    local temp = value
end

-- ❌ Don't: Unchecked nil access
local name = player.name

-- ✅ Do: Safe access
local name = player and player.name or "Unknown"

-- ❌ Don't: Deep nesting
if condition1 then
    if condition2 then
        if condition3 then
            -- code
        end
    end
end

-- ✅ Do: Early returns
if not condition1 then return end
if not condition2 then return end
if not condition3 then return end
-- code

-- ❌ Don't: Magic numbers
health = health * 1.5 + 10

-- ✅ Do: Named constants
local CRIT_MULTIPLIER = 1.5
local BASE_BONUS = 10
health = health * CRIT_MULTIPLIER + BASE_BONUS

-- ❌ Don't: Modify table during iteration
for i, value in ipairs(tbl) do
    if should_remove(value) then
        table.remove(tbl, i)  -- Breaks iteration
    end
end

-- ✅ Do: Collect then remove
local to_remove = {}
for i, value in ipairs(tbl) do
    if should_remove(value) then
        table.insert(to_remove, i)
    end
end
for i = #to_remove, 1, -1 do
    table.remove(tbl, to_remove[i])
end
```

---

## Performance Guidelines

```lua
-- Cache frequently used functions
local floor = math.floor
local insert = table.insert
local concat = table.concat

-- Use table.concat for string building
local function build_string(parts)
    local result = {}
    for _, part in ipairs(parts) do
        insert(result, part)
    end
    return concat(result, "")
end

-- Avoid creating tables in loops
local function process_items(items)
    local results = {}
    for _, item in ipairs(items) do
        -- Reuse table if possible
        results[#results + 1] = transform(item)
    end
    return results
end

-- Use ipairs for array iteration (faster than pairs)
for i, value in ipairs(array) do
    -- Process value
end
```

---

## Documentation Standards

```lua
--- Brief description of function
-- Extended description if needed
-- @param param_name type Description
-- @param[opt] param_name type Optional parameter
-- @return type Description of return value
-- @usage local result = module.function(arg)
-- @see RelatedModule.related_function
function module.function(param_name)
    -- Implementation
end

-- Module-level documentation
-- @module ModuleName
-- @description Full module description

local ModuleName = {}

-- Section organization
-- # Constants
-- # Private Functions
-- # Public Functions
-- # Initialization
```

---

## Testing Guidelines

```lua
-- Simple test framework
local TestModule = {}

function TestModule.assert_equals(expected, actual, message)
    if expected ~= actual then
        error(string.format(
            "Assertion failed: %s (expected: %s, got: %s)",
            message or "no message",
            tostring(expected),
            tostring(actual)
        ))
    end
end

function TestModule.assert_not_nil(value, message)
    if value == nil then
        error(string.format("Assertion failed: %s (value is nil)", message or "no message"))
    end
end

-- Test cases
local function test_card_processor()
    local card = { base_health = 100, base_attack = 50 }
    local result = process_card(card, 100)
    
    TestModule.assert_equals(100, result.health, "Health should be 100")
    TestModule.assert_equals(50, result.attack, "Attack should be 50")
end

-- Run tests
local function run_all_tests()
    local tests = {
        test_card_processor,
        -- Add more tests
    }
    
    local passed = 0
    local failed = 0
    
    for _, test in ipairs(tests) do
        local success, err = pcall(test)
        if success then
            passed = passed + 1
            print("✓ " .. debug.getinfo(test).name)
        else
            failed = failed + 1
            print("✗ " .. debug.getinfo(test).name .. ": " .. err)
        end
    end
    
    print(string.format("\nResults: %d passed, %d failed", passed, failed))
    return failed == 0
end
```

---

## Version Control

- Keep modules under 500 lines when possible
- Split large modules into sub-modules
- Document all public functions with LuaDoc style
- Use consistent naming conventions
- Test with luacheck or similar linter
