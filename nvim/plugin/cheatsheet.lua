-- https://github.com/sudormrfbin/cheatsheet.nvim
if not packer_bootstrap then
    require('cheatsheet').setup({
        bundled_cheatsheets = {
            disabled = {
                'nerd-fonts'
            }
        }
    })
end
