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

        use 'lukas-reineke/indent-blankline.nvim'
        use 'nvim-lualine/lualine.nvim'
        use 'nvim-telescope/telescope.nvim'
        use 'p00f/nvim-ts-rainbow'

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
