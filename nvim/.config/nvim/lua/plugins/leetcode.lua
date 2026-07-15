return {
	"kawre/leetcode.nvim",
	build = ":TSUpdate html",
	dependencies = {
		"folke/snacks.nvim",
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
	},
	keys = {
		{ "<leader>ll", "<cmd>Leet list<cr>", desc = "LeetCode List" },
		{ "<leader>lt", "<cmd>Leet tabs<cr>", desc = "LeetCode Tabs" },
		{ "<leader>ld", "<cmd>Leet daily<cr>", desc = "LeetCode Daily" },
		{ "<leader>lr", "<cmd>Leet run<cr>", desc = "LeetCode Run" },
		{ "<leader>ls", "<cmd>Leet submit<cr>", desc = "LeetCode Submit" },
		{ "<leader>lc", "<cmd>Leet console<cr>", desc = "LeetCode Console" },
		{ "<leader>li", "<cmd>Leet info<cr>", desc = "LeetCode Info" },
		{ "<leader>lq", "<cmd>Leet exit<cr>", desc = "LeetCode Exit" },
	},
	opts = {
		lang = "python3",
	},
}
