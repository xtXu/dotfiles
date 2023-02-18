return {

	-- lualine
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"catppuccin"
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

			require("lualine").setup {
				options = {
					theme = "catppuccin"
				},

				extensions = {
					"nvim-tree",
					"quickfix",
					"man",
					-- "aerial",
					"symbols-outline",
					"toggleterm",
					"man",
					"fzf",
				},

				sections = {
					lualine_c = {
						{
							"filename",
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
						}
					},

					-- lualine_x = {"lsp_progress", "encoding", "fileformat", "filetype" },
					-- lualine_x = {lsp_client_names, "encoding", "fileformat", "filetype" },
				}
			}
		end
	},

	-- bufferline
	{
		"akinsho/bufferline.nvim",
		version = "v3.*",
		dependencies = {
			"nvim-tree/nvim-web-devicons"
		},
		config = function()
			require("bufferline").setup {
				options = {
					show_buffer_close_icons = false,
					show_buffer_icons = true,
					color_icons = true,
					indicator = {
						icon = "▎", -- this should be omitted if indicator style is not "icon"
						style = "icon",
					},
					separator = "thin",
					-- numbers = "buffer_id",
					numbers = function(opts)
						return string.format("%s", opts.raise(opts.id))
					end,
					diagnostics = "nvim_lsp",
					diagnostics_indicator = function(count, level, diagnostics_dict, context)
						local icon = level:match("error") and " " or " "
						return " " .. icon .. count
					end,
					offsets = {
						{
							filetype = "NvimTree",
							text = "File Explorer",
							highlight = "Directory",
							separator = false
						}
					},
					groups = {
						options = {
							toggle_hidden_on_enter = true
						},
						items = {
							{
								name = "Main", -- Mandatory
								-- highlight = {underline = true, sp = "blue"}, -- Optional
								priority = 1, -- determines where it will appear relative to other groups (Optional)
								matcher = function(buf) -- Mandatory
									return buf.filename:match("%.cpp") or buf.filename:match("%.h") or buf.filename:match("%.py")
								end,
							},
							{
								name = "Docs",
								-- highlight = {undercurl = true, sp = "green"},
								auto_close = false,
								matcher = function(buf)
									return buf.filename:match("%.md") or buf.filename:match("%.txt")
								end,
								separator = { -- Optional
									style = require("bufferline.groups").separator.tab
								},
							},
							{
								name = "Config",
								-- highlight = {undercurl = true, sp = "green"},
								auto_close = false,
								matcher = function(buf)
									return buf.filename:match("%.launch") or buf.filename:match("%.yaml") or buf.filename:match("%.xml")
								end,
								-- separator = { -- Optional
								-- 	style = require("bufferline.groups").separator.tab
								-- },
							}
						}
					}
				},
			}

			local opts = { noremap = true, silent = true }
			local keymap = vim.api.nvim_set_keymap

			keymap("n", "R", ":BufferLineCycleNext<CR>", opts)
			keymap("n", "E", ":BufferLineCyclePrev<CR>", opts)
		end

	},

	-- indent-blankline
	{
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("indent_blankline").setup {
				enabled = true,
				colored_indent_levels = false,
				show_current_context = true,
				show_current_context_start = true,
			}
		end
	},

	-- Noice
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		config = function()
			require("noice").setup({
				-- add any options here
				cmdline = {
					enabled = true, -- enables the Noice cmdline UI
					view = "cmdline_popup", -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
				},
				messages = {
					view = "mini",
				},

				lsp = {
					hover = {
						enabled = false,
						-- view = nil, -- when nil, use defaults from documentation
						-- ---@type NoiceViewOptions
						-- opts = {}, -- merged with defaults from documentation
					},
					signature = {
						enabled = false,
						-- auto_open = {
						-- 	enabled = true,
						-- 	trigger = true, -- Automatically show signature help when typing a trigger character from the LSP
						-- 	luasnip = true, -- Will open signature help when jumping to Luasnip insert nodes
						-- 	throttle = 50, -- Debounce lsp signature help request by 50ms
						-- },
						-- view = nil, -- when nil, use defaults from documentation
						-- ---@type NoiceViewOptions
						-- opts = {}, -- merged with defaults from documentation
					},
				},
				presets = {
					bottom_search = true,
				}
			})
		end,
	},


}
