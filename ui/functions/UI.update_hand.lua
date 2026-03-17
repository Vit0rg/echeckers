---@diagnostic disable: duplicate-set-field

local function build_cell_colors(color)
    local bg_ansi
    if type(color) == 'number' then
        bg_ansi = '\27[48;5;' .. color .. 'm'
    else
        local r, g, b = hex_to_rgb(color)
        local code = rgb_to_ansi256(r, g, b)
        bg_ansi = '\27[48;5;' .. code .. 'm'
    end
    return bg_ansi, '\27[38;5;15m'
end

local function format_emoji_field(emoji)
    if not emoji then return '❓' end

    local emoji_padding_overrides = {
        ['🦣'] = '🦣 ',
        ['🪲'] = '🪲 ',
        ['🕷️'] = '🕷️ ',
        ['⭐'] = '⭐',
        ['🪰'] = '🪰 ',
        ['🦭'] = '🦭 ',
        ['🐻'] = '🐻',
        ['🪼'] = '🪼 ',
        ['🦤'] = '🦤 ',
        ['🦈'] = '🦈'
    }

    return emoji_padding_overrides[emoji] or emoji
end

local function _build_hidden_hand(hand, start_index, end_index, show_prev, show_next, hand_bg, hand_fg, nav_bg, nav_fg, ANSI_RESET)
    local hidden_card = hand_bg .. hand_fg .. '🂠' .. ANSI_RESET
    local card_sep = '  '
    local nav_prev = nav_bg .. nav_fg .. '[<<]' .. ANSI_RESET .. card_sep
    local nav_next = card_sep .. nav_bg .. nav_fg .. '[>>]' .. ANSI_RESET

    local cards = {}
    for i = start_index, end_index do
        cards[#cards + 1] = hidden_card
    end

    return (show_prev and nav_prev or '') .. table.concat(cards, card_sep) .. (show_next and nav_next or '')
end

local function _build_card_lines(card, wrap_empty, side_border, card_prefix, card_suffix, hand_bg, hand_fg, cost_fg, health_fg, speed_fg, attack_fg, defense_fg, ANSI_RESET)
    local name = card.name or ''
    if #name > 10 then name = name:sub(1, 10) end
    local name_centered = string.center(name, 13)
    local emoji_field = format_emoji_field(card.emoji or '❓')
    local cost = card.cost or 0
    local health = card.health or 0
    local speed = card.speed or 0
    local attack = card.attack or 0
    local defense = card.defense or 0

    return {
        wrap_empty,
        side_border .. hand_bg .. hand_fg .. name_centered .. ANSI_RESET .. side_border,
        side_border .. hand_bg .. string.rep(' ', 13) .. ANSI_RESET .. side_border,
        card_prefix .. string.format('  %s%s%8d ', emoji_field, cost_fg, cost) .. card_suffix,
        card_prefix .. string.format('%s%4d  %s%6d ', health_fg, health, speed_fg, speed) .. card_suffix,
        card_prefix .. string.format('%s%4d  %s%6d ', attack_fg, attack, defense_fg, defense) .. card_suffix,
        wrap_empty,
    }
end

local function _apply_navigation(lines, nav_prefix, nav_suffix, show_prev, show_next)
    if show_prev then
        lines[4] = nav_prefix .. '  ' .. lines[4]
    end
    if show_next then
        lines[4] = lines[4] .. '  ' .. nav_suffix
    end
    return lines
end

local function _TUI_update_hand(hand, is_hidden, start_index, end_index)
    local ANSI_RESET = '\27[0m'
    local HAND_BACKGROUND = 235
    local CARD_PADDING_COLOR = 245
    local NAV_COLOR = 22
    local COST_COLOR = 226
    local HEALTH_COLOR = 46
    local SPEED_COLOR = 159
    local ATTACK_COLOR = 160
    local DEFENSE_COLOR = 17

    local hand_bg, hand_fg = build_cell_colors(HAND_BACKGROUND)
    local padding_bg, padding_fg = build_cell_colors(CARD_PADDING_COLOR)
    local nav_bg, nav_fg = build_cell_colors(NAV_COLOR)
    local cost_fg = '\27[38;5;' .. COST_COLOR .. 'm'
    local health_fg = '\27[38;5;' .. HEALTH_COLOR .. 'm'
    local speed_fg = '\27[38;5;' .. SPEED_COLOR .. 'm'
    local attack_fg = '\27[38;5;' .. ATTACK_COLOR .. 'm'
    local defense_fg = '\27[38;5;' .. DEFENSE_COLOR .. 'm'

    start_index = start_index or 1
    end_index = end_index or math.min(4, #hand)

    local show_prev = start_index > 1
    local show_next = end_index < #hand

    if is_hidden == "hidden" then
        print(_build_hidden_hand(hand, start_index, end_index, show_prev, show_next, hand_bg, hand_fg, nav_bg, nav_fg, ANSI_RESET))
        return
    end

    local lines = { '', '', '', '', '', '', '' }
    local card_count = 0

    local card_prefix = padding_bg .. padding_fg .. ' ' .. ANSI_RESET .. hand_bg .. hand_fg
    local card_suffix = ANSI_RESET .. padding_bg .. padding_fg .. ' ' .. ANSI_RESET
    local nav_prefix = nav_bg .. nav_fg .. '[<<]' .. ANSI_RESET .. '  '
    local nav_suffix = '  ' .. nav_bg .. nav_fg .. '[>>]' .. ANSI_RESET
    local card_sep = '  '
    local wrap_empty = padding_bg .. string.rep(' ', 15) .. ANSI_RESET
    local side_border = padding_bg .. padding_fg .. ' ' .. ANSI_RESET

    for i = start_index, end_index do
        if card_count > 0 then
            for l = 1, 7 do
                lines[l] = lines[l] .. card_sep
            end
        end

        local card_lines = _build_card_lines(hand[i], wrap_empty, side_border, card_prefix, card_suffix, hand_bg, hand_fg, cost_fg, health_fg, speed_fg, attack_fg, defense_fg, ANSI_RESET)

        for l = 1, 7 do
            lines[l] = lines[l] .. card_lines[l]
        end

        card_count = card_count + 1
    end

    lines = _apply_navigation(lines, nav_prefix, nav_suffix, show_prev, show_next)

    print(table.concat(lines, '\n') .. '\n')
end

UI.update_hand = function(hand, is_hidden, start_index, end_index)
    if BUILD == 'TUI' then
        _TUI_update_hand(hand, is_hidden, start_index, end_index)
    end
end