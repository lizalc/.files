packer_bootstrap = nil

require('packer-config')

-- Core editor settings:
-- * Enable line numbers
-- * Use relative line numbering
-- * Allow directional keys to wrap to previous / next line
-- * Match cursor to terminal settings otherwise Neovim overwrites them >:(
-- * Enable mouse support
local settings = {
    'number', 'relativenumber', 'whichwrap+=<,>,h,l,[,]',
    'guicursor=a:hor20-blinkwait175-blinkoff150-blinkon175,i:ver25', 'mouse=a',
    'termguicolors', 'tabstop=4', 'shiftwidth=4', 'softtabstop=-1', 'expandtab',
    'clipboard=unnamed'
}

for _, setting in pairs(settings) do vim.cmd('set' .. ' ' .. setting) end

if packer_bootstrap then
    vim.o.statusline = "Bootstrapped packer.nvim! 'PackerSync' then restart. %F"
else
    vim.g.tokyonight_colors = {
        -- default is too purplish
        fg = "#e6e5e1"
    }
    -- tokyonight.nvim settings
    -- Available styles: storm, night, day
    vim.g.tokyonight_style = "night"
    -- vim.g.tokyonight_transparent = true
    vim.cmd('colorscheme tokyonight')

    vim.g.dashboard_default_executive = 'telescope'
end
