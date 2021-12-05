if not packer_bootstrap then
    vim.opt.list = true
    require('indent_blankline').setup {
        use_treesitter = true,
        show_current_context = true,
        show_current_context_start = true
    }
end
