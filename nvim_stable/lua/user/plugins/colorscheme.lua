return {
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
