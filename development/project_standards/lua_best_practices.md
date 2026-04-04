# Lua Best Practices

## Project Context

This document defines Lua coding standards for the echeckers game project located in the `game/` directory.

**Important:** Files are concatenated during build (not loaded as modules). Do not use `return` at file end.

---

## General Guidelines

### 1. File Structure

```lua
--
-- File: [filename.lua]
-- Description: [purpose]
--

-- Local functions and data (prefix private with _)
local function _helper_function(param)
    -- Implementation
end

-- Public functions (snake_case)
function process_card(card, scale)
    -- Implementation
end

-- NO return statement - file is concatenated in build
```

### 2. Variable Declarations

```lua
-- Use local variables by default
local player_count = 0
local players = {}

-- Globals only for game state
Board = {}
Hands = {}
Deck_p1 = {}
Deck_p2 = {}
Player_turn = 1

-- Constants in UPPER_SNAKE_CASE
local MAX_TURNS = 20
local BIOMATTER = 3
```

### 3. Function Definitions

```lua
-- Use descriptive names, minimize arguments (exponential cost)
-- 1 arg: ~7% | 4 args: ~64% | 8 args: ~110% slower

--- Process a card and apply scaling
-- @param card table The card data
-- @param scale number The scale factor (default: 100)
-- @return table Processed card
function process_card(card, scale)
    scale = scale or 100

    if not card then
        error("Card cannot be nil", 2)
    end

    return {
        name = card.name,
        health = card.base_health * scale / 100,
        attack = card.base_attack * scale / 100,
    }
end

-- Private functions prefixed with _
local function _internal_helper(param)
    -- Only called within this file
end
```

### 4. Table Operations

```lua
-- Safe table copying with circular reference detection
local function copy_table(original, seen)
    seen = seen or {}

    if type(original) ~= "table" then
        return original
    end

    if seen[original] then
        return seen[original]
    end

    local copy = {}
    seen[original] = copy

    for key, value in pairs(original) do
        copy[copy_table(key, seen)] = copy_table(value, seen)
    end

    return copy
end

-- Use table.concat for building large/dynamic strings (>10 parts)
-- For small fixed strings, use .. (2-3x faster)
local function build_string(parts)
    local size = #parts
    for i = 1, size do
        -- process parts[i]
    end
    return table.concat(parts, "")
end
```

### 5. Error Handling

```lua
-- Use pcall for protected calls
local success, result = pcall(function()
    return risky_operation()
end)

if not success then
    UI.display("Error: " .. result)
    return
end

-- Use error() with level parameter (2 = caller's line)
function validate_input(value)
    if value == nil then
        error("Value cannot be nil", 2)
    end
end
```

### 6. String Operations

```lua
-- Use .. for small, fixed-size string concatenation (fastest for ≤10 parts)
-- Benchmark (1M iterations): .. = 1s | table.concat = 2-3s
local output = "Invalid move: " .. err
local menu = "\nStandby Phase - Player " .. Player_turn ..
    "\n\nSelect Action:\n" ..
    "  [1] " .. options[1] .. "\n" ..
    "  [2] " .. options[2] .. "\n" ..
    "  [3] " .. options[3] .. "\n" ..
    "  [4] " .. options[4] .. "\n" ..
    "  [5] " .. options[5] .. "\n"

-- Use string.format for numbers (50-100% faster than ..)
local message = string.format("Player %d has %d cards", player_id, card_count)
```

---

## Anti-Patterns to Avoid

```lua
-- ❌ Don't: Create globals unintentionally
function my_function()
    temp = value  -- Creates global
end

-- ✅ Do: Use local
local function my_function()
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
for i = 1, #tbl do
    if should_remove(tbl[i]) then
        table.remove(tbl, i)  -- Breaks iteration
    end
end

-- ✅ Do: Collect then remove
local to_remove = {}
local size = #tbl
for i = 1, size do
    if should_remove(tbl[i]) then
        table.insert(to_remove, i)
    end
end
for i = #to_remove, 1, -1 do
    table.remove(tbl, to_remove[i])
end

-- ❌ Don't: Use ipairs/pairs (project standard: C-based loops only)
for _, value in ipairs(tbl) do
    process(value)
end

-- ✅ Do: C-based numeric for loop
local size = #tbl
for i = 1, size do
    process(tbl[i])
end
```

---

## Performance Guidelines

Based on [Transformice Lua VM Performance Tests](https://github.com/Pshy0/transformice_lua_perf_tests)

### Variable Access

```lua
-- ✅ DO: Use local variables (global reads ~20% slower, writes ~33% slower)
local function process_data()
    local max_turns = MAX_TURNS  -- Cache global
    local board = Board          -- Cache table
end

-- ✅ DO: Cache table values if accessed more than once (~30% faster)
local function update_ui()
    local hands = Hands  -- Cache once
    local player1_hand = hands[1]
    local player2_hand = hands[2]
end
```

### Functions & Arguments

```lua
-- ✅ DO: Prefer procedural style (~10% faster than OOP/POOP)
local function process_card(card)
    -- ...
end

-- ✅ DO: Minimize function arguments (exponential cost)
local function validate_move(from, to)  -- 2 args - OK
    -- ...
end

-- ✅ DO: Pass numbers instead of strings (~4% faster)
local function set_value(num)  -- Pass 123, not "123"
    -- ...
end

-- ✅ DO: Avoid unused arguments (~5% slower)
local function callback(event, data)  -- Only use what you need
    if event == "click" then
        handle_click(data)
    end
end

-- ✅ DO: Choose callback handling based on existence probability
-- If functions usually exist: use dummy function
local dummy = function() end
local on_update = config.on_update or dummy
on_update()

-- If functions usually don't exist: check for false
if config.on_error then
    config.on_error(err)
end
```

### Iteration

```lua
-- ✅ DO: C-based loops for arrays (project standard)
local size = #array
for i = 1, size do
    process(array[i])
end

-- ⚠️  CAUTION: Use table.concat only for large/dynamic string building (>10 parts)
-- Benchmark shows table.concat is 2-3x SLOWER than .. for small fixed sets
-- Use it when: parts count is unknown, built in a loop, or exceeds ~10 fragments
-- Avoid it when: all parts are known at write time (use .. instead)
local function build_menu(options)
    local parts = {}
    local size = #options
    for i = 1, size do
        parts[i] = "  [" .. i .. "] " .. options[i]
    end
    return table.concat(parts, "\n")
end
```

### Testing Notes

- Run performance tests during initialization (up to 4000ms)
- Lua VM performance varies over time
- Profile before optimizing

---

## Documentation Standards

```lua
--- Brief description of function
-- Extended description if needed
-- @param param_name type Description
-- @param[opt] param_name type Optional parameter
-- @return type Description of return value
-- @usage local result = process_card(card, 100)
function process_card(card, scale)
    -- Implementation
end
```

---

## Build System Notes

```lua
-- Files are concatenated in build order (build_battle.txt, build_main.txt)
-- Variables/functions are shared across concatenated files
-- NO return statements at file end

-- Build order example:
-- 1. game/battle/board/board.lua    <- defines boardModule
-- 2. game/battle/board/fields.lua   <- uses boardModule
-- 3. game/battle/phases/2_standby_phase.lua <- uses fieldsOps
```

---

## Code Quality

- Keep files under 500 lines when possible
- Document all public functions
- Use consistent naming conventions
- C-based loops only (no ipairs/pairs)
- Local variables by default
- Globals only for game state
