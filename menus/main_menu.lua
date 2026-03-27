--Main Entry points for other folders
local new_game = function ()
    --entry point for mode menu
    print('new_game')
end

local settings = function ()
    --entry point to configuration files
    --entry point to userdata
    print('settings')
end

local credits = function ()
    print('credits')
    --entry point to Credits
end

local exit = function ()
    --save data
    --display messages
    print('exit')
    os.exit()
end

local main_menu = function ()
    local options = {'New Game', 'Settings', 'Credits', 'Exit'}
    local actions = {new_game, settings, credits, exit}
    local output = string.format("\nEcheckers\n\n%s\n%s\n%s\n%s\n",
                            options[1], options[2], options[3], options[4])

    -- UI.update_menu(output)

    -- implement input here
    local input = 1
    actions[input]()
end

main_menu()