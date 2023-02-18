return {

	-- NvimTree
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = {
			"nvim-tree/nvim-web-devicons"
		},
		highlights = require("catppuccin.groups.integrations.bufferline").get(),
		cmd = {"NvimTreeToggle", "NvimTreeFindFileToggle"},
		keys = {"tt", "<cmd>NvimTreeFindFileToggle<cr>", desc="NvimTree"},
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



}
