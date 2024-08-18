return {
	--trouble
	{

		"folke/trouble.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
		keys = {
			{ "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>",              desc = "Diagnostics (Trouble)" },
			{ "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
			{ "<leader>xq", "<cmd>Trouble qflist toggle<cr>",                   desc = "Quickfix List (Trouble)" },

		},
		config = function()
			require("trouble").setup {
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
				height = 20,
				action_keys = {                -- key mappings for actions in the trouble list
					jump_close = { "<cr>", "<tab>" }, -- jump to the diagnostic or open / close folds
					jump = { "o" },              -- jump to the diagnostic and close the list
				},
			}
			-- setting in lsp
			-- keymap("n", "gd", "<cmd>TroubleToggle lsp_definitions<cr>", opts)
			-- keymap("n", "gr", "<cmd>TroubleToggle lsp_references<cr>", opts)
		end

	},
}
