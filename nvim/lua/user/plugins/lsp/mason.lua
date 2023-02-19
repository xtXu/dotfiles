local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")

mason.setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗"
		}
	}
})

mason_lspconfig.setup({
	ensure_installed = {
		"cmake",      --require: sudo apt install python3-venv
		"jsonls",			--require: nodejs
		"clangd",
		"lua_ls",
		"marksman",
		"pyright",
		"texlab"
	},
	automatic_installation = false,
})