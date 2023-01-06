local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Navi to top and end of the line
keymap("", "H", "^", opts)
keymap("", "L", "$", opts)

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<A-Up>", ":<C-u>resize +2<CR>", opts)
keymap("n", "<A-Down>", ":<C-u>resize -2<CR>", opts)
keymap("n", "<A-Left>", ":<C-u>vertical resize -2<CR>", opts)
keymap("n", "<A-Right>", ":<C-u>vertical resize +2<CR>", opts)

-- No highlighting after search
keymap("n", "<leader>l", ":<C-u>nohlsearch<CR>", opts)

-- Focus center or current cursor position after search
keymap("n", "n", "nzz", opts)
keymap("n", "N", "Nzz", opts)

-- Navigate buffers (bufferline instead)
-- keymap("n", "R", ":bnext<CR>", opts)
-- keymap("n", "E", ":bprevious<CR>", opts)

-- quit
keymap("n", "<leader>q", ":q<cr>", { noremap = true})
keymap("n", "<leader>Q", ":qa<cr>", { noremap = true})
keymap("n", "<leader>w", ":w<cr>", { noremap = true})
keymap("n", "<leader>W", ":wa<cr>", { noremap = true})

-- Insert --
-- Press kj fast to Normal mode
keymap("i", "kj", "<ESC>", opts)
-- Move cursor
keymap("i", "<C-h>", "<ESC>ha", opts)
keymap("i", "<C-l>", "<ESC>la", opts)
-- keymap("i", "<C-j>", "<ESC>ja", opts)
-- keymap("i", "<C-k>", "<ESC>ka", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
-- keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)


-- Nvimtree
keymap("n", "tt", "<Cmd>NvimTreeFindFileToggle<CR>", opts)

-- bufferline
keymap("n", "R", ":BufferLineCycleNext<CR>", opts)
keymap("n", "E", ":BufferLineCyclePrev<CR>", opts)

-- hop
vim.api.nvim_set_keymap('', 'f', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>", {})
vim.api.nvim_set_keymap('', 'F', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>", {})
vim.api.nvim_set_keymap('', 't', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })<cr>", {})
vim.api.nvim_set_keymap('', 'T', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })<cr>", {})
vim.api.nvim_set_keymap('', '<leader>s', "<cmd>lua require'hop'.hint_char2()<cr>", {})
vim.api.nvim_set_keymap('', '<leader>/', "<cmd>lua require'hop'.hint_patterns()<cr>", {})
vim.api.nvim_set_keymap('', '<leader><leader>l', "<cmd>lua require'hop'.hint_lines()<cr>", {})
vim.api.nvim_set_keymap('', '<leader><leader>j', "<cmd>lua require'hop'.hint_lines({direction = require'hop.hint'.HintDirection.AFTER_CURSOR})<cr>", {})
vim.api.nvim_set_keymap('', '<leader><leader>k', "<cmd>lua require'hop'.hint_lines({direction = require'hop.hint'.HintDirection.BEFORE_CURSOR})<cr>", {})


vim.api.nvim_del_keymap('s', 'f')
vim.api.nvim_del_keymap('s', 'F')
vim.api.nvim_del_keymap('s', 't')
vim.api.nvim_del_keymap('s', 'T')

-- telescope
-- local telescope_status_ok, tbuiltin = pcall(require,'telescope.builtin')
-- if telescope_status_ok then
-- 	vim.keymap.set('n', '<leader>ff', tbuiltin.find_files, {})
-- 	vim.keymap.set('n', '<leader>F', tbuiltin.find_files(require('telescope.themes').get_dropdown{previewer = false}), {})
-- 	vim.keymap.set('n', '<leader>fG', tbuiltin.live_grep, {})
-- 	vim.keymap.set('n', 'fb', tbuiltin.buffers, {})
-- 	vim.keymap.set('n', 'fh', tbuiltin.help_tags, {})
-- end
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", opts)
vim.keymap.set("n", "<leader>F", "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>", opts)
vim.keymap.set("n", "<leader>fg", "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<cr>", opts)
vim.keymap.set("n", "<leader>fG", "<cmd>Telescope grep_string<cr>", opts)
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", opts)
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", opts)
vim.keymap.set("n", "<leader>fo", "<cmd>Telescope oldfiles<cr>", opts)
vim.keymap.set("n", "<leader>fq", "<cmd>Telescope quickfix<cr>", opts)
vim.keymap.set("n", "<leader>p", "<cmd>Telescope neoclip initial_mode=normal theme=get_cursor<cr>", opts)
vim.keymap.set("n", "<leader>fs", "<cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>", opts)
vim.keymap.set("n", "<leader>fS", "<cmd>lua require('telescope.builtin').lsp_workspace_symbols()<cr>", opts)
vim.keymap.set("n", "<leader>fd", "<cmd>Telescope lsp_definitions initial_mode=normal<cr>", opts)
vim.keymap.set("n", "<leader>ftd", "<cmd>Telescope lsp_type_definitions initial_mode=normal<cr>", opts)
vim.keymap.set("n", "<leader>fr", "<cmd>Telescope lsp_references initial_mode=normal<cr>", opts)
vim.keymap.set("n", "<leader>fi", "<cmd>Telescope lsp_implementations initial_mode=normal<cr>", opts)
vim.keymap.set("n", "<leader>fe", "<cmd>Telescope diagnostics initial_mode=normal<cr>", opts)
vim.keymap.set("n", "<leader>ftt", "<cmd>Telescope toggleterm initial_mode=normal<cr>", opts)
vim.keymap.set("n", "<leader>fpr", "<cmd>Telescope projects<cr>", opts)
-- vim.keymap.set("n", "<leader>fps", "<cmd>Telescope possession list<cr>", opts)


-- diffview
vim.keymap.set("n", "<leader>df", "<cmd>DiffviewOpen<CR>", opts)
vim.keymap.set("n", "<leader>dh", "<cmd>DiffviewFileHistory<CR>", opts)
vim.keymap.set("n", "<leader>dc", "<cmd>DiffviewClose<CR>", opts)
vim.keymap.set("n", "<leader>dr", "<cmd>DiffviewRefresh<CR>", opts)
vim.keymap.set("n", "<leader>dt", "<cmd>DiffviewToggleFiles<CR>", opts)

-- symbols-outline
vim.keymap.set("n", "<leader>o", "<cmd>SymbolsOutline<CR>", opts)

-- session_manager
vim.keymap.set("n", "<leader>fps", "<cmd>SessionManager load_session<cr>", opts)

-- bufdelete
-- vim.keymap.set("n", "<leader>bd", ":Bdelete<cr>", opts)
vim.keymap.set("n", "<leader>bd", ":bdelete<cr>", opts)

-- markdown previewer
vim.keymap.set("n", "<leader>mdp", ":MarkdownPreviewToggle<cr>", opts)

-- neogen
vim.api.nvim_set_keymap("n", "<leader>nc", "<cmd>lua require('neogen').generate({type='class'})<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>nf", "<cmd>lua require('neogen').generate({type='file'})<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>nt", "<cmd>lua require('neogen').generate({type='type'})<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>nn", "<cmd>lua require('neogen').generate()<CR>", opts)


