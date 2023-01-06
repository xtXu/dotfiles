local mason_status_ok, mason = pcall(require, "mason")
if not mason_status_ok then
	vim.notify("Plugin mason.nvim not found !")
	return
end

local mlsp_status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mlsp_status_ok then
	vim.notify("Plugin mason-lspconfig.nvim not found !")
	return
end

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
		"sumneko_lua",
		"marksman",
		"pyright",
	},
	automatic_installation = false,
})
