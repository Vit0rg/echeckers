-- @2, 
_TUI_display = function(message, separator)
    separator = separator or ''
    if type(message) == "table" then
        table.print(message,false,false,false,false,separator)
        return
    end

    print(message)
end

UI.display = function(message, separator)
    if BUILD == 'TUI' then
        _TUI_display(message, separator)
    end
end