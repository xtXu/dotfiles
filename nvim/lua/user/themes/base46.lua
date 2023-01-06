-- vim.g.nvchad_theme =  'onedark'
vim.g.nvchad_theme =  'tokyonight'
-- vim.g.nvchad_theme =  'tokyodark'
require("base46").load_theme()
require("base46").load_highlight "syntax"
require("base46").load_highlight "treesitter"
require("base46").load_highlight "lsp"
require("base46").load_highlight "blankline"
-- require("base46").load_highlight "bufferline"
require("base46").load_highlight "nvimtree"
require("base46").load_highlight "git"
require("base46").load_highlight "cmp"
require("base46").load_highlight "mason"
require("base46").load_highlight "telescope"
require("base46").load_highlight "alpha"
