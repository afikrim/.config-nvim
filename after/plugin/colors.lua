vim.o.background = "light"

local vscode = require("vscode")

vscode.setup({
	transparent = false,
	italic_comments = true,
	disable_nvimtree_bg = true,
})
vscode.load()

vim.cmd("colorscheme vscode")
