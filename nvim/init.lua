-- Core editor settings:
-- * Enable line numbers
-- * Use relative line numbering
-- * Allow directional keys to wrap to previous / next line
-- * Match cursor to terminal settings otherwise Neovim overwrites them >:(
-- * Enable mouse support
-- * Split below by default
local settings = {
    'number', 'relativenumber', 'whichwrap+=<,>,h,l,[,]',
    'guicursor=a:hor20-blinkwait175-blinkoff150-blinkon175,i:ver25', 'mouse=a',
    'termguicolors'
}

for _, setting in pairs(settings) do vim.cmd('set' .. ' ' .. setting) end

-- Bootstrap packer.nvim, if necessary - https://github.com/wbthomason/packer.nvim
local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({
        'git', 'clone', 'https://github.com/wbthomason/packer.nvim',
        install_path
    })
    execute 'packadd packer.nvim'
end

packer = require 'packer'
packer.init()
packer.reset()

packer.use {
    'p00f/nvim-ts-rainbow',
    'folke/tokyonight.nvim',
    'wbthomason/packer.nvim',
    'lukas-reineke/indent-blankline.nvim',
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
}

-- See nvim-treesitter module documentation: https://github.com/nvim-treesitter/nvim-treesitter#modules
require'nvim-treesitter.configs'.setup {
    ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    -- ignore_install = { "javascript" }, -- List of parsers to ignore installing
    highlight = {
        enable = true, -- false will disable the whole extension
        -- disable = { "c", "rust" },  -- list of language that will be disabled
        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false
    },
    rainbow = {
        enable = true,
	extended_mode = true
    }
}

vim.g.indent_blankline_use_treesitter = true

-- tokyonight.nvim settings
-- Available styles: storm, night, day
vim.g.tokyonight_style = "night"
vim.cmd('colorscheme tokyonight')

