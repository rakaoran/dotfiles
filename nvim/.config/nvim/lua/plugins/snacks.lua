return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	init = function()
		-- Cool neon purple/cyan dashboard colors
		vim.api.nvim_set_hl(0, "SnacksDashboardHeader", { fg = "#bd93f9" })
		vim.api.nvim_set_hl(0, "SnacksDashboardTitle", { fg = "#8be9fd", bold = true })
		vim.api.nvim_set_hl(0, "SnacksDashboardIcon", { fg = "#ff79c6" })
		vim.api.nvim_set_hl(0, "SnacksDashboardKey", { fg = "#50fa7b", bold = true })
		vim.api.nvim_set_hl(0, "SnacksDashboardDesc", { fg = "#f8f8f2" })
	end,
	---@type snacks.Config
	opts = {
		dashboard = {
			width = 40,
			preset = {
				header = [[
 ██████╗ ██╗   ██╗███████╗███████╗ █████╗ ███╗   ███╗ █████╗
██╔═══██╗██║   ██║██╔════╝██╔════╝██╔══██╗████╗ ████║██╔══██╗
██║   ██║██║   ██║███████╗███████╗███████║██╔████╔██║███████║
██║   ██║██║   ██║╚════██║╚════██║██╔══██║██║╚██╔╝██║██╔══██║
╚██████╔╝╚██████╔╝███████║███████║██║  ██║██║ ╚═╝ ██║██║  ██║
 ╚═════╝  ╚═════╝ ╚══════╝╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝
                  ╱╱  r a k a o r a n  ╱╱]],
			},
			sections = {
				{ section = "header", padding = 0 },
				{
					section = "terminal",
					cmd = "colorscript -e bars",
					height = 4,
					padding = 1,
				},
				{ icon = " ", title = "Projects", padding = 1 },
				function()
					local projects_dir = vim.fn.expand("~/Projects")
					local mru_file = vim.fn.stdpath("data") .. "/project_mru.json"

					local function read_mru()
						local f = io.open(mru_file, "r")
						if not f then
							return {}
						end
						local ok, data = pcall(vim.json.decode, f:read("*a"))
						f:close()
						return ok and data or {}
					end

					local function write_mru(data)
						local f = io.open(mru_file, "w")
						if f then
							f:write(vim.json.encode(data))
							f:close()
						end
					end

					local mru = read_mru()
					local items = {}
					local handle = vim.loop.fs_scandir(projects_dir)
					if handle then
						while true do
							local name, ftype = vim.loop.fs_scandir_next(handle)
							if not name then
								break
							end
							if ftype == "directory" then
								local dir = projects_dir .. "/" .. name
								table.insert(items, {
									icon = " ",
									desc = name,
									indent = 2,
									autokey = true,
									_ts = mru[name] or 0,
									action = function()
										mru[name] = os.time()
										write_mru(mru)
										vim.cmd.cd(dir)
										require("oil").open(dir)
									end,
								})
							end
						end
					end
					table.sort(items, function(a, b)
						if a._ts ~= b._ts then
							return a._ts > b._ts
						end
						return a.desc < b.desc
					end)
					local visible = {}
					for i = 1, math.min(9, #items) do
						visible[i] = items[i]
					end
					return visible
				end,
				{
					key = "p",
					hidden = true,
					action = function()
						local projects_dir = vim.fn.expand("~/projects")
						local mru_file = vim.fn.stdpath("data") .. "/project_mru.json"
						local f = io.open(mru_file, "r")
						local mru = {}
						if f then
							local ok, data = pcall(vim.json.decode, f:read("*a"))
							f:close()
							if ok then
								mru = data
							end
						end
						local dirs = {}
						local handle = vim.loop.fs_scandir(projects_dir)
						if handle then
							while true do
								local name, ftype = vim.loop.fs_scandir_next(handle)
								if not name then
									break
								end
								if ftype == "directory" then
									table.insert(dirs, name)
								end
							end
						end
						table.sort(dirs, function(a, b)
							local ta, tb = mru[a] or 0, mru[b] or 0
							if ta ~= tb then
								return ta > tb
							end
							return a < b
						end)
						vim.ui.select(dirs, { prompt = "Projects" }, function(choice)
							if choice then
								local dir = projects_dir .. "/" .. choice
								mru[choice] = os.time()
								local wf = io.open(mru_file, "w")
								if wf then
									wf:write(vim.json.encode(mru))
									wf:close()
								end
								vim.cmd.cd(dir)
								require("oil").open(dir)
							end
						end)
					end,
				},
				{ key = "q", action = ":qa", hidden = true },
			},
		},
		picker = {
			ui_select = true,

			sources = {
				grep = {
					exclude = {
						"lazy-lock.json",
						"go.mod",
						"go.sum",
						"pnpm-lock.yaml",
						"yarn.lock",
						"package-lock.json",
						"package.json",
						"Cargo.lock",
					},
				},
				files = {
					exclude = {
						"lazy-lock.json",
						"go.sum",
						"pnpm-lock.yaml",
						"yarn.lock",
						"package-lock.json",
						"Cargo.lock",
					},
				},
				explorer = {
					layout = { preset = "sidebar", hidden = { "input" } },
					actions = {
						toggle_all_hidden = function(picker)
							local show = not (picker.opts.hidden and picker.opts.ignored)
							picker.opts.hidden = show
							picker.opts.ignored = show
							picker.list:set_target()
							picker:find()
						end,
					},
					win = {
						list = {
							keys = {
								["a"] = false, -- add
								["d"] = false, -- delete
								["c"] = false, -- copy
								["m"] = false, -- move
								["o"] = false, -- open with system app
								["p"] = false, -- paste
								["y"] = false, -- yank
								-- keep navigation + toggle
								["<CR>"] = "confirm",
								["."] = "explorer_focus",
								[","] = "explorer_up",
								["t"] = "confirm",
								["h"] = "toggle_hidden",
								["H"] = "toggle_all_hidden",
								["i"] = "toggle_ignored",
								["z"] = "explorer_close_all",
								["r"] = "explorer_update",
							},
						},
					},
				},
			},
		},
		explorer = {
			replace_netrw = false,
		},
		words = { enabled = true },
		quickfile = { enabled = true },
	},
	keys = {
		{
			"<leader>,",
			function()
				Snacks.explorer()
			end,
			desc = "File Explorer",
		},
		{
			"<leader>/",
			function()
				Snacks.picker.grep()
			end,
			desc = "Grep",
		},
		{
			"<leader>f",
			function()
				Snacks.picker.files()
			end,
			desc = "Find Files",
		},
		{
			"<leader>sh",
			function()
				Snacks.picker.help()
			end,
			desc = "Help Pages",
		},
		{
			"<leader>ss",
			function()
				Snacks.picker.lsp_symbols()
			end,
			desc = "LSP Symbols",
		},
		{
			"<leader>sS",
			function()
				Snacks.picker.lsp_workspace_symbols()
			end,
			desc = "Workspace Symbols",
		},
		{
			"<leader>su",
			function()
				Snacks.picker.undo()
			end,
			desc = "Undo History",
		},
		{
			"<leader>st",
			function()
				---@diagnostic disable-next-line: undefined-field
				Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } })
			end,
			desc = "Todo/Fix/Fixme",
		},
		{
			"<leader>sm",
			function()
				---@diagnostic disable-next-line: undefined-field
				Snacks.picker.man({
					transform = function(item)
						return vim.tbl_contains({ "2", "3", "4", "5", "7" }, item.section)
					end,
					layout = {
						preset = "default",
						layout = {
							width = 0.9,
							height = 0.9,
						},
					},
					confirm = function(picker, item)
						picker:close()
						if not item then
							return
						end

						vim.schedule(function()
							vim.cmd("tab Man " .. item.ref)
						end)
					end,
				})
			end,
			desc = "Man Pages",
		},
		-- LSP
		{
			"gd",
			function()
				Snacks.picker.lsp_definitions()
			end,
			desc = "Goto Definition",
		},
		{
			"gD",
			function()
				Snacks.picker.lsp_declarations()
			end,
			desc = "Goto Declaration",
		},
		{
			"gr",
			function()
				Snacks.picker.lsp_references()
			end,
			nowait = true,
			desc = "References",
		},
		{
			"gI",
			function()
				Snacks.picker.lsp_implementations()
			end,
			desc = "Goto Implementation",
		},
		{
			"gy",
			function()
				Snacks.picker.lsp_type_definitions()
			end,
			desc = "Goto Type Definition",
		},
		{
			"]]",
			function()
				Snacks.words.jump(vim.v.count1)
			end,
			desc = "Next word reference",
		},
		{
			"[[",
			function()
				Snacks.words.jump(-vim.v.count1)
			end,
			desc = "Previous word reference",
		},
	},
}
