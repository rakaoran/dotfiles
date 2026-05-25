return {
	-- Auto-close and auto-rename JSX/HTML tags
	{
		"windwp/nvim-ts-autotag",
		event = { "BufReadPre", "BufNewFile" },
		opts = {},
	},
}
