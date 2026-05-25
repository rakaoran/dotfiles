return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"=",
			function()
				require("conform").format({ async = true, lsp_format = "fallback" })
			end,
			mode = "",
			desc = "Format buffer",
		},
	},
	opts = {
		notify_on_error = false,
		format_on_save = {
			timeout_ms = 500,
			lsp_format = "fallback", -- use LSP formatting if no dedicated formatter
		},
		formatters_by_ft = {
			lua = { "stylua" }, -- cargo install stylua
			python = { "black" }, -- pip install black
			javascript = { "prettier" }, -- pnpm i -g prettier
			typescript = { "prettier" },
			javascriptreact = { "prettier" },
			typescriptreact = { "prettier" },
			c = { "clang-format" }, -- sudo apt install clang-format
			cpp = { "clang-format" },
			go = { "goimports", "gofmt" }, -- go install golang.org/x/tools/cmd/goimports@latest  (gofmt comes with go)
			rust = { "rustfmt" }, -- comes with rustup
			zig = { "zigfmt" }, -- comes with zig
			html = { "prettier" },
			css = { "prettier" },
			json = { "prettier" },
			markdown = { "prettier" },
		},
	},
}
