vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

vim.keymap.set("n", "<C-j>", "50jzz", { desc = "Scroll down 50 lines" })
vim.keymap.set("n", "<C-k>", "50kzz", { desc = "Scroll up 50 lines" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })

vim.keymap.set("n", "<leader>t", "za", { desc = "Toggle fold" })
vim.keymap.set("n", "<leader>T", require("folds").toggle_all_function_folds, { desc = "Toggle function folds" })

vim.keymap.set("n", "<Esc>", "<Cmd>nohlsearch<CR><Esc>", { desc = "Clear search highlight" })

vim.keymap.set("n", "<leader>a", function()
	vim.cmd("normal! ggVG")
end, { desc = "Select all text (cursor stays)" })
vim.keymap.set("n", "<leader>y", function()
	local view = vim.fn.winsaveview()
	vim.cmd("silent keepjumps normal! ggVGy")
	vim.fn.winrestview(view)
end, { desc = "Yank buffer (cursor stays)" })
vim.keymap.set("x", "<leader>y", function()
	local view = vim.fn.winsaveview()
	vim.cmd("normal! gvy")
	vim.fn.winrestview(view)
end, { desc = "Yank selection (cursor stays)" })

vim.keymap.set({ "n", "v" }, "<M-d>", '"_d', { desc = "Delete to void" })
vim.keymap.set({ "n", "v" }, "<M-c>", '"_c', { desc = "Change to void" })
vim.keymap.set({ "n", "v" }, "<M-x>", '"_x', { desc = "x to void" })
vim.keymap.set({ "n", "v" }, "<M-s>", '"_s', { desc = "s to void" })
vim.keymap.set("x", "<A-p>", [["_dP]], { desc = "Paste without losing clipboard" })

vim.keymap.set("n", "<C-/>", "gcc", { remap = true, desc = "Toggle comment line" }) -- _ same as /, just terminal support haha
vim.keymap.set("v", "<C-/>", "gc", { remap = true, desc = "Toggle comment selection" }) -- _ same as /, just terminal support haha

vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines (cursor stays)" })

vim.keymap.set("n", "Q", "<nop>", { desc = "Disable Q" })
vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "Save file" })
vim.keymap.set("n", "<leader>q", ":q<CR>", { desc = "Quit" })

if vim.g.neovide then
	vim.keymap.set("n", "<C-h>", "<Cmd>BufferLineCyclePrev<CR>", { desc = "Previous buffer" })
	vim.keymap.set("n", "<C-l>", "<Cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })
end

local function append_semicolon_to_line()
	if vim.snippet and vim.snippet.active and vim.snippet.active() then
		pcall(vim.snippet.stop)
	end

	local row, col = unpack(vim.api.nvim_win_get_cursor(0))
	local line = vim.api.nvim_get_current_line()
	local content, trailing = line:match("^(.-)(%s*)$")

	if content:sub(-1) ~= ";" then
		vim.api.nvim_set_current_line(content .. ";" .. trailing)
	end

	vim.api.nvim_win_set_cursor(0, { row, math.min(col, #vim.api.nvim_get_current_line()) })
end

local function append_semicolon()
	local ok, cmp = pcall(require, "blink.cmp")

	if vim.fn.pumvisible() == 1 then
		vim.api.nvim_feedkeys(vim.keycode("<C-e>"), "nx", false)
	end

	if ok then
		if cmp.is_signature_visible and cmp.is_signature_visible() then
			cmp.hide_signature()
		end

		if cmp.is_visible and cmp.is_visible() then
			cmp.cancel({ callback = append_semicolon_to_line })
			return
		end
	end

	append_semicolon_to_line()
end

vim.keymap.set({ "n", "i", "s" }, "<C-;>", append_semicolon, { desc = "Append semicolon" })

vim.keymap.set("t", "<C-n>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- TODO: move them to autocmd.lua
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 150 })
	end,
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
	callback = function(event)
		local map = function(keys, func, desc, mode)
			mode = mode or "n"
			vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
		end

		local rename_symbol = function()
			local clients =
				vim.lsp.get_clients({ bufnr = event.buf, method = vim.lsp.protocol.Methods.textDocument_rename })
			if #clients == 0 then
				vim.notify("No LSP rename provider attached", vim.log.levels.WARN)
				return
			end

			vim.lsp.buf.rename()
		end

		-- Rename the current symbol through the LSP, so local variables stay scoped.
		map("<leader>rn", rename_symbol, "Rename Symbol")

		-- Code actions (uses snacks ui_select)
		map("<leader>ca", vim.lsp.buf.code_action, "Code Action", { "n", "x" })

		-- Show function signature help while typing arguments
		map("<C-,>", vim.lsp.buf.signature_help, "Signature Help", "i")

		-- Toggle inlay hints (show inferred types, parameter names inline)
		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
			map("<leader>h", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
			end, "Toggle Inlay Hints")
		end

		-- Show line diagnostics in a floating window
		map("gl", vim.diagnostic.open_float, "Show Line Diagnostics")
	end,
})
vim.keymap.set("n", "i", function()
	if #vim.fn.getline(".") == 0 then
		return [["_cc]]
	else
		return "i"
	end
end, { expr = true, noremap = true })
