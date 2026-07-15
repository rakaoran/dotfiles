return {
	"stevearc/oil.nvim",
	keys = {
		{ "<leader>o", "<cmd>Oil<CR>", desc = "Open Oil" },
	},
	dependencies = { "nvim-tree/nvim-web-devicons" },
	lazy = false,
	opts = {
		delete_to_trash = true,
		keymaps = {
			["g?"] = { "actions.show_help", mode = "n" },
			["<CR>"] = "actions.select",
			["<C-p>"] = "actions.preview",
			["<C-R>"] = "actions.refresh",
			[","] = { "actions.parent", mode = "n" },
			["."] = { "actions.open_cwd", mode = "n" },
			[";"] = { "actions.cd", mode = "n" },
			["<leader>os"] = { "actions.change_sort", mode = "n" },
			["<leader>ox"] = "actions.open_external",
			["<leader>ot"] = { "actions.toggle_hidden", mode = "n" },
		},
		use_default_keymaps = false,
		view_options = {
			show_hidden = true,
			is_always_hidden = function(name)
				return vim.tbl_contains({
					".git",
					"..",
					".vscode",
					".claude",
					".codex",
					"node_modules",
				}, name)
			end,
		},
	},
}
