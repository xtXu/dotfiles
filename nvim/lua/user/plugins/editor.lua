return {

	-- NvimTree
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = {
			"nvim-tree/nvim-web-devicons"
		},
		highlights = require("catppuccin.groups.integrations.bufferline").get(),
		-- cmd = {"NvimTreeToggle", "NvimTreeFindFileToggle"},
		-- keys = {"tt", "<cmd>NvimTreeFindFileToggle<cr>", desc="NvimTree"},
		event = "VeryLazy",
		config = function()
			require("nvim-tree").setup { -- BEGIN_DEFAULT_OPTS
				-- ignore_ft_on_setup = {"alpha"},
				diagnostics = {
					enable = true,
					show_on_dirs = false,
					debounce_delay = 50,
					icons = {
						hint = "",
						info = "",
						warning = "",
						error = "",
					},
				},

				renderer = {
					group_empty = true,
					highlight_opened_files = "name",
				},

			} -- END_DEFAULT_OPTS

			local opts = { noremap = true, silent = true }
			local keymap = vim.api.nvim_set_keymap
			keymap("n", "tt", "<Cmd>NvimTreeFindFileToggle<CR>", opts)

		end,

	},

	-- fzf-lua
	{
		"ibhagwan/fzf-lua",
		dependencies = {
			"nvim-tree/nvim-web-devicons"
		},
		event = "VeryLazy",
		init = function()
			local opts = { noremap = true, silent = true }
			local keymap = vim.api.nvim_set_keymap

			keymap("n", "<leader>ff", "<cmd>lua require('fzf-lua').files()<CR>", opts)
			keymap("n", "<leader>fg", "<cmd>lua require('fzf-lua').live_grep_native()<CR>", opts)
			keymap("n", "<leader>fG", "<cmd>lua require('fzf-lua').grep()<CR>", opts)
			keymap("n", "<leader>fb", "<cmd>lua require('fzf-lua').buffers()<CR>", opts)
			keymap("n", "<leader>fh", "<cmd>lua require('fzf-lua').help_tags()<CR>", opts)
			keymap("n", "<leader>fo", "<cmd>lua require('fzf-lua').oldfiles()<CR>", opts)
			keymap("n", "<leader>fq", "<cmd>lua require('fzf-lua').quickfix()<CR>", opts)
			keymap("n", "<leader>fs", "<cmd>lua require('fzf-lua').lsp_document_symbols()<CR>", opts)
			keymap("n", "<leader>fS", "<cmd>lua require('fzf-lua').lsp_workspace_symbols()<CR>", opts)
			keymap("n", "<leader>fd", "<cmd>lua require('fzf-lua').lsp_definitions()<CR>", opts)
			keymap("n", "<leader>ftd", "<cmd>lua require('fzf-lua').lsp_typedefs()<CR>", opts)
			keymap("n", "<leader>fr", "<cmd>lua require('fzf-lua').lsp_references()<CR>", opts)
			keymap("n", "<leader>fi", "<cmd>lua require('fzf-lua').lsp_implementations()<CR>", opts)
			keymap("n", "<leader>fe", "<cmd>lua require('fzf-lua').diagnostics_document()<CR>", opts)
		end,

	},

	-- aerial
	{
		"stevearc/aerial.nvim",
		-- event = { "BufReadPre", "BufNewFile" },
		cmd = {"AerialToggle"},
		filter_kind = false,
		highlight_on_hover = true,
		config = function()
			require("aerial").setup({
				backends = { "lsp", "treesitter", "markdown", "man" },

				-- optionally use on_attach to set keymaps when aerial has attached to a buffer
				on_attach = function(bufnr)
					-- Jump forwards/backwards with '{' and '}'
					vim.keymap.set('n', '{', '<cmd>AerialPrev<CR>', {buffer = bufnr})
					vim.keymap.set('n', '}', '<cmd>AerialNext<CR>', {buffer = bufnr})
				end
			})
		end,

		init = function()
			local opts = { noremap = true, silent = true }
			local keymap = vim.api.nvim_set_keymap

			keymap("n", "<leader>a", "<cmd>AerialToggle<CR>", opts)
		end

		},

		-- symbols-outline
		{
			"simrat39/symbols-outline.nvim",
			cond = false,
			cmd = {"SymbolsOutline"},
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

			init = function()
				local opts = { noremap = true, silent = true }
				local keymap = vim.api.nvim_set_keymap
				keymap("n", "<leader>o", "<cmd>SymbolsOutline<CR>", opts)
			end

		}

}
