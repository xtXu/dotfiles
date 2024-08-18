return {
	-- NvimTree
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = {
			"nvim-tree/nvim-web-devicons"
		},
		lazy = false,
		keys = {
			{ "tt", "<Cmd>NvimTreeFindFileToggle<CR>" },
		},
		-- highlights = require("catppuccin.groups.integrations.bufferline").get(),
		-- event = "VeryLazy",
		config = function()

			local function my_on_attach(bufnr)
				local api = require "nvim-tree.api"

				local function opts(desc)
					return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
				end

				-- default mappings
				api.config.mappings.default_on_attach(bufnr)

				-- custom mappings
				vim.keymap.set('n', 's', api.node.open.vertical, opts('Open: Vertical Split'))
				vim.keymap.set('n', 'S', api.node.open.horizontal, opts('Open: Horizontal Split'))
			end

			require("nvim-tree").setup { -- BEGIN_DEFAULT_OPTS
				-- ignore_ft_on_setup = {"alpha"},
				on_attach = my_on_attach,
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

				update_focused_file = {
					enable = true,
				}

			} -- END_DEFAULT_OPTS

			-- open on setup
			local function open_nvim_tree(data)
				-- buffer is a [No Name]
				local no_name = data.file == "" and vim.bo[data.buf].buftype == ""

				-- buffer is a directory
				local directory = vim.fn.isdirectory(data.file) == 1

				-- if not no_name and not directory then
				-- 	return
				-- end
				if not directory then
					return
				end

				-- change to the directory
				if directory then
					vim.cmd.cd(data.file)
				end

				-- open the tree
				require("nvim-tree.api").tree.open()
			end

			vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
		end,

		init = function()
			-- nvim-tree required
			vim.g.loaded = 1
			vim.g.loaded_netrwPlugin = 1
		end

	},
}
