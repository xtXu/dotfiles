return {

	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
		"p00f/clangd_extensions.nvim",
	},

	config = function()
		require("user.plugins.lsp.mason")
		require("user.plugins.lsp.lspconfig")
		require("user.plugins.lsp.handlers").setup()
	end
}
