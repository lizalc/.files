local navic = require("nvim-navic")

local function lsp_clients()
	local clients = {}
	local has_clients = false
	for _, client in pairs(vim.lsp.get_active_clients()) do
		table.insert(clients, client.name)
		has_clients = true
	end

	if has_clients then
		return " " .. table.concat(clients, "  ")
	else
		return ""
	end
end

require("lualine").setup({
	options = {
		globalstatus = true,
	},
	sections = {
		lualine_b = {
			"branch",
			{ "diff", symbols = { added = " ", modified = " ", removed = " " } },
			"diagnostics",
			{ "filename", symbols = { modified = "  ", readonly = " ", unnamed = "[No Name]" } },
			{
				function()
					pcall(navic.get_location())
				end,
				cond = navic.is_available,
			},
		},
		lualine_c = {},
		lualine_x = { { lsp_clients, cond = vim.lsp.server_ready }, "encoding", "fileformat", "filetype" },
	},
})
