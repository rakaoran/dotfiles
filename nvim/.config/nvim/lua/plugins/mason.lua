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
					"--all-scopes-completion",
					"--completion-style=detailed",
					"--header-insertion=iwyu",
					"--function-arg-placeholders=1",
				},
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
				"rust_analyzer",
				"eslint",
			},
			automatic_enable = true,
		},
	},
}
