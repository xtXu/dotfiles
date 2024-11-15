return {

	-- theme one dark pro
	-- {
	-- 	"olimorris/onedarkpro.nvim",
	-- 	lazy = false,
	-- 	priority = 1000, -- Ensure it loads first
	-- 	config = function ()
	-- 		vim.cmd("colorscheme onedark")
	-- 	end,
	-- },

	-- theme gruvbox material
	{
		'f4z3r/gruvbox-material.nvim',
		name = 'gruvbox-material',
		lazy = false,
		priority = 1000,
		opts = {},
		config = function ()
				require('gruvbox-material').setup({
					italics = false,             -- enable italics in general
					contrast = "medium",        -- set contrast, can be any of "hard", "medium", "soft"
					comments = {
						italics = true,           -- enable italic comments
					},
					background = {
						transparent = true,      -- set the background to transparent
					},
				})
		end,
	}
}
