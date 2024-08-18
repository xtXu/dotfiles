return {
	-- Noice
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		keys = {
			{
				"<a-j>",
				function()
					if not require("noice.lsp").scroll(4) then
						return "<a-j>"
					end
				end,
				mode = { "n", "i", "s" },
				silent = true,
				expr = true
			},

			{
				"<a-k>",
				function()
					if not require("noice.lsp").scroll( -4) then
						return "<a-k>"
					end
				end,
				mode = { "n", "i", "s" },
				silent = true,
				expr = true
			},
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
		end,
	},
}
