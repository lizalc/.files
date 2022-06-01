-- Core editor settings:
-- * Enable line numbers
-- * Use relative line numbering
-- * Allow directional keys to wrap to previous / next line
-- * Match cursor to terminal settings otherwise Neovim overwrites them >:(
-- * Enable mouse support

-- opt in to: https://old.reddit.com/r/neovim/comments/rvwsl3/introducing_filetypelua_and_a_call_for_help/
vim.g.do_filetype_lua = 1
vim.opt.termguicolors = true

vim.cmd([[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost init.lua source <afile> | PackerCompile
    augroup end
]])

local packer_bootstrap = nil

-- Bootstrap packer.nvim, if necessary
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    })
    vim.cmd([[packadd packer.nvim]])
end

local packer = require("packer")
packer.init()
packer.reset()

packer.startup({
    function(use)
        use("wbthomason/packer.nvim")
        use("folke/tokyonight.nvim")
        use("projekt0n/github-nvim-theme")
        use("rebelot/kanagawa.nvim")
        use("fladson/vim-kitty")
        use("gentoo/gentoo-syntax")
        use("rcarriga/nvim-notify")
        use("ojroques/vim-oscyank")

        use({
            "nvim-treesitter/nvim-treesitter",
            run = ":TSUpdate",
        })

        use({
            "nvim-treesitter/nvim-treesitter-refactor",
            requires = "nvim-treesitter/nvim-treesitter",
        })

        use({
            "hrsh7th/nvim-cmp",
            requires = {
                "hrsh7th/cmp-nvim-lsp",
                "hrsh7th/cmp-buffer",
                "hrsh7th/cmp-path",
                "hrsh7th/cmp-cmdline",
                "hrsh7th/cmp-nvim-lua",
                "L3MON4D3/LuaSnip",
                "saadparwaiz1/cmp_luasnip",
                "onsails/lspkind-nvim",
            },
        })

        use({
            "jose-elias-alvarez/null-ls.nvim",
            requires = "nvim-lua/plenary.nvim",
        })

        use({
            "neovim/nvim-lspconfig",
            requires = {
                "hrsh7th/nvim-cmp",
                "ray-x/lsp_signature.nvim",
            },
        })

        use("kosayoda/nvim-lightbulb")

        use({
            "folke/trouble.nvim",
            requires = "kyazdani42/nvim-web-devicons",
        })

        use({
            "rafamadriz/friendly-snippets",
            requires = "L3MON4D3/LuaSnip",
        })

        use({
            "p00f/nvim-ts-rainbow",
            requires = "nvim-treesitter/nvim-treesitter",
        })

        use({
            "nvim-treesitter/nvim-treesitter-context",
            requires = "nvim-treesitter/nvim-treesitter",
        })

        use({
            "folke/twilight.nvim",
            requires = "nvim-treesitter/nvim-treesitter",
        })

        use({
            "lukas-reineke/indent-blankline.nvim",
            requires = "nvim-treesitter/nvim-treesitter",
        })

        use({
            "windwp/nvim-ts-autotag",
            requires = "nvim-treesitter/nvim-treesitter",
        })

        use({
            "windwp/nvim-autopairs",
            requires = "hrsh7th/nvim-cmp",
        })

        use({
            "kyazdani42/nvim-tree.lua",
            requires = "kyazdani42/nvim-web-devicons",
        })

        use({
            "akinsho/bufferline.nvim",
            requires = "kyazdani42/nvim-web-devicons",
        })

        use { 'akinsho/git-conflict.nvim', config = function()
            require('git-conflict').setup()
        end }

        use({
            "nvim-lualine/lualine.nvim",
            requires = {
                {
                    "kyazdani42/nvim-web-devicons",
                    opt = true,
                },
                "SmiteshP/nvim-gps",
            },
        })

        use({
            "nvim-telescope/telescope.nvim",
            requires = {
                "nvim-treesitter/nvim-treesitter",
                "neovim/nvim-lspconfig",
                "nvim-lua/plenary.nvim",
                { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
                {
                    "nvim-telescope/telescope-frecency.nvim",
                    requires = "tami5/sqlite.lua",
                },
                {
                    "kyazdani42/nvim-web-devicons",
                    opt = true,
                },
            },
        })

        use({
            "sudormrfbin/cheatsheet.nvim",
            requires = {
                "nvim-telescope/telescope.nvim",
                "nvim-lua/popup.nvim",
                "nvim-lua/plenary.nvim",
            },
        })

        use("lewis6991/spellsitter.nvim")

        use({
            "lewis6991/gitsigns.nvim",
            requires = "nvim-lua/plenary.nvim",
        })

        use({
            "TimUntersberger/neogit",
            requires = "nvim-lua/plenary.nvim",
        })

        use({
            "beauwilliams/focus.nvim",
            cmd = { "FocusSplitNicely", "FocusSplitCycle" },
            module = "focus",
            config = function()
                require("focus").setup({
                    hybridnumber = true,
                    absolutenumber_unfocussed = true,
                })
            end,
        })

        use({
            "glepnir/dashboard-nvim",
            requires = "nvim-telescope/telescope.nvim",
        })

        use({
            "weilbith/nvim-code-action-menu",
            cmd = "CodeActionMenu",
        })

        use("google/vim-jsonnet")
        use("editorconfig/editorconfig-vim")

        use("ellisonleao/glow.nvim")

        use("folke/which-key.nvim")
        use("mrjones2014/legendary.nvim")

        use({
            "folke/todo-comments.nvim",
            requires = "nvim-lua/plenary.nvim",
            config = function()
                require("todo-comments").setup()
            end,
        })

        use("folke/lua-dev.nvim")

        use({
            "terrortylor/nvim-comment",
            config = function()
                require("nvim_comment").setup()
            end,
        })

        use({
            "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
            as = "lsp_lines",
            config = function()
                require("lsp_lines").register_lsp_virtual_lines()
            end,
        })

        use({
            "norcalli/nvim-colorizer.lua",
            config = function()
                require("colorizer").setup({
                    lua = { mode = "foreground" },
                })
            end,
        })

        if packer_bootstrap then
            packer.sync()
        end
    end,
    config = {
        display = {
            open_fn = function()
                return require("packer.util").float({ border = "single" })
            end,
        },
    },
})

vim.cmd([[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]])

vim.opt.showmode = false
vim.opt.spell = true

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.whichwrap:append("<,>,h,l,[,]")
vim.opt.guicursor = "a:hor20-blinkwait175-blinkoff150-blinkon175,i:ver25"
vim.opt.mouse = "a"

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = -1
vim.opt.expandtab = true

vim.opt.clipboard = "unnamed"
vim.opt.completeopt = "menu,menuone,noselect"

vim.diagnostic.config({
    virtual_text = false, -- handled by lsp_lines plugin
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
})

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

require("nvim-treesitter.configs").setup({
    ensure_installed = "all",
    ignore_install = { "phpdoc" },
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
        },
    },
    rainbow = {
        enable = true,
        extended_mode = true,
    },
    refactor = {
        highlight_definitions = {
            enable = true,
        },
    },
    indent = { enable = true },
    autotag = {
        enable = true,
        filetypes = {
            "html",
            "javascript",
            "javascriptreact",
            "typescriptreact",
            "svelte",
            "vue",
            "xml",
            "csproj",
        },
    },
})
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = [[nvim_treesitter#foldexpr()]]
-- Open files unfolded by default
vim.cmd("set nofoldenable")

local cmp = require("cmp")
local luasnip = require("luasnip")
local lspkind = require("lspkind")

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = {
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        }),
        ["<Tab>"] = function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end,
        ["<S-Tab>"] = function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end,
    },
    formatting = {
        format = lspkind.cmp_format({
            with_text = false,
            maxwidth = 50,
            menu = {
                buffer = "[Buffer]",
                nvim_lsp = "[LSP]",
                nvim_lua = "[Lua]",
                path = "[Path]",
                luasnip = "[LuaSnip]",
            },
        }),
    },
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "nvim_lua" },
        { name = "luasnip" },
        { name = "buffer" },
    }),
})

cmp.setup.cmdline("/", {
    sources = {
        { name = "buffer" },
    },
})

cmp.setup.cmdline(":", {
    sources = cmp.config.sources({
        { name = "path" },
        { name = "cmdline" },
    }),
})

require("nvim-autopairs").setup()
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))

local on_attach = function(_, bufnr)
    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end

    buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

    require("lsp_signature").on_attach({
        bind = true,
        handler_opts = {
            border = "rounded",
        },
    }, bufnr)
end

local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

local lsp_config = require("lspconfig")

lsp_config.bashls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
})

lsp_config.dockerls.setup({
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
    bundle_path = vim.fn.glob "$HOME/.vscode*-insiders/extensions/ms-vscode.powershell-preview-*/modules",
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

-- lsp_config.solargraph.setup({
--     on_attach = on_attach,
--     capabilities = capabilities,
-- })

lsp_config.sumneko_lua.setup(require("lua-dev").setup({
    lspconfig = {
        on_attach = on_attach,
        capabilities = capabilities,
        cmd = { vim.fn.glob("$HOME/.vscode*-insiders/extensions/sumneko.lua-*/server/bin/lua-language-server") },
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

-- local nls = require("null-ls")
-- nls.setup({
-- 	on_attach = on_attach,
-- 	update_in_insert = true,
-- 	sources = {
-- 		nls.builtins.formatting.stylua,
-- 		nls.builtins.formatting.shfmt,
--
-- 		nls.builtins.code_actions.shellcheck,
--
-- 		nls.builtins.diagnostics.luacheck,
-- 		nls.builtins.diagnostics.shellcheck,
-- 	},
-- })

require("trouble").setup()
require("luasnip.loaders.from_vscode").load()
require("treesitter-context").setup()
require("spellsitter").setup()
require("twilight").setup()
require("nvim-tree").setup()
require("neogit").setup()

vim.opt.list = true
vim.opt.listchars:append("space:⋅")
require("indent_blankline").setup({
    use_treesitter = true,
    space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = true,
    show_first_indent_level = true,
    show_trailing_blankline_indent = false,
    max_indent_increase = 1,
    char_list = { "│", "|", "¦", "┆", "┊" },
    buftype_exclude = { "terminal", "nofile" },
    filetype_exclude = { "NvimTree", "dashboard" },
})

require("bufferline").setup({
    options = {
        diagnostics = "nvim_lsp",
        diagnostics_update_in_insert = false,
        separator_style = "thin",
        always_show_bufferline = true,
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

local gps = require("nvim-gps")
gps.setup()

require("lualine").setup({
    options = {
        globalstatus = true,
    },
    sections = {
        lualine_b = { "branch", "diff", "diagnostics", "filename", { gps.get_location, cond = gps.is_available } },
        lualine_c = {},
    },
})

local telescope = require("telescope")
telescope.setup()
telescope.load_extension("fzf")
telescope.load_extension("frecency")
vim.g.dashboard_default_executive = "telescope"

require("cheatsheet").setup({
    bundled_cheatsheets = {
        disabled = {
            "nerd-fonts",
        },
    },
})

require("gitsigns").setup({
    current_line_blame = true,
    current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol",
        delay = 250,
        ignore_whitespace = true,
    },
    current_line_blame_formatter_opts = {
        relative_time = true,
    },
})

vim.opt.timeoutlen = 50
require("which-key").setup()

require("legendary").setup()

vim.g.tokyonight_colors = {
    -- default is too purplish
    fg = "#e6e5e1",
}
vim.g.tokyonight_style = "night"
vim.g.tokyonight_italic_keywords = true
vim.g.tokyonight_italic_comments = true
vim.g.tokyonight_italic_functions = true
vim.g.tokyonight_italic_variables = false
vim.g.tokyonight_transparent = true
vim.g.tokyonight_lualine_bold = true
--vim.cmd([[colorscheme tokyonight]])

vim.wo.cursorline = true
vim.wo.cursorlineopt = "number"

local default_colors = require("kanagawa.colors").setup()

require("kanagawa").setup({
    transparent = true,
    overrides = {
        CursorLineNr = { fg = default_colors.oldWhite },
    },
})
vim.cmd([[colorscheme kanagawa]])

vim.notify = require("notify")
vim.notify.setup({
    background_colour = default_colors.oldWhite
})
-- This should be working automatically but is not for an unknown reason.
telescope.load_extension('notify')

local client_notifs = {}
local spinner_frames = { "⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" } -- spinners

local function update_spinner(notif_data) -- update spinner helper function to defer
    if notif_data.spinner then
        local new_spinner = (notif_data.spinner + 1) % #spinner_frames
        notif_data.spinner = new_spinner

        notif_data.notification = vim.notify(nil, nil, {
            hide_from_history = true,
            icon = spinner_frames[new_spinner],
            replace = notif_data.notification,
        })

        vim.defer_fn(function()
            update_spinner(notif_data)
        end, 100)
    end
end

vim.api.nvim_create_augroup("lsp_notify", { clear = true }) -- create augroup
vim.api.nvim_create_autocmd("User", {
    pattern = "LspProgressUpdate", -- LSP Progress Update autocommand
    group = "lsp_notify",
    desc = "LSP progress notification",
    callback = function()
        local bufnr = vim.api.nvim_get_current_buf() -- get buffer number
        for _, client in pairs(vim.lsp.get_active_clients()) do -- loop over each client to check notifications
            if not client_notifs[bufnr] then -- create buffer specific notification table if not exists
                client_notifs[bufnr] = {}
            end
            if not client_notifs[bufnr][client.id] then -- create buffers client  specific  notification table if not exists
                client_notifs[bufnr][client.id] = {}
            end
            local notif_data = client_notifs[bufnr][client.id] -- set notif_data variable
            local progress = nil
            for _, progress_msg in pairs(client.messages.progress) do
                progress = true -- expose if a progress exists
                if not progress_msg.done then
                    progress = progress_msg -- get clients first not done progress messages
                    break
                end
            end
            if type(progress) == "table" and progress.percentage and progress.percentage ~= 0 then -- if there is a progress message
                local notify_opts = {} -- define notification options
                local new_msg = notif_data.notification == nil -- if it's a new message set different options
                if new_msg then -- for new messages set a title, initialize icone and disable timeout
                    notify_opts = {
                        title = client.name .. (#progress.title > 0 and ": " .. progress.title or ""),
                        icon = spinner_frames[1],
                        timeout = false,
                    }
                else -- for existing messages just update the existing notification
                    notify_opts = { replace = notif_data.notification }
                end
                notif_data.notification = vim.notify(-- notify with percentage and message
                    (progress.percentage and progress.percentage .. "%\t" or "") .. (progress.message or ""),
                    "info",
                    notify_opts
                )
                if new_msg then -- if it's a new message, start the update spinner background job
                    update_spinner(notif_data)
                end
            elseif progress and not vim.tbl_isempty(notif_data) then -- if there is finished progress and a notification, complete it
                notif_data.notification = vim.notify(
                    "Complete",
                    "info",
                    { icon = "", replace = notif_data.notification, timeout = 3000 }
                )
                notif_data = {} -- clear notification data
            end
        end
    end,
})

local function copy(lines, _)
    vim.fn.OSCYankString(table.concat(lines, "\n"))
end

local function paste()
    return {
        vim.fn.split(vim.fn.getreg(''), '\n'),
        vim.fn.getregtype('')
    }
end

vim.g.clipboard = {
    name = "osc52",
    copy = {
        ["+"] = copy,
        ["*"] = copy
    },
    paste = {
        ["+"] = paste,
        ["*"] = paste
    }
}

vim.g.oscyank_silent = true
