return {
	-- bufferline
	{
		"akinsho/bufferline.nvim",
		version = "*",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"nvim-tree/nvim-web-devicons"
		},
		keys = {
			{ "R", ":BufferLineCycleNext<CR>", silent = true },
			{ "E", ":BufferLineCyclePrev<CR>", silent = true },
		},
		config = function()
			require("bufferline").setup {
				-- highlights = require("catppuccin.groups.integrations.bufferline").get(),
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
					}
				},
			}
		end

	},
}
