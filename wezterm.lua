local wezterm = require("wezterm")

return {
    -- Set Fish as the default shell
    default_prog = { "/opt/homebrew/bin/fish" },

    -- Configure tabbar presentation
    enable_tab_bar = true,
    hide_tab_bar_if_only_one_tab = true,

    font_size = 14,

    -- Alternative: if fish is in a different location, you can use:
    -- default_prog = { '/usr/local/bin/fish' },
    -- or find the path with: which fish

    -- Optional: set login shell behavior
    -- default_prog = { '/opt/homebrew/bin/fish', '-l' },
}
