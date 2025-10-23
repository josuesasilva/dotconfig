-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- Disable tabbar

config.hide_tab_bar_if_only_one_tab = true

config.default_prog = { "/opt/homebrew/bin/fish", "-l" }

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = "Thayer Bright"

config.freetype_load_target = "Light"

config.window_background_opacity = 0.9
config.macos_window_background_blur = 20

-- config.font = wezterm.font 'Monaco'
-- You can specify some parameters to influence the font selection;
-- for example, this selects a Bold, Italic font variant.
config.font = wezterm.font("Monaco", { weight = "Bold" })

config.font_size = 16

config.keys = {

	-- Create a vertical split with Ctrl+v
	{
		key = "v",
		mods = "CTRL",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},

	-- Create a horizontal split with Ctrl+h
	{
		key = "h",
		mods = "CTRL",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},

	-- Fix copy/paste using NVIM
	{
		key = "c",
		mods = "CTRL",
		action = wezterm.action_callback(function(window, pane)
			local sel = window:get_selection_text_for_pane(pane)
			if not sel or sel == "" then
				window:perform_action(wezterm.action.SendKey({ key = "c", mods = "CTRL" }), pane)
			else
				window:perform_action(wezterm.action({ CopyTo = "ClipboardAndPrimarySelection" }), pane)
			end
		end),
	},
	{ key = "v", mods = "CTRL", action = wezterm.action.PasteFrom },
	{
		key = "v",
		mods = "SHIFT|CTRL",
		action = wezterm.action_callback(function(window, pane)
			window:perform_action(wezterm.action.SendKey({ key = "v", mods = "CTRL" }), pane)
		end),
	},
	{
		key = "V",
		mods = "SHIFT|CTRL",
		action = wezterm.action_callback(function(window, pane)
			window:perform_action(wezterm.action.SendKey({ key = "v", mods = "CTRL" }), pane)
		end),
	},
}

-- and finally, return the configuration to wezterm
return config
