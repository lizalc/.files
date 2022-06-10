require("bufferline").setup({
	options = {
		numbers = "buffer_id",
		diagnostics = "nvim_lsp",
		diagnostics_update_in_insert = false,
		separator_style = "thin",
		always_show_bufferline = true,
		diagnostics_indicator = function()
			return ""
		end,
		offsets = {
			{
				filetype = "NvimTree",
				text = "Files",
				highlight = "Directory",
				text_align = "left",
			},
		},
	},
})
