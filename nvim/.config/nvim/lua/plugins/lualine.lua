return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		options = {
			theme = "tokyonight",
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = { "branch", "diff" },
			lualine_c = {
				{
					"filename",
					symbols = {
						modified = " ●",
						alternate_file = "#",
						directory = "",
					},
					path = 1,
				},
			},
			lualine_y = { "diagnostics" },
			lualine_z = { "location" },
		},
	},
}
