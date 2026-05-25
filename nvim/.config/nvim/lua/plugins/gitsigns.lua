return {
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				signs = {
					add = { text = "+" },
					change = { text = "~" },
					delete = { text = "-" },
					topdelete = { text = "-" },
					changedelete = { text = "~" },
					untracked = { text = "+" },
				},
				on_attach = function(bufnr)
					local gs = require("gitsigns")
					vim.keymap.set("n", "]c", function()
						gs.nav_hunk("next")
					end, { buffer = bufnr })
					vim.keymap.set("n", "[c", function()
						gs.nav_hunk("prev")
					end, { buffer = bufnr })
					vim.keymap.set("n", "<leader>gb", gs.blame_line, { buffer = bufnr })
				end,
			})
		end,
	},
}
