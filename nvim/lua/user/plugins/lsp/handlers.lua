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
			severity = {min=vim.diagnostic.severity.WARN},
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

local function lsp_keymaps(bufnr)
  local opts = { noremap = true, silent = true }


	-- Trouble
	local status, _ = pcall(require, "trouble")
	if status then
		vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>TroubleToggle lsp_definitions<cr>", opts)
		vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>TroubleToggle lsp_references<cr>", opts)
	else
		vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>zz", opts)
		vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>zz", opts)
	end


	-- fzf-lua
	local status, _ = pcall(require, "fzf-lua")
	if status then
		vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua require('fzf-lua').lsp_declarations()<CR>", opts)
		vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua require('fzf-lua').lsp_implementations()<CR>", opts)
		-- vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua require('fzf-lua').lsp_definitions({ jump_to_single_result = true })<CR>", opts)
		-- vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua require('fzf-lua').lsp_references({ jump_to_single_result = true })<CR>", opts)
	else
		vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>zz", opts)
		vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>zz", opts)
	end

	-- lspsaga
	local status, _ = pcall(require, "lspsaga")
	if status then
		vim.api.nvim_buf_set_keymap(bufnr, "n", "ga", "<cmd>Lspsaga code_action<CR>", opts)
		vim.api.nvim_buf_set_keymap(bufnr, "n", "[E", "<cmd>lua require('lspsaga.diagnostic'):goto_prev({ severity = vim.diagnostic.severity.ERROR })<cr>", opts)
		vim.api.nvim_buf_set_keymap(bufnr, "n", "]E", "<cmd>lua require('lspsaga.diagnostic'):goto_next({ severity = vim.diagnostic.severity.ERROR })<cr>", opts)
	else
		vim.api.nvim_buf_set_keymap(bufnr, "n", "ga", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	end


	-- rename
	local status, _ = pcall(require, "inc_rename")
	if status then
		vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rn", ":IncRename ", opts)
	else
		vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	end

	-- builtin 
	-- vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>zz", opts)
	-- vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>zz", opts)
	-- vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>zz", opts)
	-- vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>zz", opts)
	-- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts) -- using inc rename

	vim.api.nvim_buf_set_keymap(bufnr, "n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gk", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gq", "<cmd>lua vim.diagnostic.setqflist()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "[e", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>zz', opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "]e", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>zz', opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.format { async = true }' ]]
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
