return {
	"folke/flash.nvim",
	event = "VeryLazy",

	---@type Flash.Config
	opts = {
		labels = "arstgmneiopfwbluyjkvqhdcxz",
		modes = { char = { jump_labels = true, keys = { "f", "F" } } },
	},
	config = function(_, opts)
		require("flash").setup(opts)
		vim.api.nvim_set_hl(0, "FlashLabel", { fg = "#fe8019", bg = "#282828", bold = true })
		vim.keymap.set({ "n", "x", "o" }, "<c-space>", function()
			require("flash").treesitter({
				actions = {
					["<c-space>"] = "next",
					["<BS>"] = "prev",
				},
			})
		end, { desc = "Treesitter incremental selection" })
	end,
}
