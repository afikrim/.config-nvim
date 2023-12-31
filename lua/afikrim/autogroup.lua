--- This function is taken from https://github.com/norcalli/nvim_utils
local function nvim_create_augroups(definitions)
	for group_name, definition in pairs(definitions) do
		vim.api.nvim_command("augroup " .. group_name)
		vim.api.nvim_command("autocmd!")
		for _, def in ipairs(definition) do
			local command = table.concat(vim.tbl_flatten({ "autocmd", def }), " ")
			vim.api.nvim_command(command)
		end
		vim.api.nvim_command("augroup END")
	end
end

local autocmds = {
	terminal_job = {
		{ "TermOpen", "*", "setlocal nonumber norelativenumber" },
	},
	toggle_search_highlighting = {
		{ "InsertEnter", "*", "setlocal nohlsearch" },
	},
	lua_highlight = {
		{ "TextYankPost", "*", [[silent! lua vim.highlight.on_yank() {higroup="IncSearch", timeout=400}]] },
	},
	ansi_esc_log = {
		{ "BufEnter", "*.log", ":AnsiEsc" },
	},
}

nvim_create_augroups(autocmds)
