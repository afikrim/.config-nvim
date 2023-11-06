local lsp = require("lsp-zero")
local lsp_config = require("lspconfig")

lsp.preset("recommended")

local ensure_installed = {
	"lua_ls",
	"tsserver",
	"rust_analyzer",
	"gopls",
	"pylsp",
}
lsp.ensure_installed(ensure_installed)

-- Fix Undefined global 'vim'
lsp.nvim_workspace()

local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
	["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
	["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
	["<C-y>"] = cmp.mapping.confirm({ select = true }),
	["<C-Space>"] = cmp.mapping.complete(),
})

cmp_mappings["<Tab>"] = nil
cmp_mappings["<S-Tab>"] = nil

lsp.setup_nvim_cmp({
	mapping = cmp_mappings,
})

lsp.set_preferences({
	suggest_lsp_servers = false,
	sign_icons = {
		error = "E",
		warn = "W",
		hint = "H",
		info = "I",
	},
})

local on_attach = function(client, bufnr)
	local opts = { buffer = bufnr, remap = false }
	local telescope_builtin = require("telescope.builtin")

	vim.keymap.set("n", "gd", function()
		telescope_builtin.lsp_definitions()
	end, opts)
	vim.keymap.set("n", "gD", function()
		vim.lsp.buf.declaration()
	end, opts)
	vim.keymap.set("n", "gi", function()
		telescope_builtin.lsp_implementations()
	end, opts)
	vim.keymap.set("n", "go", function()
		telescope_builtin.lsp_type_definitions()
	end, opts)
	vim.keymap.set("n", "gr", function()
		telescope_builtin.lsp_references()
	end, opts)
	vim.keymap.set("n", "gs", function()
		telescope_builtin.lsp_document_symbols()
	end, opts)
	vim.keymap.set("n", "K", function()
		vim.lsp.buf.hover()
	end, opts)
	vim.keymap.set("n", "<leader>vws", function()
		telescope_builtin.lsp_workspace_symbols()
	end, opts)
	vim.keymap.set("n", "<leader>vd", function()
		vim.diagnostic.open_float()
	end, opts)
	vim.keymap.set("n", "[d", function()
		vim.diagnostic.goto_next()
	end, opts)
	vim.keymap.set("n", "]d", function()
		vim.diagnostic.goto_prev()
	end, opts)
	vim.keymap.set("n", "<leader>vca", function()
		vim.lsp.buf.code_action()
	end, opts)
	vim.keymap.set("n", "<leader>vrn", function()
		vim.lsp.buf.rename()
	end, opts)
	vim.keymap.set("i", "<C-h>", function()
		vim.lsp.buf.signature_help()
	end, opts)

	vim.keymap.set("n", "gq", function()
		vim.cmd("Format")
	end)

	local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePost", {
			group = augroup,
			buffer = bufnr,
			callback = function()
				vim.cmd("FormatWrite")
			end,
		})
	end
end

lsp.on_attach(on_attach)

lsp_config["dartls"].setup({
	on_attach = on_attach,
	settings = {
		dart = {
			analysisExcludedFolders = {
				vim.fn.expand("$HOME/AppData/Local/Pub/Cache"),
				vim.fn.expand("$HOME/.pub-cache"),
				vim.fn.expand("/opt/homebrew/"),
				vim.fn.expand("$HOME/tools/flutter/"),
			},
			updateImportsOnRename = true,
			completeFunctionCalls = true,
			showTodos = true,
		},
	},
})

lsp.setup()

vim.diagnostic.config({
	virtual_text = true,
})
