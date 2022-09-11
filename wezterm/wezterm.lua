local wezterm = require("wezterm")
local act = wezterm.action

local mykeys = {
	{
		key = "w",
		mods = "CTRL",
		action = act.CloseCurrentPane({ confirm = false }),
	},
}
for i = 1, 9 do
	table.insert(mykeys, {
		key = tostring(i),
		mods = "ALT",
		action = act.ActivateTab(i - 1),
	})
end

return {
	color_scheme = "NightOwl (Gogh)",
	custom_block_glyphs = false,
	default_cursor_style = "BlinkingUnderline",
	font = wezterm.font("CaskaydiaCove Nerd Font Mono"),
	font_size = 12.0,
	harfbuzz_features = { "calt=1", "clig=1", "liga=1", "zero" },
	hide_tab_bar_if_only_one_tab = true,
	keys = mykeys,
	skip_close_confirmation_for_processes_named = {
		"bash",
		"cmd.exe",
		"fish",
		"nu",
		"powershell.exe",
		"pwsh.exe",
		"pwsh",
		"sh",
		"tmux",
		"zsh",
	},
	term = "wezterm",
	window_background_opacity = 0.96,
	window_close_confirmation = "NeverPrompt",
}
