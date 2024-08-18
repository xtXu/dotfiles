return {
	-- inc rename
	{
		"smjonas/inc-rename.nvim",
		-- keys = { "<leader>rn" };
		lazy = true,
		config = function()
			require("inc_rename").setup()
			-- key setting in lsp handler
			-- local opts = { noremap = true, silent = true }
			-- vim.api.nvim_set_keymap("n", "<leader>rn", ":IncRename ", opts)
		end,
	},
}
