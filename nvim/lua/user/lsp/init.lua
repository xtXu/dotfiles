local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
	return
end

require("user.lsp.mason")             -- mason setup
require("user.lsp.lspconfig")					-- lsp server setup
require("user.lsp.handlers").setup()  -- nvim diagnostics, hover, ... setup
