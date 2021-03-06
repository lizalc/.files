local function lsp_clients()
	local clients = {}
	local has_clients = false
	for _, client in pairs(vim.lsp.get_active_clients()) do
		local present = false
		for _, name in pairs(clients) do
			if name == client.name then
				present = true
			end
		end

		if not present then
			table.insert(clients, client.name)
			has_clients = true
		end
	end

	if has_clients then
		return " " .. table.concat(clients, "  ")
	else
		return ""
	end
end

require("lualine").setup({
	extensions = {
		"aerial",
		"nvim-dap-ui",
		"nvim-tree",
		"quickfix",
	},
	options = {
		globalstatus = true,
	},
	sections = {
		lualine_b = {
			"branch",
			{ "diff", symbols = { added = " ", modified = " ", removed = " " } },
			"diagnostics",
			{ "filename", symbols = { modified = "  ", readonly = " ", unnamed = "[No Name]" } },
			"aerial",
		},
		lualine_c = {},
		lualine_x = { { lsp_clients, cond = vim.lsp.server_ready }, "encoding", "fileformat", "filetype" },
	},
})
