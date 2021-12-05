-- https://github.com/williamboman/nvim-lsp-installer
if not packer_bootstrap then
    local lsp_installer = require('nvim-lsp-installer')

    lsp_installer.on_server_ready(function(server)
        local opts = {}
        server:setup(opts)
    end)
end
