require("nvim-treesitter.configs").setup({
	ensure_installed = "all",
	ignore_install = { "phpdoc" },
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "gnn",
			node_incremental = "grn",
			scope_incremental = "grc",
			node_decremental = "grm",
		},
	},
	rainbow = {
		enable = true,
		extended_mode = true,
	},
	refactor = {
		highlight_definitions = {
			enable = true,
		},
	},
	indent = { enable = true },
	autotag = {
		enable = true,
		filetypes = {
			"html",
			"javascript",
			"javascriptreact",
			"typescriptreact",
			"svelte",
			"vue",
			"xml",
			"csproj",
		},
	},
})
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = [[nvim_treesitter#foldexpr()]]
-- Open files unfolded by default
vim.cmd("set nofoldenable")
