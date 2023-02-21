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
				options = {
					theme = "catppuccin"
				},

				extensions = {
					"nvim-tree",
					"quickfix",
					"man",
					"aerial",
					"symbols-outline",
					"toggleterm",
					"man",
					"fzf",
				},

				sections = {
					lualine_a = {
						{ "mode", separator = { right = "" } },
					},
					lualine_b = {
						{"branch", separator = { right = "" } },
						{"diff", separator = { right = "" } },
						{"diagnostics", separator = { right = "" } },
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
						{"fileformat", separator = { left = "" } },
						{"encoding", separator = { left = "" } },
						{"filetype", separator = { left = "" } },
					},
					lualine_y = {{"progress", separator = { left = "" } }},
					lualine_z = {{"location", separator = { left = "" } }}
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
				highlights = require("catppuccin.groups.integrations.bufferline").get(),
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
				-- routes = { -- showing recording
				-- 	{
				-- 		view = "notify",
				-- 		filter = { event = "msg_showmode" },
				-- 	},
				-- },
				views = {
				  cmdline_popup = {
						border = {
							style = "none",
							padding = { 2, 3 },
						},
						filter_options = {},
						win_options = {
							winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
						},
					},
				},
				cmdline = {
					enabled = true, -- enables the Noice cmdline UI
					-- view = "cmdline_popup", -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
					view = "cmdline", -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
				},
				messages = {
					view = "mini",
				},

				lsp = {
					override = {
						-- override the default lsp markdown formatter with Noice
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						-- override the lsp markdown formatter with Noice
						["vim.lsp.util.stylize_markdown"] = true,
						-- override cmp documentation with Noice (needs the other options to work)
						-- ["cmp.entry.get_documentation"] = true,
					},
					hover = {
						enabled = true,
						view = nil, -- when nil, use defaults from documentation
						---@type NoiceViewOptions
						opts = {}, -- merged with defaults from documentation
					},
					signature = {
						enabled = true,
						auto_open = {
							enabled = true,
							trigger = true, -- Automatically show signature help when typing a trigger character from the LSP
							luasnip = true, -- Will open signature help when jumping to Luasnip insert nodes
							throttle = 50, -- Debounce lsp signature help request by 50ms
						},
						view = nil, -- when nil, use defaults from documentation
						---@type NoiceViewOptions
						opts = {}, -- merged with defaults from documentation
					},
					documentation = {
						view = "hover",
						---@type NoiceViewOptions
						opts = {
							lang = "markdown",
							replace = true,
							render = "plain",
							format = { "{message}" },
							win_options = { concealcursor = "n", conceallevel = 3 },
						},
					},
				},
				presets = {
					bottom_search = true,
				}
			})

			vim.keymap.set({"n", "i", "s"}, "<c-j>", function()
				if not require("noice.lsp").scroll(4) then
					return "<c-f>"
				end
			end, { silent = true, expr = true })

			vim.keymap.set({"n", "i", "s"}, "<c-k>", function()
				if not require("noice.lsp").scroll(-4) then
					return "<c-b>"
				end
			end, { silent = true, expr = true })

		end,
	},

	-- alpha (dashboard)
	{
		"goolord/alpha-nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons"
		},
		config = function ()
			local alpha = require("alpha")
			local dashboard = require("alpha.themes.dashboard")

			local function footer()
				-- local total_plugins = #vim.tbl_keys(packer_plugins)
				local datetime = os.date(" %d-%m-%Y   %H:%M:%S")
				local version = vim.version()
				local nvim_version_info = "   v" .. version.major .. "." .. version.minor .. "." .. version.patch

				-- return datetime .. "   " .. total_plugins .. " plugins" .. nvim_version_info
				return datetime .. nvim_version_info
			end

			dashboard.opts.layout = {
				{ type = "padding", val = vim.fn.max { 2, vim.fn.floor(vim.fn.winheight(0) * 0.2) } },
				dashboard.section.header,
				dashboard.section.buttons,
				{ type = "padding", val = 2 },
				dashboard.section.footer,
			}

			dashboard.section.header.val = {
				[[                               __                ]],
				[[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
				[[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
				[[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
				[[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
				[[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
				[[                                                 ]],
				[[                                                 ]],
				[[                                                 ]],
			}

			dashboard.section.buttons.val = {
				dashboard.button("e", "  > New file", ":ene <BAR> startinsert <CR>"),
				dashboard.button("f", "  > Find file", ":cd $HOME | FzfLua files<CR>"),
				dashboard.button("o", "  > Recent", ":FzfLua oldfiles<CR>"),
				dashboard.button("s", "  > Session", ":lua require('nvim-possession').list()<CR>"),
				dashboard.button("u", "全 > PluginUpdate", ":Lazy sync<CR>"),
				dashboard.button("ns","  > Settings", ":e $MYVIMRC | :cd %:p:h | split . | wincmd k | pwd<CR>"),
				dashboard.button("q", "  > Quit NVIM", ":qa<CR>"),
			}
			dashboard.section.footer.val = footer()
			dashboard.section.footer.opts.hl = "Constant"
			dashboard.section.header.opts.hl = "AlphaHeader"


			alpha.setup(dashboard.config)

			-- Disable folding on alpha buffer
			vim.cmd([[
					autocmd FileType alpha setlocal nofoldenable
			]])
		end
	},

	-- winbar
	{
		"utilyre/barbecue.nvim",
		name = "barbecue",
		version = "*",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"SmiteshP/nvim-navic",
			"nvim-tree/nvim-web-devicons", -- optional dependency
		},

		config = function ()
			require("barbecue").setup({
				create_autocmd = false, -- prevent barbecue from updating itself automatically
			})

			vim.api.nvim_create_autocmd({
				"WinScrolled", -- or WinResized on NVIM-v0.9 and higher
				"BufWinEnter",
				"CursorHold",
				"InsertLeave",

				-- include these if you have set `show_modified` to `true`
				"BufWritePost",
				"TextChanged",
				"TextChangedI",
			}, {
				group = vim.api.nvim_create_augroup("barbecue.updater", {}),
				callback = function()
					require("barbecue.ui").update()
				end,
			})
		end
	}


}
