local handlers = require("user.plugins.lsp.handlers")
local lspconfig = require("lspconfig")

local opt = {
	on_attach = handlers.on_attach,
	capabilities = handlers.capabilities,
}

-- Sumneko_lua
local lua_opt = require("user.plugins.lsp.settings.lua_ls")
local lua_opts = vim.tbl_deep_extend("force", lua_opt, opt)
lspconfig["lua_ls"].setup(lua_opts)

-- jsonls
lspconfig["jsonls"].setup(opt)

-- cmake
lspconfig["cmake"].setup(opt)

-- texlab
lspconfig["texlab"].setup(opt)

-- marksman
lspconfig["marksman"].setup(opt)

-- pyright
local py_opt = require("user.plugins.lsp.settings.pyright")
local py_opts = vim.tbl_deep_extend("force", py_opt, opt)
lspconfig["pyright"].setup(py_opts)
-- lspconfig["pyright"].setup(opt)

-- Clangd
local clangd_opt = require("user.plugins.lsp.settings.clangd")
local clangd_opts = vim.tbl_deep_extend("force", clangd_opt, opt)
lspconfig["clangd"].setup(clangd_opts)
-- clangd.setup {
-- 	server = {
-- 		on_attach = handlers.on_attach,
-- 		capabilities = handlers.capabilities,
-- 		cmd = clangd_opt.cmd,
-- 		root_dir = clangd_opt.root_dir,
-- 		filetypes = clangd_opt.filetypes
-- 	},
-- 	extensions = {
-- 		-- defaults:
-- 		-- Automatically set inlay hints (type hints)
-- 		autoSetHints = true,
-- 		-- These apply to the default ClangdSetInlayHints command
-- 		inlay_hints = {
-- 			-- Only show inlay hints for the current line
-- 			only_current_line = false,
-- 			only_current_line_autocmd = "CursorHold",
-- 			-- whether to show parameter hints with the inlay hints or not
-- 			show_parameter_hints = true,
-- 			-- prefix for parameter hints
-- 			parameter_hints_prefix = "<- ",
-- 			-- prefix for all the other hints (type, chaining)
-- 			other_hints_prefix = "=> ",
-- 			-- whether to align to the length of the longest line in the file
-- 			max_len_align = false,
-- 			-- whether to align to the extreme right or not
-- 			right_align = false,
-- 			-- The color of the hints
-- 			highlight = "Comment",
-- 			-- The highlight group priority for extmark
-- 			priority = 100,
-- 		},
-- 		ast = {
-- 			-- These are unicode, should be available in any font
-- 			role_icons = {
-- 				type = "🄣",
-- 				declaration = "🄓",
-- 				expression = "🄔",
-- 				statement = ";",
-- 				specifier = "🄢",
-- 				["template argument"] = "🆃",
-- 			},
-- 			kind_icons = {
-- 				Compound = "🄲",
-- 				Recovery = "🅁",
-- 				TranslationUnit = "🅄",
-- 				PackExpansion = "🄿",
-- 				TemplateTypeParm = "🅃",
-- 				TemplateTemplateParm = "🅃",
-- 				TemplateParamObject = "🅃",
-- 			},
--
-- 			highlights = {
-- 				detail = "Comment",
-- 			},
-- 		},
-- 		memory_usage = {
-- 			border = "none",
-- 		},
-- 		symbol_info = {
-- 			border = "none",
-- 		},
-- 	},
-- }

