vim.o.background = "dark"

local vscode = require("vscode")

vscode.setup({
	transparent = false,
	italic_comments = true,
	disable_nvimtree_bg = true,
})
vscode.load()
