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
						modified = " ●", -- Text to show when the buffer is modified
						alternate_file = "#", -- Text to show to identify the alternate file
						directory = "", -- Text to show when the buffer is a directory
					},
					path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute
				},
			},
			lualine_y = { "diagnostics" },
			lualine_z = { "filetype" },
		},
	},
}
