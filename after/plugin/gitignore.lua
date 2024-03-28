local gitignore = require("gitignore")

local working_dir = vim.fn.getcwd()
vim.keymap.set("n", "<leader>gi", function()
	local gitignore_location = vim.fn.input(".gitignore path: ", working_dir .. "/.gitignore")
	gitignore.generate(gitignore_location)
end)
