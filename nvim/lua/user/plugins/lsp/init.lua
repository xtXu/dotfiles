return {

	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
			"p00f/clangd_extensions.nvim",
		},

		config = function()
			require("user.plugins.lsp.mason")
			require("user.plugins.lsp.lspconfig")
			require("user.plugins.lsp.handlers").setup()
		end
	},

	{
		"williamboman/mason.nvim",
		-- event = {"VeryLazy"},
		dependencies = {
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		config = function ()
			local mason = require("mason")
			local mason_tool_installer = require("mason-tool-installer")
			mason.setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗"
					}
				}
			})
			mason_tool_installer.setup {

				-- a list of all tools you want to ensure are installed upon
				-- start; they should be the names Mason uses for each tool
				ensure_installed = {

					{"texlab", version="v4.3.0"},

					"cmake-language-server",      --require: sudo apt install python3-venv
					"json-lsp",			--require: nodejs
					"clangd",
					"lua-language-server",
					"marksman",
					"pyright",
				},

				auto_update = false,

				run_on_start = true,

				start_delay = 1000, -- 3 second delay

				-- debounce_hours = 5,

			}

		end
	},

	-- lspsaga
	{
		"glepnir/lspsaga.nvim",
    -- event = "BufRead",
		lazy = true,
    config = function()
        require("lspsaga").setup({
					scroll_preview = {
						scroll_down = "<a-j>",
						scroll_up = "<a-k>",
					},
					symbol_in_winbar = {
							enable = false,
						},
				})
    end,
    dependencies = {
			"nvim-tree/nvim-web-devicons",
			"nvim-treesitter/nvim-treesitter",
			"neovim/nvim-lspconfig",
    },
		-- key setting in lsp handlers
		-- keys = function()
		-- end
	}
}
