return {
	"nvim-treesitter/nvim-treesitter-context",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	opts = {
		max_lines = 8, -- if I have 8 scopes i probably need to rethink what i'm doing haha
		trim_scope = "outer",
	},
}
