local vscode = require("vscode")
local auto_dark_mode = require("auto-dark-mode")

vim.o.background = "dark"

vscode.setup({
	transparent = false,
	italic_comments = true,
	disable_nvimtree_bg = true,
})

auto_dark_mode.setup({
	update_interval = 1000,
	set_dark_mode = function()
		vscode.load("dark")
		vim.cmd("colorscheme vscode")
	end,
	set_light_mode = function()
		vscode.load("light")
		vim.cmd("colorscheme vscode")
	end,
})

vscode.load("dark")
vim.cmd("colorscheme vscode")
