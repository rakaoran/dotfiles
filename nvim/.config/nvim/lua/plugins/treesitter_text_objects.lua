return {
	"nvim-treesitter/nvim-treesitter-textobjects",
	branch = "main",
	init = function()
		vim.g.no_plugin_maps = true
	end,
	config = function()
		local select = require("nvim-treesitter-textobjects.select")
		local move = require("nvim-treesitter-textobjects.move")
		local swap = require("nvim-treesitter-textobjects.swap")

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
		-- cii = change { "x", "o" } if, dai = delete around if
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

		-- swap: swap arguments
		vim.keymap.set("n", "<leader>sa", function()
			swap.swap_next("@parameter.inner")
		end, { desc = "Swap argument with next" })
		vim.keymap.set("n", "<leader>sA", function()
			swap.swap_previous("@parameter.inner")
		end, { desc = "Swap argument with previous" })
	end,
}
