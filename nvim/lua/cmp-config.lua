local cmp = require("cmp")
local luasnip = require("luasnip")
local lspkind = require("lspkind")

local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	local line_range = vim.api.nvim_buf_get_lines(0, line - 1, line, true)
	return col ~= 0 and line_range[1]:sub(col, col):match("%s") == nil
end

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = {
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-n>"] = cmp.mapping.select_next_item(),
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = false,
		}),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_locally_jumpable() then
				luasnip.expand_or_jump()
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	},
	formatting = {
		format = lspkind.cmp_format({
			with_text = false,
			maxwidth = 50,
			menu = {
				buffer = "[Buffer]",
				cmdline = "[CLI]",
				dictionary = "[Dict]",
				git = "[Git]",
				luasnip = "[LuaSnip]",
				nvim_lsp = "[LSP]",
				nvim_lua = "[Lua]",
				nvim_lsp_signature_help = "[Signature]",
				path = "[Path]",
				spell = "[Spell]",
			},
		}),
	},
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "nvim_lua" },
		{ name = "nvim_lsp_signature_help" },
		{ name = "buffer" },
		{ name = "luasnip" },
		{
			name = "spell",
			keyword_length = 2,
		},
		-- {
		-- 	name = "dictionary",
		-- 	keyword_length = 2,
		-- },
	}),
})

cmp.setup.cmdline("/", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})

cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "cmdline" },
		{ name = "path" },
	}),
})

require("cmp_git").setup()
cmp.setup.filetype("gitcommit", {
	sources = cmp.config.sources({
		{ name = "luasnip" },
		{ name = "git" },
		{
			name = "spell",
			keyword_length = 2,
		},
	}),
})

require("nvim-autopairs").setup()
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))

require("cmp_dictionary").setup({
	dic = { ["*"] = { "/usr/share/dict/words" } },
	first_case_insensive = true,
	async = true,
})
