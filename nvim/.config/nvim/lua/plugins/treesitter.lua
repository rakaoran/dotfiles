return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		local treesitter = require("nvim-treesitter")
		treesitter
			.install({
				"bash",
				"c",
				"cpp",
				"lua",
				"python",
				"javascript",
				"typescript",
				"html",
				"css",
				"json",
				"markdown",
				"markdown_inline",
				"vim",
				"vimdoc",
				"diff",
				"go",
				"rust",
				"zig",
				"jsx",
				"tsx",
			})
			:wait(300000)

		vim.api.nvim_create_autocmd("FileType", {
			pattern = {
				"bash",
				"c",
				"cpp",
				"lua",
				"python",
				"javascript",
				"typescript",
				"javascriptreact",
				"typescriptreact",
				"html",
				"css",
				"json",
				"markdown",
				"vim",
				"diff",
				"go",
				"rust",
				"zig",
				"jsx",
				"tsx",
			},
			callback = function()
				vim.treesitter.start()
				vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end,
		})
	end,
}
