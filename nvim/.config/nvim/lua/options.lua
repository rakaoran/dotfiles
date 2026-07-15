vim.opt.number = true
vim.opt.relativenumber = true

if vim.g.neovide then
	vim.o.guifont = "JetBrainsMono Nerd Font:h18"
	vim.opt.linespace = 0
	vim.opt.cmdheight = 0
	vim.g.neovide_theme = "dark"
	vim.g.neovide_opacity = 0.75
	vim.g.neovide_normal_opacity = 0.75
	vim.g.neovide_window_blurred = true
	vim.g.neovide_floating_blur_amount_x = 19.0
	vim.g.neovide_floating_blur_amount_y = 19.0
	vim.g.neovide_padding_top = 0
	vim.g.neovide_padding_bottom = -1
	vim.g.neovide_padding_right = 0
	vim.g.neovide_padding_left = 0
	vim.g.neovide_hide_mouse_when_typing = true
end

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.inccommand = "split"

vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true
vim.opt.foldcolumn = "0"
vim.opt.fillchars:append({ fold = " " })

vim.opt.scrolloff = 50
vim.opt.ruler = false

vim.opt.undodir = os.getenv("HOME") .. "/.nvim/undodir"
vim.opt.undofile = true

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

vim.opt.clipboard = "unnamedplus"

vim.opt.mouse = "a"
vim.opt.showmode = false

vim.opt.termguicolors = true

vim.opt.confirm = true
vim.opt.signcolumn = "yes"

vim.opt.incsearch = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false

vim.opt.virtualedit = "block"

vim.diagnostic.config({
	severity_sort = true,
	float = { border = "rounded", source = "if_many" },
	underline = { severity = vim.diagnostic.severity.ERROR },
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "󰅚 ",
			[vim.diagnostic.severity.WARN] = "󰀪 ",
			[vim.diagnostic.severity.INFO] = "󰋽 ",
			[vim.diagnostic.severity.HINT] = "󰌶 ",
		},
	},
	virtual_text = {
		source = "if_many",
		spacing = 2,
	},
})
