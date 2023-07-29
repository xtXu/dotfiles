return {

	-- theme catppuccin
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		enabled = false,
		config = function()
			require("catppuccin").setup({
				flavour = "mocha",
				-- color_overrides = {
				-- 	mocha = {
				-- 		base = "#000000",
				-- 		mantle = "#000000",
				-- 		crust = "#000000",
				-- 	},
				-- },
				integrations = {
					cmp = true,
					gitsigns = true,
					nvimtree = true,
					telescope = true,
					-- hop = true,
					mason = true,
					noice = true,
					native_lsp = {
						enabled = true,
						virtual_text = {
							errors = { "italic" },
							hints = { "italic" },
							warnings = { "italic" },
							information = { "italic" },
						},
						underlines = {
							errors = { "underline" },
							hints = { "underline" },
							warnings = { "underline" },
							information = { "underline" },
						},
					},
					treesitter_context = true,
					treesitter = true,
					ts_rainbow = true,
					aerial = true,
					indent_blankline = {
						enabled = true,
						colored_indent_levels = false,
					},
					-- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
				},
			})
			vim.cmd.colorscheme "catppuccin"
		end

	},

	-- theme kanagawa
	{
		"rebelot/kanagawa.nvim",
		enabled = false,
		name = "kanagawa",
		priority = 1000,
		config = function ()
			vim.cmd.colorscheme "kanagawa"
		end
	},

	-- theme material
	{
		"marko-cerovac/material.nvim",
		name = "material",
		-- enabled = false;
		priority = 1000,
		config = function ()
			require('material').setup({

				plugins = { -- Uncomment the plugins that you use to highlight them
					-- Available plugins:
					-- "dap",
					-- "dashboard",
					"gitsigns",
					-- "hop",
					"indent-blankline",
					-- "lspsaga",
					-- "mini",
					-- "neogit",
					-- "neorg",
					"nvim-cmp",
					-- "nvim-navic",
					"nvim-tree",
					"nvim-web-devicons",
					-- "sneak",
					-- "telescope",
					"trouble",
					-- "which-key",
				},
				lualine_style = "stealth", -- Lualine style ( can be 'stealth' or 'default' )

			})
			vim.cmd.colorscheme "material"
		end,
		init = function ()
			vim.g.material_style = "darker"
		end
	}

}
