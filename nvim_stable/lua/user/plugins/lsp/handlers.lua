local M = {}

-- TODO: backfill this to template
M.setup = function()
	local signs = {
		{ name = "DiagnosticSignError", text = "" },
		{ name = "DiagnosticSignWarn", text = "" },
		{ name = "DiagnosticSignHint", text = "" },
		{ name = "DiagnosticSignInfo", text = "" },
	}

	for _, sign in ipairs(signs) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
	end

	local config = {
		-- disable virtual text
		virtual_text = {
			-- severity = {min=vim.diagnostic.severity.ERROR},
			severity = { min = vim.diagnostic.severity.WARN },
			prefix = " ❯❯❯ ",
		},
		-- show signs
		signs = {
			active = signs,
		},
		update_in_insert = false,
		underline = true,
		severity_sort = true,
		float = {
			focusable = false,
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
	}

	vim.diagnostic.config(config)

	-- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	--   border = "rounded",
	-- })
	--
	-- vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
	--   border = "rounded",
	-- })
end

local function lsp_highlight_document(client, bufnr)
	-- Set autocommands conditional on server_capabilities
	if client.server_capabilities.documentHighlightProvider then
		vim.api.nvim_create_augroup('lsp_document_highlight', { clear = false })
		vim.api.nvim_clear_autocmds({ buffer = bufnr, group = 'lsp_document_highlight', })
		vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
			group = 'lsp_document_highlight',
			buffer = bufnr,
			callback = vim.lsp.buf.document_highlight,
		})
		vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
			group = 'lsp_document_highlight',
			buffer = bufnr,
			callback = vim.lsp.buf.clear_references,
		})
	end
end

local function add_desc(opt, desc_str)
	return vim.tbl_deep_extend("force", opt, { desc = desc_str })
end

local function lsp_keymaps(bufnr)
	local opts = { noremap = true, silent = true }
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua require('telescope.builtin').lsp_definitions<cr>",
		add_desc(opts, "Goto Definations"))
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua require('telescope.builtin').lsp_type_definitions<cr>",
		add_desc(opts, "Goto Type Definitions"))
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua require('telescope.builtin').lsp_references<cr>",
		vim.tbl_deep_extend("force", opts, { desc = "Goto References" }))
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua require('telescope.builtin').lsp_implementations<cr>",
		add_desc(opts, "Goto Implementations"))
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rn", ":IncRename ", add_desc(opts, "Inc Rename"))

	vim.api.nvim_buf_set_keymap(bufnr, "n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>", add_desc(opts, "Hover"))
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gk", "<cmd>lua vim.lsp.buf.signature_help()<CR>",
		add_desc(opts, "Signature Help"))
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>",
		add_desc(opts, "Diagnostic Float"))
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gq", "<cmd>lua vim.diagnostic.setqflist()<CR>", add_desc(opts, "Set Qflist"))
	vim.api.nvim_buf_set_keymap(bufnr, "n", "[e", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>zz',
		add_desc(opts, "Goto Prev Diagnostic"))
	vim.api.nvim_buf_set_keymap(bufnr, "n", "]e", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>zz',
		add_desc(opts, "Goto Next Diagnostic"))
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>",
		add_desc(opts, "Diagnostic Set Loclist"))
	-- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>F", "<cmd>lua vim.lsp.buf.format { async = true }<CR>",
	-- 	add_desc(opts, "Format Document"))
	-- vim.cmd [[ command! Format execute 'lua vim.lsp.buf.format { async = true }' ]]

	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>fs', "<cmd>lua require('telescope.builtin').lsp_document_symbols<cr>",
		add_desc(opts, "Find Document Symbols"))
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>fS', "<cmd>lua require('telescope.builtin').lsp_workspace_symbols<cr>",
		add_desc(opts, "Find Workspace Symbols"))

	-- -- Trouble
	-- 	vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>TroubleToggle lsp_definitions<cr>", opts)
	-- 	vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>TroubleToggle lsp_references<cr>", opts)


	-- -- fzf-lua
	-- 	vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua require('fzf-lua').lsp_declarations()<CR>", opts)
	-- 	vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua require('fzf-lua').lsp_implementations()<CR>", opts)
	-- vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua require('fzf-lua').lsp_definitions({ jump_to_single_result = true })<CR>", opts)
	-- vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua require('fzf-lua').lsp_references({ jump_to_single_result = true })<CR>", opts)

	-- -- lspsaga
	-- 	vim.api.nvim_buf_set_keymap(bufnr, "n", "ga", "<cmd>Lspsaga code_action<CR>", opts)
	-- 	vim.api.nvim_buf_set_keymap(bufnr, "n", "[E", "<cmd>lua require('lspsaga.diagnostic'):goto_prev({ severity = vim.diagnostic.severity.ERROR })<cr>", opts)
	-- 	vim.api.nvim_buf_set_keymap(bufnr, "n", "]E", "<cmd>lua require('lspsaga.diagnostic'):goto_next({ severity = vim.diagnostic.severity.ERROR })<cr>", opts)


	-- builtin
	-- vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>zz", opts)
	-- vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>zz", opts)
	-- vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>zz", opts)
	-- vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>zz", opts)
	-- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts) -- using inc rename
end

-- local function lsp_hover_diag_auto()
-- 	vim.api.nvim_create_autocmd("CursorHold", {
-- 		buffer = bufnr,
-- 		callback = function()
-- 			local opts = {
-- 				focusable = false,
-- 				close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
-- 				border = "rounded",
-- 				source = "always",
-- 				prefix = " ",
-- 				-- scope = "cursor",
-- 			}
-- 			vim.diagnostic.open_float(nil, opts)
-- 		end
-- 	})
-- end


M.on_attach = function(client, bufnr)
	lsp_keymaps(bufnr)
	lsp_highlight_document(client, bufnr)
	-- lsp_hover_diag_auto()
end

-- local capabilities = vim.lsp.protocol.make_client_capabilities()

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
	vim.notify("Plugin cmp_nvim_lsp not found !")
	return
end

-- M.capabilities = cmp_nvim_lsp.update_capabilities(capabilities)
M.capabilities = cmp_nvim_lsp.default_capabilities()

return M
