local lsp = require("lsp-zero")

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

lsp.on_attach(function(client, bufnr)
	local opts = { buffer = bufnr, remap = false }

	vim.keymap.set("n", "gd", function()
		vim.lsp.buf.definition()
	end, opts)
	vim.keymap.set("n", "gD", function()
		vim.lsp.buf.declaration()
	end, opts)
	vim.keymap.set("n", "gi", function()
		vim.lsp.buf.implementation()
	end, opts)
	vim.keymap.set("n", "go", function()
		vim.lsp.buf.type_definition()
	end, opts)
	vim.keymap.set("n", "gr", function()
		vim.lsp.buf.references()
	end, opts)
	vim.keymap.set("n", "gs", function()
		vim.lsp.buf.signature_help()
	end, opts)
	vim.keymap.set("n", "K", function()
		vim.lsp.buf.hover()
	end, opts)
	vim.keymap.set("n", "<leader>vws", function()
		vim.lsp.buf.workspace_symbol()
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
	vim.keymap.set("n", "<leader>vrr", function()
		vim.lsp.buf.references()
	end, opts)
	vim.keymap.set("n", "<leader>vrn", function()
		vim.lsp.buf.rename()
	end, opts)
	vim.keymap.set("i", "<C-h>", function()
		vim.lsp.buf.signature_help()
	end, opts)

	vim.keymap.set("n", "gq", function()
		vim.lsp.buf.format({ async = false, timeout_ms = 10000 })
	end)
end)

local formatting_config = {
	format_opts = {
		async = false,
		timeout_ms = 10000,
	},
	servers = {
		["beautysh"] = { "bash", "csh", "ksh", "sh", "zsh" },
		["null-ls"] = {
			"javascript",
			"javascriptreact",
			"typescript",
			"typescriptreact",
			"vue",
			"css",
			"scss",
			"less",
			"html",
			"json",
			"jsonc",
			"yaml",
			"markdown",
			"markdown.mdx",
			"graphql",
			"handlebars",
			"lua",
			"go",
			"rust",
			"python",
            "proto",
		},
	},
}

-- lsp.format_on_save(formatting_config)

-- lsp.format_mapping("gq", formatting_config)

lsp.setup()

local null_ls = require("null-ls")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
	sources = {
		null_ls.builtins.code_actions.gomodifytags,
		null_ls.builtins.code_actions.refactoring,
		null_ls.builtins.formatting.prettier,
		null_ls.builtins.formatting.black,
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.gofmt,
		null_ls.builtins.formatting.rustfmt,
		null_ls.builtins.formatting.protolint,
		null_ls.builtins.diagnostics.eslint,
		null_ls.builtins.diagnostics.pylint,
		null_ls.builtins.diagnostics.stylelint,
		null_ls.builtins.diagnostics.protolint,
		null_ls.builtins.diagnostics.checkmake,
	},
	-- you can reuse a shared lspconfig on_attach callback here
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({ async = false, timeout_ms = 10000 })
				end,
			})
		end
	end,
})

require("mason-null-ls").setup({
	ensure_installed = ensure_installed,
	automatic_installation = true,
})

vim.diagnostic.config({
	virtual_text = true,
})
