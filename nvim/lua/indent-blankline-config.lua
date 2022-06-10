vim.opt.list = true
vim.opt.listchars:append("space:⋅")

require("indent_blankline").setup({
	use_treesitter = true,
	space_char_blankline = " ",
	show_current_context = true,
	show_current_context_start = true,
	show_first_indent_level = true,
	show_trailing_blankline_indent = false,
	max_indent_increase = 1,
	char_list = { "│", "|", "¦", "┆", "┊" },
	buftype_exclude = { "terminal", "nofile" },
	filetype_exclude = { "NvimTree", "dashboard" },
})
