return {
	-- lualine
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			-- "catppuccin"
		},
		config = function()
			local function lsp_client_names()
				local msg = "No Active Lsp"
				local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
				local clients = vim.lsp.get_active_clients()
				if next(clients) == nil then
					return msg
				end
				for _, client in ipairs(clients) do
					local filetypes = client.config.filetypes
					if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
						return client.name
					end
				end
				return msg
			end

			local function noice_record()
				local status, noice = pcall(require, "noice")
				if status then
					return noice.api.statusline.mode.get()
				end
				return ""
			end

			local function has_noice()
				local status, noice = pcall(require, "noice")
				if status and noice.api.statusline.mode.has() then
					return true
				end
				return false
			end

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
						{
							lsp_client_names,
							icon = " LSP:",
							-- color = { fg = "#ffffff", gui = "bold" },
							color = { fg = "#008080", gui = "bold" },
							separator = { right = "" },
						},
						{
							-- require("noice").api.statusline.mode.get,
							-- cond = require("noice").api.statusline.mode.has,
							-- color = { fg = "#ff9e64" },
							noice_record,
							cond = has_noice,
							color = { fg = "#ff9e64" },
							separator = { right = "" },
						}
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
