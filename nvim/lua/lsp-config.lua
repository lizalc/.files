local lsp_config = require("lspconfig")

local _aerial = require("aerial")
_aerial.setup({
	backends = { "lsp", "treesitter" },
	filter_kind = false,
})

local on_attach = function(client, bufnr)
	local function buf_set_option(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end

	buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

	_aerial.on_attach(client, bufnr)
end

local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

lsp_config.bashls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

lsp_config.dockerls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

lsp_config.gopls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

lsp_config.jedi_language_server.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

lsp_config.jsonnet_ls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

lsp_config.lemminx.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

lsp_config.ltex.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	cmd = { "ltex-ls" },
})

lsp_config.omnisharp.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	cmd = {
		"OmniSharp",
		"--languageserver",
		"--hostPID",
		tostring(vim.fn.getpid()),
	},
})

lsp_config.powershell_es.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	bundle_path = vim.env.HOME .. "/.local/powershell-es/",
})

lsp_config.pylsp.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

lsp_config.pyre.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

lsp_config.pyright.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

lsp_config.solargraph.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

lsp_config.sumneko_lua.setup(require("lua-dev").setup({
	lspconfig = {
		on_attach = on_attach,
		capabilities = capabilities,
		settings = {
			Lua = {
				runtime = {
					-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
					version = "LuaJIT",
					-- Setup your lua path
					path = runtime_path,
				},
				diagnostics = {
					-- Get the language server to recognize the `vim` global
					globals = { "vim" },
				},
				workspace = {
					-- Make the server aware of Neovim runtime files
					library = vim.api.nvim_get_runtime_file("", true),
				},
				-- Do not send telemetry data containing a randomized but unique identifier
				telemetry = {
					enable = false,
				},
			},
		},
		flags = {
			debounce_text_changes = 150,
		},
	},
}))

lsp_config.tailwindcss.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

lsp_config.yamlls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

local nls = require("null-ls")
nls.setup({
	on_attach = on_attach,
	update_in_insert = true,
	sources = {
		nls.builtins.formatting.gofmt,
		-- nls.builtins.formatting.goimports,
		-- nls.builtins.formatting.golines,
		nls.builtins.formatting.prettier.with({
			filetypes = { "markdown" },
		}),
		nls.builtins.formatting.stylua,
		nls.builtins.formatting.shfmt,

		nls.builtins.code_actions.proselint,
		nls.builtins.code_actions.shellcheck,

		nls.builtins.diagnostics.codespell,
		nls.builtins.diagnostics.editorconfig_checker,
		nls.builtins.diagnostics.golangci_lint,
		nls.builtins.diagnostics.luacheck,
		nls.builtins.diagnostics.staticcheck,
		nls.builtins.diagnostics.zsh,
	},
})
