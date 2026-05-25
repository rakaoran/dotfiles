return {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	opts = {
		style = "night",
		on_highlights = function(highlights)
			highlights.DiagnosticUnnecessary = {}
			highlights["@lsp.mod.unused"] = {}
			highlights["@lsp.typemod.variable.unused"] = {}
			highlights["@lsp.typemod.parameter.unused"] = {}
		end,
	},
	config = function(_, opts)
		require("tokyonight").setup(opts)
		vim.cmd.colorscheme("tokyonight")
	end,
}
