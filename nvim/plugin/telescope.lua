-- https://github.com/nvim-telescope/telescope.nvim
if not packer_bootstrap then
    telescope = require('telescope')
    telescope.setup()
    telescope.load_extension('fzf')
end
