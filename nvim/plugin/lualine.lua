-- https://github.com/nvim-lualine/lualine.nvim
if not packer_bootstrap then
    require('lualine').setup {
        options = {
            theme = 'tokyonight'
        }
    }
end
