local default_colors = require("kanagawa.colors").setup()

vim.notify = require("notify")
vim.notify.setup({
	-- background_colour = default_colors.oldWhite,
})

local client_notifs = {}
local spinner_frames = { "⣾", "⣷", "⣯", "⣟", "⡿", "⢿", "⣻", "⣽" }

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
		local cb = function()
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
				-- if there is a progress message
				if type(progress) == "table" and progress.percentage and progress.percentage ~= 0 then
					local notify_opts
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
					notif_data.notification = vim.notify( -- notify with percentage and message
						(progress.percentage and progress.percentage .. "%\t" or "") .. (progress.message or ""),
						"info",
						notify_opts
					)
					if new_msg then -- if it's a new message, start the update spinner background job
						notif_data.spinner = 1
						update_spinner(notif_data)
					end
					-- if there is finished progress and a notification, complete it
				elseif progress and not vim.tbl_isempty(notif_data) then
					notif_data.notification = vim.notify(
						"Complete",
						"info",
						{ icon = "", replace = notif_data.notification, timeout = 3000 }
					)
					notif_data.spinner = nil
				end
			end
		end
		pcall(cb) -- something about null-ls (?) causes the status notification function to throw.
	end,
})
