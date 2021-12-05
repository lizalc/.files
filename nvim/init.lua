packer_bootstrap = nil

require('packer-config')

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
    'termguicolors', 'tabstop=4', 'shiftwidth=4', 'softtabstop=-1', 'expandtab'
}

for _, setting in pairs(settings) do vim.cmd('set' .. ' ' .. setting) end

if packer_bootstrap then
    vim.o.statusline = "Bootstrapped packer.nvim! Restart after 'PackerSync' has run. %F"
else
    vim.g.indent_blankline_use_treesitter = true
    vim.g.indent_blankline_show_current_context = true
    vim.g.indent_blankline_show_current_context_start = true

    -- tokyonight.nvim settings
    -- Available styles: storm, night, day
    vim.g.tokyonight_style = "night"
    -- vim.g.tokyonight_transparent = true
    vim.cmd('colorscheme tokyonight')
end
