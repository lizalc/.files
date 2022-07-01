local packer_bootstrap = nil

-- Bootstrap packer.nvim, if necessary
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path, nil, nil)) > 0 then
	packer_bootstrap = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	vim.cmd([[packadd packer.nvim]])
end

local packer = require("packer")

local configfile = debug.getinfo(1, "S").source:sub(2):match("[^/]*.lua$")
local augroup_packer = vim.api.nvim_create_augroup("packer_user_config", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
	callback = function()
		packer.compile()
		vim.notify(configfile .. " compiled! Restart to use new config.", "info", {
			title = "Packer",
			timeout = 2000,
		})
	end,
	desc = "Compile " .. configfile .. " on write.",
	pattern = configfile,
	group = augroup_packer,
})

packer.init()
packer.reset()
packer.startup({
	function(use)
		use("wbthomason/packer.nvim")
		use("folke/tokyonight.nvim")
		use("projekt0n/github-nvim-theme")
		use("rebelot/kanagawa.nvim")
		use("fladson/vim-kitty")
		use("gentoo/gentoo-syntax")
		use("rcarriga/nvim-notify")
		use("lukas-reineke/virt-column.nvim")
		use("stevearc/dressing.nvim")

		use({
			"leoluz/nvim-dap-go",
			requires = {
				"mfussenegger/nvim-dap",
				{
					"theHamsta/nvim-dap-virtual-text",
					requires = "nvim-treesitter/nvim-treesitter",
				},
				"rcarriga/nvim-dap-ui",
			},
		})

		use({
			"nvim-treesitter/nvim-treesitter",
			run = ":TSUpdate",
		})

		use({
			"nvim-treesitter/nvim-treesitter-refactor",
			requires = "nvim-treesitter/nvim-treesitter",
		})

		use({
			"hrsh7th/nvim-cmp",
			requires = {
				"f3fora/cmp-spell",
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-path",
				"hrsh7th/cmp-cmdline",
				"hrsh7th/cmp-nvim-lua",
				"hrsh7th/cmp-nvim-lsp-signature-help",
				"L3MON4D3/LuaSnip",
				"saadparwaiz1/cmp_luasnip",
				"onsails/lspkind-nvim",
				"uga-rosa/cmp-dictionary",
				{
					"petertriho/cmp-git",
					requires = "nvim-lua/plenary.nvim",
				},
			},
		})

		use({
			"jose-elias-alvarez/null-ls.nvim",
			requires = "nvim-lua/plenary.nvim",
		})

		use({
			"neovim/nvim-lspconfig",
			requires = {
				"hrsh7th/nvim-cmp",
			},
		})

		use({
			"stevearc/aerial.nvim",
			requires = {
				"nvim-treesitter/nvim-treesitter",
				"neovim/nvim-lspconfig",
			},
		})

		use("kosayoda/nvim-lightbulb")

		use({
			"folke/trouble.nvim",
			requires = "kyazdani42/nvim-web-devicons",
		})

		use({
			"rafamadriz/friendly-snippets",
			requires = "L3MON4D3/LuaSnip",
		})

		use({
			"p00f/nvim-ts-rainbow",
			requires = "nvim-treesitter/nvim-treesitter",
		})

		use({
			"nvim-treesitter/nvim-treesitter-context",
			requires = "nvim-treesitter/nvim-treesitter",
		})

		use({
			"folke/twilight.nvim",
			requires = "nvim-treesitter/nvim-treesitter",
		})

		use({
			"lukas-reineke/indent-blankline.nvim",
			requires = "nvim-treesitter/nvim-treesitter",
		})

		use({
			"windwp/nvim-ts-autotag",
			requires = "nvim-treesitter/nvim-treesitter",
		})

		use({
			"windwp/nvim-autopairs",
			requires = "hrsh7th/nvim-cmp",
		})

		use({
			"kyazdani42/nvim-tree.lua",
			requires = "kyazdani42/nvim-web-devicons",
		})

		use({
			"akinsho/bufferline.nvim",
			requires = "kyazdani42/nvim-web-devicons",
		})

		use({
			"akinsho/git-conflict.nvim",
			config = function()
				require("git-conflict").setup()
			end,
		})

		use({
			"nvim-lualine/lualine.nvim",
			requires = {
				{
					"kyazdani42/nvim-web-devicons",
					opt = true,
				},
			},
		})

		use({
			"nvim-telescope/telescope.nvim",
			requires = {
				"nvim-treesitter/nvim-treesitter",
				"neovim/nvim-lspconfig",
				"nvim-lua/plenary.nvim",
				"nvim-telescope/telescope-symbols.nvim",
				"nvim-telescope/telescope-dap.nvim",
				{ "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
				{
					"nvim-telescope/telescope-frecency.nvim",
					requires = "tami5/sqlite.lua",
				},
				{
					"kyazdani42/nvim-web-devicons",
					opt = true,
				},
			},
		})

		use({
			"sudormrfbin/cheatsheet.nvim",
			requires = {
				"nvim-telescope/telescope.nvim",
				"nvim-lua/popup.nvim",
				"nvim-lua/plenary.nvim",
			},
		})

		use("lewis6991/spellsitter.nvim")

		use({
			"lewis6991/gitsigns.nvim",
			requires = "nvim-lua/plenary.nvim",
		})

		use({
			"TimUntersberger/neogit",
			requires = "nvim-lua/plenary.nvim",
		})

		use({
			"beauwilliams/focus.nvim",
			cmd = { "FocusSplitNicely", "FocusSplitCycle" },
			module = "focus",
			config = function()
				require("focus").setup({
					hybridnumber = true,
					absolutenumber_unfocussed = true,
				})
			end,
		})

		use({
			"goolord/alpha-nvim",
			requires = "kyazdani42/nvim-web-devicons",
			config = function()
				require("alpha").setup(require("alpha.themes.theta").config)
			end,
		})

		use({
			"weilbith/nvim-code-action-menu",
			cmd = "CodeActionMenu",
		})

		use("google/vim-jsonnet")
		use("editorconfig/editorconfig-vim")

		use("ellisonleao/glow.nvim")

		use("folke/which-key.nvim")
		use("mrjones2014/legendary.nvim")

		use({
			"folke/todo-comments.nvim",
			requires = "nvim-lua/plenary.nvim",
			config = function()
				require("todo-comments").setup()
			end,
		})

		use("folke/lua-dev.nvim")

		use({
			"terrortylor/nvim-comment",
			config = function()
				require("nvim_comment").setup()
			end,
		})

		use({
			"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
			as = "lsp_lines",
			config = function()
				require("lsp_lines").register_lsp_virtual_lines()
				vim.diagnostic.config({ virtual_lines = false })
			end,
		})

		use({
			"norcalli/nvim-colorizer.lua",
			config = function()
				require("colorizer").setup({
					lua = { mode = "foreground" },
				})
			end,
		})

		if packer_bootstrap then
			packer.sync()
		end
	end,
	config = {
		display = {
			open_fn = function()
				return require("packer.util").float({ border = "single" })
			end,
		},
	},
})
