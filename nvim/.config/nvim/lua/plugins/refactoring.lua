return {
	"ThePrimeagen/refactoring.nvim",
	dependencies = {
		"lewis6991/async.nvim",
	},
	keys = {
		{
			"<leader>rr",
			function()
				require("refactoring").select_refactor()
			end,
			mode = { "n", "x" },
			desc = "Select Refactor",
		},
		{
			"<leader>re",
			function()
				return require("refactoring").extract_func()
			end,
			mode = { "n", "x" },
			expr = true,
			desc = "Extract Function",
		},
		{
			"<leader>rE",
			function()
				return require("refactoring").extract_func_to_file()
			end,
			mode = { "n", "x" },
			expr = true,
			desc = "Extract Function To File",
		},
		{
			"<leader>rv",
			function()
				return require("refactoring").extract_var()
			end,
			mode = { "n", "x" },
			expr = true,
			desc = "Extract Variable",
		},
		{
			"<leader>ri",
			function()
				return require("refactoring").inline_var()
			end,
			mode = { "n", "x" },
			expr = true,
			desc = "Inline Variable",
		},
		{
			"<leader>rI",
			function()
				return require("refactoring").inline_func()
			end,
			mode = { "n", "x" },
			expr = true,
			desc = "Inline Function",
		},
	},
	opts = {},
}
