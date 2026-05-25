return {
	"folke/trouble.nvim",
	dependencies = { "folke/snacks.nvim" },
	opts = {
		win = { position = "right", size = 0.4 },
		focus = true,
		warn_no_results = false, -- show a warning when there are no results
		open_no_results = true, -- open the trouble window when there are no results
		modes = {
			diagnostics = {
				focus = true,
				win = { position = "bottom", size = 0.4 },
			},
		},
	}, -- for default options, refer to the configuration section for custom setup.
	cmd = "Trouble",
	keys = {
		{
			"<leader>xa",
			"<cmd>Trouble diagnostics toggle<cr>",
			desc = "Diagnostics (Trouble)",
		},
		{
			"<leader>xb",
			"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
			desc = "Buffer Diagnostics (Trouble)",
		},
		{
			"<leader>xl",
			"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
			desc = "LSP Definitions / references / ... (Trouble)",
		},
	},
}
