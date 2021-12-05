-- https://github.com/wbthomason/packer.nvim
local packer = nil

-- Bootstrap packer.nvim, if necessary
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({
        'git', 'clone', '--depth', '1',
        'https://github.com/wbthomason/packer.nvim', install_path
    })
    vim.cmd [[packadd packer.nvim]]
end

packer = require('packer')
packer.init()
packer.reset()

packer.startup({
    function(use)
        use 'wbthomason/packer.nvim'

        -- Theme
        use 'folke/tokyonight.nvim'

        -- Common modules and dependencies
        use 'kyazdani42/nvim-web-devicons'
        use 'nvim-lua/plenary.nvim'
        use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
        use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}

        use 'folke/trouble.nvim'
        use 'glepnir/dashboard-nvim'
        use 'gpanders/editorconfig.nvim'
        use 'hrsh7th/cmp-nvim-lsp'
        use 'hrsh7th/cmp-buffer'
        use 'hrsh7th/cmp-path'
        use 'hrsh7th/cmp-cmdline'
        use 'hrsh7th/nvim-cmp'
        use 'hrsh7th/cmp-vsnip'
        use 'hrsh7th/vim-vsnip'
        use 'hrsh7th/vim-vsnip-integ'
        use 'kyazdani42/nvim-tree.lua'
        use 'lukas-reineke/indent-blankline.nvim'
        use 'neovim/nvim-lspconfig'
        use 'nvim-lualine/lualine.nvim'
        use 'nvim-telescope/telescope.nvim'
        use 'p00f/nvim-ts-rainbow'
        use 'rafamadriz/friendly-snippets'
        use 'romgrk/barbar.nvim'
        use 'williamboman/nvim-lsp-installer'

        use {
            'sudormrfbin/cheatsheet.nvim',
            requires = {
                {'nvim-telescope/telescope.nvim'},
                {'nvim-lua/popup.nvim'},
                {'nvim-lua/plenary.nvim'}
            }
        }

        use {
            'nvim-telescope/telescope-frecency.nvim',
            requires = {
                'tami5/sqlite.lua'
            }
        }

        if packer_bootstrap then packer.sync() end
    end,
    config = {
        display = {
            open_fn = function()
                return require('packer.util').float({border = 'single'})
            end
        }
    }
})

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost packer-config.lua source <afile> | PackerSync
  augroup end
]])
