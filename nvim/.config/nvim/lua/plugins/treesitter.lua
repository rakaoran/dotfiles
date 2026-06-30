return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
		},
		config = function()
			local function ensure_tree_sitter_cli()
				local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"
				if not vim.env.PATH:find(mason_bin, 1, true) then
					vim.env.PATH = mason_bin .. ":" .. vim.env.PATH
				end

				if vim.fn.executable("tree-sitter") == 1 then
					return
				end

				local ok_registry, registry = pcall(require, "mason-registry")
				local ok_async, async = pcall(require, "mason-core.async")
				if not (ok_registry and ok_async) then
					error("tree-sitter CLI is required before installing parsers, but Mason could not be loaded")
				end

				async.run_blocking(function()
					registry.refresh()
					local pkg = registry.get_package("tree-sitter-cli")

					if not pkg:is_installed() then
						vim.notify("Installing tree-sitter-cli before compiling parsers", vim.log.levels.INFO)
						async.wait(function(resolve, reject)
							pkg:install({}, function(success, result)
								if success then
									resolve(result)
								else
									reject(result)
								end
							end)
						end)
					end
				end)

				if vim.fn.executable("tree-sitter") ~= 1 then
					error("tree-sitter CLI install finished, but `tree-sitter` is still not executable")
				end
			end

			ensure_tree_sitter_cli()

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

			local use_treesitter_indent = {
				c = false,
				cpp = false,
			}

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
				callback = function(args)
					vim.treesitter.start()
					if use_treesitter_indent[vim.bo[args.buf].filetype] ~= false then
						vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
					end
				end,
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		opts = {
			max_lines = 8, -- if I have 8 scopes i probably need to rethink what i'm doing haha
			trim_scope = "outer",
		},
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		init = function()
			vim.g.no_plugin_maps = true
		end,
		config = function()
			local select = require("nvim-treesitter-textobjects.select")
			local move = require("nvim-treesitter-textobjects.move")

			require("nvim-treesitter-textobjects").setup({
				select = {
					lookahead = true,
					selection_modes = {
						["@function.outer"] = "V",
						["@class.outer"] = "V",
					},
				},
				move = {
					set_jumps = true,
				},
			})

			-- select: functions
			vim.keymap.set({ "x", "o" }, "if", function()
				select.select_textobject("@function.inner", "textobjects")
			end)
			vim.keymap.set({ "x", "o" }, "af", function()
				select.select_textobject("@function.outer", "textobjects")
			end)
			-- cia = change inside argument, daa = delete around argument
			vim.keymap.set({ "x", "o" }, "ia", function()
				select.select_textobject("@parameter.inner", "textobjects")
			end)
			vim.keymap.set({ "x", "o" }, "aa", function()
				select.select_textobject("@parameter.outer", "textobjects")
			end)
			-- cib = change inside block, dab = delete around block
			vim.keymap.set({ "x", "o" }, "ib", function()
				select.select_textobject("@block.inner", "textobjects")
			end)
			vim.keymap.set({ "x", "o" }, "ab", function()
				select.select_textobject("@block.outer", "textobjects")
			end)
			-- cii = change inside if, dai = delete around if
			vim.keymap.set({ "x", "o" }, "ii", function()
				select.select_textobject("@conditional.inner", "textobjects")
			end)
			vim.keymap.set({ "x", "o" }, "ai", function()
				select.select_textobject("@conditional.outer", "textobjects")
			end)
			-- cil = change inside loop, dal = delete around loop
			vim.keymap.set({ "x", "o" }, "il", function()
				select.select_textobject("@loop.inner", "textobjects")
			end)
			vim.keymap.set({ "x", "o" }, "al", function()
				select.select_textobject("@loop.outer", "textobjects")
			end)
			-- cis = change inside struct/class, das = delete around struct/class
			vim.keymap.set({ "x", "o" }, "is", function()
				select.select_textobject("@class.inner", "textobjects")
			end)
			vim.keymap.set({ "x", "o" }, "as", function()
				select.select_textobject("@class.outer", "textobjects")
			end)
			-- cir = change inside return, dar = delete around return
			vim.keymap.set({ "x", "o" }, "ir", function()
				select.select_textobject("@return.inner", "textobjects")
			end)
			vim.keymap.set({ "x", "o" }, "ar", function()
				select.select_textobject("@return.outer", "textobjects")
			end)

			-- move: jump between functions/arguments/conditionals/loops
			vim.keymap.set({ "n", "x", "o" }, "]f", function()
				move.goto_next_start("@function.outer", "textobjects")
			end)
			vim.keymap.set({ "n", "x", "o" }, "[f", function()
				move.goto_previous_start("@function.outer", "textobjects")
			end)
			vim.keymap.set({ "n", "x", "o" }, "]a", function()
				move.goto_next_start("@parameter.inner", "textobjects")
			end)
			vim.keymap.set({ "n", "x", "o" }, "[a", function()
				move.goto_previous_start("@parameter.inner", "textobjects")
			end)
			vim.keymap.set({ "n", "x", "o" }, "]i", function()
				move.goto_next_start("@conditional.outer", "textobjects")
			end)
			vim.keymap.set({ "n", "x", "o" }, "[i", function()
				move.goto_previous_start("@conditional.outer", "textobjects")
			end)
			vim.keymap.set({ "n", "x", "o" }, "]l", function()
				move.goto_next_start("@loop.outer", "textobjects")
			end)
			vim.keymap.set({ "n", "x", "o" }, "[l", function()
				move.goto_previous_start("@loop.outer", "textobjects")
			end)

		end,
	},
}
