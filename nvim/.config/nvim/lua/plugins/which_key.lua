return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		preset = "classic",
		delay = function(ctx)
			return ctx.plugin and 0 or 1000
		end,
		spec = {
			{ "<leader>f", group = "find" },
			{ "<leader>s", group = "search" },
			{ "<leader>d", group = "debug" },
			{ "<leader>g", group = "git" },
			{ "<leader>b", group = "buffer" },
			{ "<leader>l", group = "leetcode" },
			{ "<leader>m", group = "markdown" },
			{ "<leader>o", group = "oil" },
			{ "<leader>x", group = "diagnostics" },
			{ "<leader>r", group = "refactor" },
		},
	},
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer Keymaps",
		},
	},
}
