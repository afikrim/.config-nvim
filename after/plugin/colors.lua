-- require("rose-pine").setup({
-- 	disable_background = true,
-- })
--
-- function ColorMyPencils(color)
-- 	color = color or "rose-pine"
-- 	vim.cmd.colorscheme(color)
--
-- 	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
-- 	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
-- end
--
-- ColorMyPencils()

vim.o.background = "dark"

local c = require("vscode.colors").get_colors()
require("vscode").setup({
	transparent = false,
	italic_comments = true,
	disable_nvimtree_bg = true,
})
require("vscode").load()
