local handlers = require("user.plugins.lsp.handlers")
local lspconfig = require("lspconfig")
-- local coq = require("coq")

local opt = {
	on_attach = handlers.on_attach,
	capabilities = handlers.capabilities,
}

require("mason-lspconfig").setup({
	automatic_installation = true,
})

-- use mason-lspconfig to setup the server automatically
require("mason-lspconfig").setup_handlers {
	-- The first entry (without a key) will be the default handler
	-- and will be called for each installed server that doesn't have
	-- a dedicated handler.
	function (server_name) -- default handler (optional)
		local status, server_opt = pcall(require, "user.plugins.lsp.settings."..server_name)
		local opts = opt
		if status then
			opts = vim.tbl_deep_extend("force", server_opt, opt)
		end

		require("lspconfig")[server_name].setup(opts)
		-- require("lspconfig")[server_name].setup(coq.lsp_ensure_capabilities(opts))
	end,
	-- Next, you can provide a dedicated handler for specific servers.
	-- For example, a handler override for the `rust_analyzer`:
	["clangd"] = function ()
		local clangd = require("clangd_extensions")
		local clangd_opt = require("user.plugins.lsp.settings.clangd")
		clangd.setup {
			server = {
				on_attach = handlers.on_attach,
				capabilities = handlers.capabilities,
				cmd = clangd_opt.cmd,
				root_dir = clangd_opt.root_dir,
				filetypes = clangd_opt.filetypes
			},
			extensions = {
				-- defaults:
				-- Automatically set inlay hints (type hints)
				autoSetHints = true,
				-- These apply to the default ClangdSetInlayHints command
				inlay_hints = {
					inline = vim.fn.has("nvim-0.10") == 1,
					-- Only show inlay hints for the current line
					only_current_line = false,
					only_current_line_autocmd = "CursorHold",
					-- whether to show parameter hints with the inlay hints or not
					show_parameter_hints = true,
					-- prefix for parameter hints
					parameter_hints_prefix = "<- ",
					-- prefix for all the other hints (type, chaining)
					other_hints_prefix = "=> ",
					-- whether to align to the length of the longest line in the file
					max_len_align = false,
					-- whether to align to the extreme right or not
					right_align = false,
					-- The color of the hints
					highlight = "Comment",
					-- The highlight group priority for extmark
					priority = 100,
				},
				memory_usage = {
					border = "none",
				},
				symbol_info = {
					border = "none",
				},
			},
		}
	end
}

