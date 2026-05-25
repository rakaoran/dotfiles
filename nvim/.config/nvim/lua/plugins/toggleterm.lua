return {
	"akinsho/toggleterm.nvim",
	version = "*",
	keys = {
		{ "<C-t>", desc = "Toggle terminal" },
	},
	opts = {
		size = function(term)
			if term.direction == "horizontal" then
				return 15
			elseif term.direction == "vertical" then
				return vim.o.columns * 0.4
			end
		end,
		hide_numbers = true,
		shade_terminals = true,
		start_in_insert = true,
		persist_size = true,
		persist_mode = false,
		close_on_exit = true,
		direction = "horizontal",
	},
	config = function(_, opts)
		require("toggleterm").setup(opts)

		vim.keymap.set({ "n", "t" }, "<C-t>", function()
			require("toggleterm").toggle(0, nil, nil, "horizontal")
		end, { desc = "Toggle terminal" })
	end,
}
