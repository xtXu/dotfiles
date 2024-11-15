return {
	{
		"windwp/nvim-autopairs",
		keys = {
			{ "\"", mode = "i" },
			{ "\'", mode = "i" },
			{ "(",  mode = "i" },
			{ "{",  mode = "i" },
			{ "[",  mode = "i" },
		},
		config = function()
			require("nvim-autopairs").setup {
				enable_moveright = true,
				check_ts = true
			}
		end
	},
}
