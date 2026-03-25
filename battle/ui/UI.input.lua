-- Ask for input in the format:
-- {input_type, input_prompt}
_TUI_input = function (input_handler, is_menu)

    if is_menu then
        --[[
            [Menu name] <- arg_1 
            [option_1] <- arg_2
            [Pick an option]
            ...

            return selection
        ]]
        return
    end

    if type(input_handler) ~="table" then
        _TUI_display("You must provide a table")
    end

    local input_type = input_handler[1]
    local input_prompt = input_handler[2]

    _TUI_display(input_prompt)
    if input_type == "number" then
        return io.read('n')
    end

    return io.read(1,30)
end

UI.input = function(input_handler, is_menu)
    if BUILD == 'TUI' then
        _TUI_display(input_handler, is_menu)
    end
end