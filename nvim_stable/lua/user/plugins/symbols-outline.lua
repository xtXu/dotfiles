return {
	-- symbols-outline
	{
		"simrat39/symbols-outline.nvim",
		-- enabled = false,
		cmd = { "SymbolsOutline" },
		keys = {
			{ "<leader>o", "<cmd>SymbolsOutline<CR>" }
		},
		opts = {
			keymaps = { -- These keymaps can be a string or a table for multiple keys
				-- close = {"<Esc>", "q"},
				-- goto_location = "<Cr>",
				-- focus_location = "o",
				hover_symbol = "gh",
				toggle_preview = "p",
				-- rename_symbol = "r",
				-- code_actions = "a",
				-- fold = "h",
				-- unfold = "l",
				-- fold_all = "W",
				-- unfold_all = "E",
				-- fold_reset = "R",
			},
		},

	},
}
