return {
	{
		'nvim-telescope/telescope.nvim',
		tag = '0.1.8',
		dependencies = { 'nvim-lua/plenary.nvim', { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' } },
		config = function()
			local actions = require "telescope.actions"

			require('telescope').setup {
				defaults = {
					layout_config = {
						prompt_position = 'top'
					},
					sorting_strategy = 'ascending',
					mappings = {
						i = {
							["<C-h>"] = "which_key",
							["<C-j>"] = actions.move_selection_next,
							["<C-k>"] = actions.move_selection_previous,
							["<Esc>"] = actions.close,
						}
					}
				},
				extensions = {
					fzf = {
						fuzzy = true,             -- false will only do exact matching
						override_generic_sorter = true, -- override the generic sorter
						override_file_sorter = true, -- override the file sorter
						case_mode = "smart_case", -- or "ignore_case" or "respect_case"
						-- the default case_mode is "smart_case"
					}
				}
			}
			-- To get fzf loaded and working with telescope, you need to call
			-- load_extension, somewhere after setup function:
			require('telescope').load_extension('fzf')

			local builtin = require('telescope.builtin')
			vim.keymap.set('n', '<leader>ff', builtin.find_files, {desc = "Find Files"})
			vim.keymap.set('n', '<leader>fg', builtin.grep_string, {desc = "Grep String"})
			vim.keymap.set('n', '<leader>fG', builtin.live_grep, {desc = "Live Grep"})
			vim.keymap.set('n', '<leader>gb', builtin.git_branches, {desc = "Git Branches"})
		end
	},

}
