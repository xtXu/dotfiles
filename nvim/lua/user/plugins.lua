local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
		vim.cmd [[packadd packer.nvim]]
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

-- If you already have the packer and the bootstrapping isn't used,
-- If you use the packer first time and found the packer isn't loaded
-- use this command
-- vim.cmd [[packadd packer.nvim]]

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init {
	display = {
		open_fn = function()
			return require("packer.util").float { border = "rounded" }
		end,
	},
}

return require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'
	-- My plugins here

	-- theme
	use "xtXu/base46"
	use 'navarasu/onedark.nvim'

	-- dependencies
	use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins
	use "nvim-tree/nvim-web-devicons"
	use "norcalli/nvim-colorizer.lua"

	-- UI
	use "nvim-tree/nvim-tree.lua"
	use "nvim-lualine/lualine.nvim"
	use "arkav/lualine-lsp-progress"
	use { 'akinsho/bufferline.nvim', tag = "v2.*" }
	use "goolord/alpha-nvim"
	use "stevearc/dressing.nvim"


	-- feature
	use "numToStr/Comment.nvim"
	use "tpope/vim-surround"
	use "tpope/vim-repeat"
	use { 'phaazon/hop.nvim', branch = 'v2' }
	use "lukas-reineke/indent-blankline.nvim"
	use "windwp/nvim-autopairs"
	use "andymass/vim-matchup"
	use "ahmedkhalf/project.nvim"
	use { "Shatur/neovim-session-manager", commit="4ce4d975313c73c3aa1410f2c918ce6fce900f01" }
	use "jedrzejboczar/possession.nvim"
	use "simrat39/symbols-outline.nvim"
	-- use "famiu/bufdelete.nvim"
	use "danymat/neogen"

	-- treesitter
	use {
		'nvim-treesitter/nvim-treesitter',
		commit = 'e53950f646b0c11624280ee7c4eff97a9e0904f1',
		run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
	}
	use "JoosepAlviste/nvim-ts-context-commentstring"
	use 'nvim-treesitter/nvim-treesitter-context'
	use "nvim-treesitter/nvim-treesitter-refactor"
	use "p00f/nvim-ts-rainbow"
	use "nvim-treesitter/playground"
	use "nvim-treesitter/nvim-treesitter-textobjects"

	-- telescope
	use { 'nvim-telescope/telescope.nvim', tag = '0.1.0' }
	use { 'nvim-telescope/telescope-fzf-native.nvim',
		run = 'cmake -S . -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
	use "nvim-telescope/telescope-live-grep-args.nvim"
	use "AckslD/nvim-neoclip.lua"
	use "da-moon/telescope-toggleterm.nvim"
	use "nvim-telescope/telescope-ui-select.nvim"
	-- use "nvim-telescope/telescope-project.nvim"

	-- toggleterm
	use { "akinsho/toggleterm.nvim", tag = 'v2.*' }

	-- git
	use "lewis6991/gitsigns.nvim"
	use "sindrets/diffview.nvim"

	-- cmp
	use "hrsh7th/nvim-cmp" -- The completion plugin
	use "hrsh7th/cmp-nvim-lsp" -- lsp completion
	use "hrsh7th/cmp-nvim-lua" -- neovim lua api completion
	use "hrsh7th/cmp-buffer" -- buffer completions
	use "hrsh7th/cmp-path" -- path completions
	use "hrsh7th/cmp-cmdline" -- cmdline completions
	use "saadparwaiz1/cmp_luasnip" -- snippet completions
	use "hrsh7th/cmp-nvim-lsp-document-symbol" -- cmd line symbol source
	use "hrsh7th/cmp-nvim-lsp-signature-help"
	use "ray-x/lsp_signature.nvim"
	use "kdheepak/cmp-latex-symbols"

	-- snip engine & snip source
	use { "L3MON4D3/LuaSnip", tag = "v1.*" }
	-- use "L3MON4D3/LuaSnip"
	use "rafamadriz/friendly-snippets"

	-- lsp
	use "williamboman/mason.nvim"
	use "williamboman/mason-lspconfig.nvim"
	use "neovim/nvim-lspconfig"
	use "p00f/clangd_extensions.nvim"

	-- latex
	use "lervag/vimtex"

	-- markdown
	use({
		"iamcco/markdown-preview.nvim",
		run = function() vim.fn["mkdp#util#install"]() end,
	})
	use 'ekickx/clipboard-image.nvim'

	--use {
	--  'numToStr/Comment.nvim',
	--  config = function()
	--      require('Comment').setup()
	--  end
	--}

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_bootstrap then
		require('packer').sync()
	end
end)
