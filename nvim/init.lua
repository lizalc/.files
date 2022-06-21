-- Core editor settings:
-- * Enable line numbers
-- * Use relative line numbering
-- * Allow directional keys to wrap to previous / next line
-- * Match cursor to terminal settings otherwise Neovim overwrites them >:(
-- * Enable mouse support

-- opt in to: https://old.reddit.com/r/neovim/comments/rvwsl3/introducing_filetypelua_and_a_call_for_help/
vim.g.do_filetype_lua = 1
vim.opt.termguicolors = true

require("plugins-config")
require("treesitter-config")
require("lsp-config")
require("cmp-config")
require("indent-blankline-config")
require("bufferline-config")
require("lualine-config")
require("notify-config")
require("telescope-config")

vim.o.cmdheight = "0"

vim.opt.showmode = false
vim.opt.spell = true
vim.opt.spelllang = { "en_us" }

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.whichwrap:append("<,>,h,l,[,]")
vim.opt.guicursor = "a:hor20-blinkwait175-blinkoff150-blinkon175,i:ver25"
vim.opt.mouse = "a"

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = -1
vim.opt.expandtab = true

vim.opt.clipboard = "unnamed"
vim.opt.completeopt = "menu,menuone,noselect"

vim.diagnostic.config({
	virtual_text = false, -- handled by lsp_lines plugin
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
})

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local lightbulb = "LightBulbSign"
vim.fn.sign_define(lightbulb, { text = signs["Hint"], texthl = lightbulb, linehl = lightbulb, numhl = lightbulb })

require("nvim-lightbulb").setup({
	autocmd = {
		enabled = true,
	},
})

require("trouble").setup()
require("luasnip.loaders.from_vscode").load()
require("treesitter-context").setup()
require("spellsitter").setup()
require("twilight").setup()
require("nvim-tree").setup()
require("neogit").setup()
require("virt-column").setup({
	char = "┊", -- same character used in indent-blankline-config, should deduplicate.
})

require("cheatsheet").setup({
	bundled_cheatsheets = {
		disabled = {
			"nerd-fonts",
		},
	},
})

require("gitsigns").setup({
	current_line_blame = true,
	current_line_blame_opts = {
		virt_text = true,
		virt_text_pos = "eol",
		delay = 250,
		ignore_whitespace = true,
	},
	current_line_blame_formatter_opts = {
		relative_time = true,
	},
})

vim.opt.timeoutlen = 50
require("which-key").setup()

require("legendary").setup()

vim.g.tokyonight_colors = {
	-- default is too purplish
	fg = "#e6e5e1",
}
vim.g.tokyonight_style = "night"
vim.g.tokyonight_italic_keywords = true
vim.g.tokyonight_italic_comments = true
vim.g.tokyonight_italic_functions = true
vim.g.tokyonight_italic_variables = false
vim.g.tokyonight_transparent = true
vim.g.tokyonight_lualine_bold = true
--vim.cmd([[colorscheme tokyonight]])

vim.wo.cursorline = true
vim.wo.cursorlineopt = "number"

local default_colors = require("kanagawa.colors").setup()

require("kanagawa").setup({
	transparent = true,
	overrides = {
		CursorLineNr = { fg = default_colors.oldWhite },
	},
})
vim.cmd([[colorscheme kanagawa]])
vim.cmd([[highlight ColorColumn ctermbg=none guibg=none]])
vim.cmd("highlight VirtColumn guifg=" .. default_colors.winterRed)

vim.wo.colorcolumn = "90"

-- using oscyank on macOS interferes with what I'm used too. Probably just need to
-- tweak the config but for now only use it on Linux / WSL.
if os.getenv("OS_NAME") == "Linux" then
	local function copy(lines, _)
		vim.fn.OSCYankString(table.concat(lines, "\n"))
	end

	local function paste()
		return {
			vim.fn.split(vim.fn.getreg("", nil, nil), "\n"),
			vim.fn.getregtype(""),
		}
	end

	vim.g.clipboard = {
		name = "osc52",
		copy = {
			["+"] = copy,
			["*"] = copy,
		},
		paste = {
			["+"] = paste,
			["*"] = paste,
		},
	}

	vim.g.oscyank_silent = true
end

vim.keymap.set({ "n", "i" }, "<C-.>", function()
	vim.cmd([[CodeActionMenu]])
end, { silent = true })

local format = function()
	vim.notify("Formatting...", vim.log.levels.INFO, { title = "Auto Format", timeout = 100 })
	vim.lsp.buf.format({ async = true })
end

local save = function()
	vim.notify("Saving current buffer", vim.log.levels.INFO, { timeout = 100 })
	vim.cmd([[w]])
end

vim.keymap.set({ "n", "i" }, "<C-s>", save, { silent = true })
vim.keymap.set({ "n", "i" }, "<C-/>", format, { silent = true })

vim.keymap.set({ "n", "i" }, "<C-k>", function()
	vim.cmd([[CommentToggle]])
end)
