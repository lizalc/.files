-- https://github.com/wbthomason/packer.nvim
local packer = nil

-- Bootstrap packer.nvim, if necessary
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd [[packadd packer.nvim]]
end

packer = require('packer')
packer.init()
packer.reset()

packer.startup({function(use)
  use 'wbthomason/packer.nvim'

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }

  use 'p00f/nvim-ts-rainbow'
  use 'lukas-reineke/indent-blankline.nvim'
  use 'folke/tokyonight.nvim'

  if packer_bootstrap then
    packer.sync()
  end
end,
config = {
    display = {
        open_fn = function()
            return require('packer.util').float({border = 'single'})
        end
    }
}})

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost packer-config.lua source <afile> | PackerSync
  augroup end
]])
