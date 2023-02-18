return {
()
	-- Comment
	{
    "numToStr/Comment.nvim",
		keys = {
			"gcc", "gbc", "gco", "gcO", "gcA",
			{"gc", "gb", mode="v"},
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

	-- surround
	{
		"kylechui/nvim-surround",
		version = "*",
		config = function()
        require("nvim-surround").setup({
            -- Configuration here, or leave empty to use defaults
        })
    end
	},


	-- hop
	{
		"phaazon/hop.nvim",
		version = 'v2.*', -- optional but strongly recommended
		config = function()
			-- you can configure Hop the way you like here; see :h hop-config
			require'hop'.setup { 
				jump_on_sole_occurrence = true
			}
			
			local opts = { noremap = true, silent = true }

			vim.api.nvim_set_keymap('', 'f', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>", {})
			vim.api.nvim_set_keymap('', 'F', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>", {})
			vim.api.nvim_set_keymap('', 't', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })<cr>", {})
			vim.api.nvim_set_keymap('', 'T', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })<cr>", {})
			vim.api.nvim_set_keymap('', '<leader>s', "<cmd>lua require'hop'.hint_char2()<cr>", {})
			vim.api.nvim_set_keymap('', '<leader>/', "<cmd>lua require'hop'.hint_patterns()<cr>", {})
			vim.api.nvim_set_keymap('', '<leader><leader>l', "<cmd>lua require'hop'.hint_lines()<cr>", {})
			vim.api.nvim_set_keymap('', '<leader><leader>j', "<cmd>lua require'hop'.hint_lines({direction = require'hop.hint'.HintDirection.AFTER_CURSOR})<cr>", {})
			vim.api.nvim_set_keymap('', '<leader><leader>k', "<cmd>lua require'hop'.hint_lines({direction = require'hop.hint'.HintDirection.BEFORE_CURSOR})<cr>", {})


			vim.api.nvim_del_keymap('s', 'f')
			vim.api.nvim_del_keymap('s', 'F')
			vim.api.nvim_del_keymap('s', 't')
			vim.api.nvim_del_keymap('s', 'T')

		end

	},

	
	-- autopairs
	{
		"windwp/nvim-autopairs",
		keys = {
			{"\"",mode="i"},
			{"\'",mode="i"},
			{"(",mode="i"},
			{"{",mode="i"},
			{"[",mode="i"},
		},
		config = function()
			require("nvim-autopairs").setup {
				enable_moveright = true,
				check_ts = true
			}
		end
	},

}
