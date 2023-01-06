local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
	vim.notify("Plugin toggleterm not found !")
  return
end

toggleterm.setup {
	open_mapping = [[<c-\>]],
	float_opts = {
    border = 'curved',
    width = function(term)
			return math.floor(0.6 * vim.o.columns)
		end,
    height = function(term)
			return math.floor(0.7 * vim.o.lines)
		end,
  },
}
function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', 'kj', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
-- vim.keymap.set('n', '<leader>t', [[<Cmd>ToggleTerm direction=float<CR>]], opts)

vim.cmd('noremap <silent><leader>t <Cmd>exe v:count1 . "ToggleTerm direction=float"<CR>')
