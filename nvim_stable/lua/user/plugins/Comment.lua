return {
	-- Comment
	{
		"numToStr/Comment.nvim",
		keys = {
			"gcc", "gbc", "gco", "gcO", "gcA",
			{ "gc", "gb", mode = "v" },
		},
		dependencies = {
			"JoosepAlviste/nvim-ts-context-commentstring",
		},
		config = function()
			require('Comment').setup {
				pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
			}
		end
	},
}
