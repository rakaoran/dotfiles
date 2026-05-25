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
		-- vim.api.nvim_set_hl(0, "FlashMatch", { fg = "#fe8019", bg = "#282828", bold = true })
		-- vim.api.nvim_set_hl(0, "FlashCurrent", { fg = "#ff0000", bg = "#00ff00", bold = true })
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
	keys = {
		--   { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
		--   { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
		--   { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
		--   { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
		-- {
		-- 	"<c-s>",
		-- 	mode = { "c" },
		-- 	function()
		-- 		require("flash").toggle()
		-- 	end,
		-- 	desc = "Toggle Flash Search",
		-- },
	},
}
