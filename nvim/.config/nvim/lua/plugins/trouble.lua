return {
	"folke/trouble.nvim",
	dependencies = { "folke/snacks.nvim" },
	opts = {
		win = { position = "right", size = 0.4 },
		focus = true,
		warn_no_results = false,
		open_no_results = true,
		modes = {
			diagnostics = {
				focus = true,
				win = { position = "bottom", size = 0.4 },
			},
		},
	},
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
