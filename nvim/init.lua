-- Core editor settings:
-- * Enable line numbers
-- * Use relative line numbering
-- * Allow directional keys to wrap to previous / next line
-- * Match cursor to terminal settings otherwise Neovim overwrites them >:(
-- * Enable mouse support

vim.opt.termguicolors = true
vim.g.mapleader = ";"

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

vim.opt.updatetime = 175
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

vim.opt.clipboard = "unnamedplus"
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

require("lspsaga").init_lsp_saga({
	border_style = "rounded",
	code_action_icon = signs["Hint"],
	code_action_lightbulb = {
		virtual_text = false,
	},
	diagnostic_header = signs,
})

require("trouble").setup()
require("luasnip.loaders.from_vscode").load()
require("treesitter-context").setup()
require("spellsitter").setup()
require("twilight").setup()
require("nvim-tree").setup()
require("neogit").setup()

local dap, dapui = require("dap"), require("dapui")
dapui.setup()
dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end
require("dap-go").setup()
require("nvim-dap-virtual-text").setup()

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

vim.keymap.set({ "n" }, "<leader>x", function()
	vim.cmd([[Lspsaga code_action]])
end, { silent = true, desc = "Open Lspsaga code action menu" })

local format = function()
	vim.notify("Formatting...", vim.log.levels.INFO, { title = "Auto Format", timeout = 100 })
	vim.lsp.buf.format({ async = true })
end

local save = function()
	vim.notify("Saving current buffer", vim.log.levels.INFO, { timeout = 100 })
	vim.cmd([[w]])
end

vim.keymap.set({ "n" }, "<leader>s", save, { silent = true, desc = "Save buffer" })
vim.keymap.set({ "n" }, "<leader>k", format, { silent = true, desc = "Format buffer" })
vim.keymap.set(
	{ "n" },
	"<leader>c",
	require("lspsaga.hover").render_hover_doc,
	{ silent = true, desc = "Show Lspsaga hover doc" }
)
vim.keymap.set(
	"n",
	"<leader><leader>",
	require("lspsaga.floaterm").open_float_terminal,
	{ silent = true, desc = "Open Lspsaga floating terminal" }
)

local virt_lines_toggle = false
vim.keymap.set("n", "<leader>h", function()
	virt_lines_toggle = not virt_lines_toggle
	vim.diagnostic.config({ virtual_lines = virt_lines_toggle })
end, { silent = true, desc = "Toggle lsp_lines virtual line diagnostics" })

vim.keymap.set("n", "<leader>q", "<Cmd>q<CR>", { silent = true, desc = "Quit" })
