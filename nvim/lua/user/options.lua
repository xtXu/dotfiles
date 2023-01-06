local options = {
  clipboard = "unnamedplus",               -- allows neovim to access the system clipboard
  hlsearch = true,                         -- highlight all matches on previous search pattern
  ignorecase = true,                       -- ignore case in search patterns
	incsearch = true,
--  mouse = "a",                             -- allow the mouse to be used in neovim
  smartcase = true,                        -- smart case
  smartindent = true,                      -- make indenting smarter again
  splitbelow = true,                       -- force all horizontal splits to go below current window
  splitright = true,                       -- force all vertical splits to go to the right of current window
  termguicolors = true,                    -- set term gui colors (most terminals support this)
  updatetime = 300,                        -- faster completion (4000ms default)
  cursorline = true,                       -- highlight the current line
  number = true,                           -- set numbered lines
  relativenumber = true,                  -- set relative numbered lines
  signcolumn = "yes",                      -- always show the sign column, otherwise it would shift the text each time
  tabstop = 2,
  shiftwidth = 2,
  autoindent = true,
  showmatch = false,
  hidden = true,
	pumheight = 30,
}

vim.opt.shortmess:append "c"

for k, v in pairs(options) do
  vim.opt[k] = v
end

-- nvim-tree required
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1


-- set .launch file as xml file

vim.cmd[[au BufNew,BufRead,BufNewFile *.launch set filetype=xml]]


-- vim.cmd "set whichwrap+=<,>,[,],h,l"
-- vim.cmd [[set iskeyword+=-]]
-- vim.cmd [[set formatoptions-=cro]] -- TODO: this doesn't seem to work
