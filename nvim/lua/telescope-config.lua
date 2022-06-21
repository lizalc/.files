local telescope = require("telescope")
telescope.setup()
telescope.load_extension("dap")
telescope.load_extension("fzf")
telescope.load_extension("frecency")
-- This should be working automatically but is not for an unknown reason.
telescope.load_extension("notify")
vim.g.dashboard_default_executive = "telescope"
