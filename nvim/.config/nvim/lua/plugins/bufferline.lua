return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	lazy = false,
	opts = function()
		local colors = require("tokyonight.colors").setup({ style = "night", on })
		local bar_bg = "#151821"
		local tab_bg = "#1b2030"
		local selected_bg = "#27324a"
		local separator_fg = bar_bg
		return {
			highlights = {
				error_diagnostic = { bg = tab_bg, fg = colors.red },
				error_diagnostic_selected = { bg = selected_bg, fg = colors.red },
				error_diagnostic_visible = { bg = tab_bg, fg = colors.red },

				warning_diagnostic = { bg = tab_bg, fg = colors.yellow },
				warning_diagnostic_selected = { bg = selected_bg, fg = colors.yellow },
				warning_diagnostic_visible = { bg = tab_bg, fg = colors.yellow },

				info_diagnostic = { bg = tab_bg, fg = colors.blue },
				info_diagnostic_selected = { bg = selected_bg, fg = colors.blue },
				info_diagnostic_visible = { bg = tab_bg, fg = colors.blue },

				hint_diagnostic = { bg = tab_bg, fg = colors.teal },
				hint_diagnostic_selected = { bg = selected_bg, fg = colors.teal },
				hint_diagnostic_visible = { bg = tab_bg, fg = colors.teal },
				fill = { bg = bar_bg },
				background = { bg = tab_bg, fg = colors.comment },
				buffer_selected = { bg = selected_bg, fg = colors.fg, bold = true },
				buffer_visible = { bg = tab_bg, fg = colors.fg_dark },
				separator = { bg = tab_bg, fg = separator_fg },
				separator_selected = { bg = selected_bg, fg = separator_fg },
				separator_visible = { bg = tab_bg, fg = separator_fg },
				numbers = { bg = tab_bg, fg = colors.comment },
				numbers_selected = { bg = selected_bg, fg = colors.blue, bold = true },
				numbers_visible = { bg = tab_bg, fg = colors.fg_dark },
				modified = { bg = tab_bg, fg = colors.orange },
				modified_selected = { bg = selected_bg, fg = colors.orange },
				modified_visible = { bg = tab_bg, fg = colors.orange },
				duplicate = { bg = tab_bg, fg = colors.comment },
				duplicate_selected = { bg = selected_bg, fg = colors.comment, italic = true },
				duplicate_visible = { bg = tab_bg, fg = colors.comment },
				diagnostic = { bg = tab_bg, fg = colors.comment },
				diagnostic_selected = { bg = selected_bg, fg = colors.comment },
				diagnostic_visible = { bg = tab_bg, fg = colors.comment },
				hint = { bg = tab_bg, fg = colors.teal },
				hint_selected = { bg = selected_bg, fg = colors.teal },
				hint_visible = { bg = tab_bg, fg = colors.teal },
				info = { bg = tab_bg, fg = colors.blue },
				info_selected = { bg = selected_bg, fg = colors.blue },
				info_visible = { bg = tab_bg, fg = colors.blue },
				warning = { bg = tab_bg, fg = colors.yellow },
				warning_selected = { bg = selected_bg, fg = colors.yellow },
				warning_visible = { bg = tab_bg, fg = colors.yellow },
				error = { bg = tab_bg, fg = colors.red },
				error_selected = { bg = selected_bg, fg = colors.red },
				error_visible = { bg = tab_bg, fg = colors.red },
				pick = { bg = tab_bg, fg = colors.red },
				pick_selected = { bg = selected_bg, fg = colors.red, bold = true },
				pick_visible = { bg = tab_bg, fg = colors.red },
				indicator_selected = { fg = selected_bg, bg = selected_bg },
			},
			options = {
				numbers = "ordinal",
				close_command = "bdelete! %d",
				diagnostics = "nvim_lsp",
				diagnostics_indicator = function(count)
					return " " .. count
				end,
				indicator = { icon = "", style = "icon" },
				always_show_bufferline = true,
				show_buffer_close_icons = false,
				show_close_icon = false,
				separator_style = "thin",
				offsets = {
					{
						filetype = "snacks_layout_box",
						text = "Explorer",
						highlight = "Directory",
						text_align = "center",
					},
				},
			},
		}
	end,
	keys = {
		{ "<leader>1", "<cmd>BufferLineGoToBuffer 1<cr>", desc = "Go to buffer 1" },
		{ "<leader>2", "<cmd>BufferLineGoToBuffer 2<cr>", desc = "Go to buffer 2" },
		{ "<leader>3", "<cmd>BufferLineGoToBuffer 3<cr>", desc = "Go to buffer 3" },
		{ "<leader>4", "<cmd>BufferLineGoToBuffer 4<cr>", desc = "Go to buffer 4" },
		{ "<leader>5", "<cmd>BufferLineGoToBuffer 5<cr>", desc = "Go to buffer 5" },
		{ "<leader>6", "<cmd>BufferLineGoToBuffer 6<cr>", desc = "Go to buffer 6" },
		{ "<leader>7", "<cmd>BufferLineGoToBuffer 7<cr>", desc = "Go to buffer 7" },
		{ "<leader>8", "<cmd>BufferLineGoToBuffer 8<cr>", desc = "Go to buffer 8" },
		{ "<leader>9", "<cmd>BufferLineGoToBuffer 9<cr>", desc = "Go to buffer 9" },
		{ "<leader>bd", "<cmd>bdelete<cr>", desc = "Delete buffer" },
		{ "<leader>bo", "<cmd>BufferLineCloseOthers<cr>", desc = "Close other buffers" },
		{ "<leader>br", "<cmd>BufferLineCloseRight<cr>", desc = "Close buffers to the right" },
		{ "<leader>bl", "<cmd>BufferLineCloseLeft<cr>", desc = "Close buffers to the left" },
	},
	config = function(_, opts)
		require("bufferline").setup(opts)

		local function close_deleted_file_buffers(actions)
			local ok, oil_util = pcall(require, "oil.util")
			if not ok then
				return
			end

			local deleted_paths = {}
			for _, action in ipairs(actions or {}) do
				if action.type == "delete" then
					local _, path = oil_util.parse_url(action.url)
					if path then
						path = vim.fs.normalize(oil_util.url_unescape(path))
						deleted_paths[path] = action.entry_type or "file"
					end
				end
			end

			if vim.tbl_isempty(deleted_paths) then
				return
			end

			for _, buf in ipairs(vim.api.nvim_list_bufs()) do
				if vim.bo[buf].buflisted and vim.api.nvim_buf_is_valid(buf) then
					local name = vim.api.nvim_buf_get_name(buf)
					if name ~= "" then
						local buf_path = vim.fs.normalize(name)
						for deleted_path, entry_type in pairs(deleted_paths) do
							local is_deleted_file = entry_type ~= "directory" and buf_path == deleted_path
							local is_inside_deleted_dir = entry_type == "directory"
								and (buf_path == deleted_path or vim.startswith(buf_path, deleted_path .. "/"))

							if is_deleted_file or is_inside_deleted_dir then
								if not vim.bo[buf].modified then
									pcall(vim.api.nvim_buf_delete, buf, {})
								else
									vim.notify(
										"Deleted file still has unsaved buffer changes: "
											.. vim.fn.fnamemodify(buf_path, ":~:."),
										vim.log.levels.WARN
									)
								end
								break
							end
						end
					end
				end
			end
		end

		vim.api.nvim_create_autocmd("User", {
			group = vim.api.nvim_create_augroup("bufferline-close-oil-deleted-files", { clear = true }),
			pattern = "OilActionsPost",
			callback = function(event)
				if event.data and not event.data.err then
					close_deleted_file_buffers(event.data.actions)
				end
			end,
		})

		-- LRU: auto-close least recently used buffers when exceeding 10
		local max_buffers = 6
		vim.api.nvim_create_autocmd("BufEnter", {
			group = vim.api.nvim_create_augroup("bufferline-lru", { clear = true }),
			callback = function()
				vim.schedule(function()
					local bufs = vim.tbl_filter(function(b)
						return vim.bo[b].buflisted and vim.api.nvim_buf_is_valid(b)
					end, vim.api.nvim_list_bufs())

					if #bufs <= max_buffers then
						return
					end

					-- sort by lastused (oldest first)
					table.sort(bufs, function(a, b)
						return vim.fn.getbufinfo(a)[1].lastused < vim.fn.getbufinfo(b)[1].lastused
					end)

					-- close oldest buffers until we're at max, skip modified
					local to_close = #bufs - max_buffers
					for i = 1, #bufs do
						if to_close <= 0 then
							break
						end
						local buf = bufs[i]
						if not vim.bo[buf].modified then
							vim.api.nvim_buf_delete(buf, {})
							to_close = to_close - 1
						end
					end
				end)
			end,
		})
	end,
}
