return {
	{
		"kevinhwang91/nvim-ufo",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = {
			"kevinhwang91/promise-async",
		},
		config = function()
			require("ufo").setup({
				fold_virt_text_handler = require("folds").minimal_fold_text,
				open_fold_hl_timeout = 0,
				provider_selector = function()
					return { "treesitter", "indent" }
				end,
			})
		end,
	},
}
