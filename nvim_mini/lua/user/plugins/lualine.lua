return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			-- "catppuccin"
		},
		config = function()

			require("lualine").setup {
				-- options = {
				-- 	theme = "catppuccin"
				-- },

				extensions = {
					"nvim-tree",
					"quickfix",
					"man",
					"aerial",
					"symbols-outline",
					"toggleterm",
					"man",
					"fzf",
					"neo-tree",
				},

				sections = {
					lualine_a = {
						{ "mode", separator = { right = "" } },
					},
					lualine_b = {
						{ "branch",      separator = { right = "" } },
						{ "diff",        separator = { right = "" } },
						{ "diagnostics", separator = { right = "" } },
					},
					lualine_c = {
						{
							"filename",
							separator = { right = "" },
							file_status = true, -- Displays file status (readonly status, modified status)
							newfile_status = false, -- Display new file status (new file means no write after created)
							path = 1, -- 0: Just the filename
							-- 1: Relative path
							-- 2: Absolute path
							-- 3: Absolute path, with tilde as the home directory

							shorting_target = 40, -- Shortens path to leave 40 spaces in the window
							-- for other components. (terrible name, any suggestions?)
							symbols = {
								modified = "[+]", -- Text to show when the file is modified.
								readonly = "[-]", -- Text to show when the file is non-modifiable or readonly.
								unnamed = "[No Name]", -- Text to show for unnamed buffers.
								newfile = "[New]", -- Text to show for new created file before first writting
							}
						},
					},
					lualine_x = {
						{ "fileformat", separator = { left = "" } },
						{ "encoding",   separator = { left = "" } },
						{ "filetype",   separator = { left = "" } },
					},
					lualine_y = { { "progress", separator = { left = "" } } },
					lualine_z = { { "location", separator = { left = "" } } }
				}
			}
		end
	},
}
