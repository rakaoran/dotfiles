return {
	"NMAC427/guess-indent.nvim",
	event = "BufReadPost",
	opts = {
		filetype_exclude = {
			"netrw",
			"tutor",
			"c",
			"cpp",
			"objc",
			"objcpp",
			"cuda",
		},
	},
}
