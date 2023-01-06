local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
	vim.notify("Plugin bufferline not found !")
  return
end

bufferline.setup {
	options = {
		show_buffer_close_icons = false,
		show_buffer_icons = true,
		color_icons = true,
		indicator = {
				icon = '▎', -- this should be omitted if indicator style is not 'icon'
				style = 'icon',
		},
		separator = "thin",
		-- numbers = "buffer_id",
		numbers = function(opts)
			return string.format('%s', opts.raise(opts.id))
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
						return buf.filename:match('%.cpp') or buf.filename:match('%.h') or buf.filename:match('%.py')
					end,
				},
				{
					name = "Docs",
					-- highlight = {undercurl = true, sp = "green"},
					auto_close = false,
					matcher = function(buf)
						return buf.filename:match('%.md') or buf.filename:match('%.txt')
					end,
					separator = { -- Optional
						style = require('bufferline.groups').separator.tab
					},
				},
				{
					name = "Config",
					-- highlight = {undercurl = true, sp = "green"},
					auto_close = false,
					matcher = function(buf)
						return buf.filename:match('%.launch') or buf.filename:match('%.yaml') or buf.filename:match('%.xml')
					end,
					-- separator = { -- Optional
					-- 	style = require('bufferline.groups').separator.tab
					-- },
				}
			}
		}
	},
}
