return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = "VeryLazy",
	dependencies = {
		"JoosepAlviste/nvim-ts-context-commentstring",
		"nvim-treesitter/nvim-treesitter-context",
		"nvim-treesitter/nvim-treesitter-refactor",
		"nvim-treesitter/nvim-treesitter-textobjects",
	},

	config = function() 
		require 'nvim-treesitter.configs'.setup {
			-- A list of parser names, or "all"
			ensure_installed = { "c", "cpp", "json", "cmake", "lua",
													"vim", "regex", "bash", "markdown", "markdown_inline"},
			-- Install parsers synchronously (only applied to `ensure_installed`)
			sync_install = false,
			-- Automatically install missing parsers when entering buffer
			auto_install = true,

			-- List of parsers to ignore installing (for "all")
			ignore_install = { "ini" },

			highlight = {
				-- `false` will disable the whole extension
				enable = true,

				-- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
				-- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
				-- the name of the parser)
				-- list of language that will be disabled
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
						-- you can optionally set descriptions to the mappings (used in the desc parameter of nvim_buf_set_keymap
						["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
						["ap"] = "@parameter.outer",
						["ip"] = "@parameter.inner",
					},
					-- You can choose the select mode (default is charwise 'v')
					--
					-- Can also be a function which gets passed a table with the keys
					-- * query_string: eg '@function.inner'
					-- * method: eg 'v' or 'o'
					-- and should return the mode ('v', 'V', or '<c-v>') or a table
					-- mapping query_strings to modes.
					selection_modes = {
						['@parameter.outer'] = 'v', -- charwise
						['@parameter.inner'] = 'v', -- charwise
						['@function.outer'] = 'V', -- linewise
						['@function.inner'] = 'V', -- linewise
						['@class.outer'] = '<c-v>', -- blockwise
						['@class.inner'] = '<c-v>', -- blockwise
					},
					-- If you set this to `true` (default is `false`) then any textobject is
					-- extended to include preceding xor succeeding whitespace. Succeeding
					-- whitespace has priority in order to act similarly to eg the built-in
					-- `ap`.
					--
					-- Can also be a function which gets passed a table with the keys
					-- * query_string: eg '@function.inner'
					-- * selection_mode: eg 'v'
					-- and should return true of false
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

		-- Enable folding
		vim.wo.foldmethod = 'expr'
		vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
		-- Default not folding
		vim.wo.foldlevel = 99

		require("treesitter-context").setup {
			enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
		}
	end
}
