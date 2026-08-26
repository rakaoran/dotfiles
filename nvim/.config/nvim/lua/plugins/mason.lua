vim.lsp.config("rust_analyzer", {
	cmd = { vim.fn.expand("/home/rakaoran/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/bin/rust-analyzer") },
})
vim.lsp.enable("rust_analyzer", true)
return {
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
		},
		opts = {
			ensure_installed = {
				"stylua",
				"black",
				"prettier",
				"clang-format",
				"goimports",
			},
			auto_update = false,
			run_on_start = true,
			start_delay = 3000,
		},
	},
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
		config = function(_, opts)
			vim.lsp.config("*", {
				capabilities = require("blink.cmp").get_lsp_capabilities(),
			})
			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						runtime = { version = "LuaJIT" },
						workspace = {
							checkThirdParty = false,
							library = { vim.env.VIMRUNTIME },
						},
					},
				},
			})
			vim.lsp.config("pyright", {
				settings = {
					python = {
						analysis = {
							typeCheckingMode = "off",
							diagnosticSeverityOverrides = {
								reportMissingImports = "none",
								reportMissingModuleSource = "none",
							},
						},
					},
				},
			})
			vim.lsp.config("clangd", {
				cmd = {
					"clangd",
					"--enable-config",
					"--background-index",
					"--completion-style=detailed",
					"--header-insertion=iwyu",
					"--function-arg-placeholders=1",
				},
				filetypes = { "c" },
			})
			require("mason-lspconfig").setup(opts)
		end,
		opts = {
			ensure_installed = {
				"lua_ls",
				"bashls",
				"buf_ls",
				"tailwindcss",
				"zls",
				"pyright",
				"ts_ls",
				"clangd",
				"html",
				"cssls",
				"jsonls",
				"gopls",
				"eslint",
			},
			automatic_enable = true,
		},
	},
}
