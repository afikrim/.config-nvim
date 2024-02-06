-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")

	-- LSP Plugins
	use({
		"VonHeikemen/lsp-zero.nvim",
		branch = "v1.x",
		requires = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" },
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },

			-- Autocompletion
			{ "hrsh7th/nvim-cmp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-nvim-lua" },

			-- Snippets
			{ "L3MON4D3/LuaSnip" },
			{ "rafamadriz/friendly-snippets" },
		},
	})

	-- Highlighting Plugins
	use("nvim-treesitter/nvim-treesitter-context")
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
	})

	-- Formatting Plugins
	use("mhartington/formatter.nvim")

	-- Language Plugins
	use("dart-lang/dart-vim-plugin")
	use("mfussenegger/nvim-jdtls")

	-- Debug Plugins
	use("mfussenegger/nvim-dap")
	use({ "leoluz/nvim-dap-go", requires = { "mfussenegger/nvim-dap" } })
	use({ "mxsdev/nvim-dap-vscode-js", requires = { "mfussenegger/nvim-dap" } })
	use({
		"microsoft/vscode-js-debug",
		opt = true,
		run = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
	})

	-- UI Plugins
	use("Mofiqul/vscode.nvim")
	use("tiagovla/scope.nvim")
	use("lukas-reineke/indent-blankline.nvim")
	use({
		"nvim-tree/nvim-tree.lua",
		requires = {
			"nvim-tree/nvim-web-devicons", -- optional
		},
	})
	use({
		"akinsho/bufferline.nvim",
		requires = { "nvim-tree/nvim-web-devicons" },
	})
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "nvim-tree/nvim-web-devicons" },
	})
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.4",
		requires = { "nvim-lua/plenary.nvim" },
	})

	-- Git Plugins
	use("lewis6991/gitsigns.nvim")
	use({
		"NeogitOrg/neogit",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
			"sindrets/diffview.nvim",
			"ibhagwan/fzf-lua",
		},
	})
	use({
		"wintermute-cell/gitignore.nvim",
		requires = {
			"nvim-telescope/telescope.nvim",
		},
	})

	-- DBM
	use({
		"kristijanhusak/vim-dadbod-ui",
		requires = {
			{ "tpope/vim-dadbod" },
			{ "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" } },
		},
		cmd = {
			"DBUI",
			"DBUIToggle",
			"DBUIAddConnection",
			"DBUIFindBuffer",
		},
		init = function()
			-- Your DBUI configuration
			vim.g.db_ui_use_nerd_fonts = 1
		end,
	})

	-- REST Client
	use({
		"NTBBloodbath/rest.nvim",
        tag = '0.2',
		requires = { "nvim-lua/plenary.nvim" },
	})

	-- Others Plugins
	use("wakatime/vim-wakatime")
	use("numToStr/Comment.nvim")
	use("github/copilot.vim")
	use("mbbill/undotree")
	use("windwp/nvim-autopairs")
	use({ "ojroques/vim-oscyank", branch = "main" })
end)
