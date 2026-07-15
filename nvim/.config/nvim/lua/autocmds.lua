vim.filetype.add({
	extension = {
		h = "c",
	},
})

local filetype_group = vim.api.nvim_create_augroup("user-filetype-options", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
	group = filetype_group,
	pattern = "markdown",
	callback = function()
		vim.opt_local.wrap = true
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	group = filetype_group,
	pattern = { "c", "cpp", "objc", "objcpp", "cuda" },
	callback = function()
		vim.opt_local.tabstop = 8
		vim.opt_local.softtabstop = 8
		vim.opt_local.shiftwidth = 8
		vim.opt_local.expandtab = false
		vim.opt_local.smartindent = false
		vim.opt_local.cindent = true
		vim.opt_local.indentexpr = ""
		vim.opt_local.cinoptions = ":0,=s,l1,t0,g0,(0"
	end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 150 })
	end,
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
	callback = function(event)
		local map = function(keys, func, desc, mode)
			vim.keymap.set(mode or "n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
		end

		map("<leader>ca", vim.lsp.buf.code_action, "Code Action", { "n", "x" })
		map("<C-,>", vim.lsp.buf.signature_help, "Signature Help", "i")
		map("gl", vim.diagnostic.open_float, "Show Line Diagnostics")

		map("<leader>rn", function()
			local clients =
				vim.lsp.get_clients({ bufnr = event.buf, method = vim.lsp.protocol.Methods.textDocument_rename })
			if #clients == 0 then
				vim.notify("No LSP rename provider attached", vim.log.levels.WARN)
				return
			end

			vim.lsp.buf.rename()
		end, "Rename Symbol")

		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
			map("<leader>h", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
			end, "Toggle Inlay Hints")
		end
	end,
})
