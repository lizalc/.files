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

-- These two options allow for a transparent background when using a custom theme.
-- Most likely need to be placed after setting the colorscheme. Will need to be
-- converted to Lua form.
-- highlight Normal guibg=none
-- highlight NonText guibg=none

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
    'sainnhe/sonokai',  -- Italic comment support is really nice.
    'marko-cerovac/material.nvim', -- Okish
    'folke/tokyonight.nvim',  -- kinda love this theme, especially the 'night' variant.
    'EdenEast/nightfox.nvim',
    'ful1e5/onedark.nvim',
    'wbthomason/packer.nvim',
    'lukas-reineke/indent-blankline.nvim', -- https://github.com/lukas-reineke/indent-blankline.nvim
    'nvim-treesitter/nvim-treesitter', -- https://github.com/nvim-treesitter/nvim-treesitter
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

-- sonokai settings
-- 'espresso' is also nice
-- vim.g.sonokai_style = 'atlantis'
-- vim.cmd('colorscheme sonokai')

-- material.nvim settings
-- 'palenight', 'darker' is decent. Others are meh.
-- vim.g.material_style = "oceanic"
-- vim.cmd('colorscheme material')

-- tokyonight.nvim settings
-- VERY NICE theme! 'night' variant preferred.
-- Underlines for misspelled words! Didn't test others.
vim.g.tokyonight_style = "night"
vim.cmd('colorscheme tokyonight')

-- nightfox.nvim settings
-- 'nightfox' and 'duskfox' are decent.
-- Appears to have a transparent background option which is nice.
-- This seems to be a mostly standard option though across themes.
-- vim.cmd('colorscheme nightfox')

