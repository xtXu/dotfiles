return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = "VeryLazy",
	dependencies = {
		"JoosepAlviste/nvim-ts-context-commentstring",
		"nvim-treesitter/nvim-treesitter-context",
		"nvim-treesitter/nvim-treesitter-refactor",
		"nvim-treesitter/nvim-treesitter-textobjects",
		"andymass/vim-matchup",
	},

	config = function() 
		require 'nvim-treesitter.configs'.setup {
			-- A list of parser names, or "all"
			ensure_installed = { "c", "cpp", "json", "cmake", "lua",
													"vim", "regex", "bash", "markdown", "markdown_inline"},
			sync_install = true,
			auto_install = true,
			-- List of parsers to ignore installing (for "all")
			ignore_install = { "ini" },

			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},

			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = '<TAB>',
					node_incremental = '<TAB>',
					node_decremental = '<BS>',
					-- scope_incremental = '<TAB>',
				}
			},

			refactor = {
				highlight_definitions = {
					enable = false,
					-- Set to false if you have an `updatetime` of ~100.
					clear_on_cursor_move = true,
				},
				highlight_current_scope = { enable = false }
			},

			matchup = {
				enable = true,
			},

			textobjects = {
				select = {
					enable = true,

					-- Automatically jump forward to textobj, similar to targets.vim
					lookahead = true,

					keymaps = {
						-- You can use the capture groups defined in textobjects.scm
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
						["ap"] = "@parameter.outer",
						["ip"] = "@parameter.inner",
					},

					selection_modes = {
						['@parameter.outer'] = 'v', -- charwise
						['@parameter.inner'] = 'v', -- charwise
						['@function.outer'] = 'V', -- linewise
						['@function.inner'] = 'V', -- linewise
						['@class.outer'] = '<c-v>', -- blockwise
						['@class.inner'] = '<c-v>', -- blockwise
					},
					include_surrounding_whitespace = true,
				},

				lsp_interop = {
					enable = true,
					border = 'single',
					peek_definition_code = {
						["<leader>dp"] = "@function.outer",
						["<leader>dP"] = "@class.outer",
					},
				},
			},
		}

		-- folding
		vim.wo.foldmethod = 'expr'
		vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
		-- default no folding
		vim.wo.foldlevel = 99

		require("treesitter-context").setup {
			enable = true, 
			max_lines = 5,
		}

		vim.g.skip_ts_context_commentstring_module = true
		require('ts_context_commentstring').setup {
			enable_autocmd = false,
		}
	end
}
