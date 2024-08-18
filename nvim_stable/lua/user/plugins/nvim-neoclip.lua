return {
	-- neoclip
	{
		"AckslD/nvim-neoclip.lua",
		event = { "BufReadPre", "BufNewFile" },
		keys = {
			-- { "<leader>p", "<cmd>lua require('neoclip.telescope')()<cr>", desc="Neoclip" }
			{ "<leader>p", "<cmd>Telescope neoclip<cr>", desc="Neoclip" }
		},
		config = function()
			local function is_whitespace(line)
				return vim.fn.match(line, [[^\s*$]]) ~= -1
			end

			local function all(tbl, check)
				for _, entry in ipairs(tbl) do
					if not check(entry) then
						return false
					end
				end
				return true
			end

			require("neoclip").setup({
				default_register = '+',
				preview = false,
				keys = {
					telescope = {
						i = {
							-- select = 'default',
							-- paste = 'ctrl-p',
							paste = '<cr>',
							paste_behind = 'ctrl-P',
							custom = {},
						},
						n = {
							paste = '<cr>',
							paste_behind = 'ctrl-P',
							custom = {},
						}
					},
				},
				filter = function(data)
					return not all(data.event.regcontents, is_whitespace)
				end,
			})
		end,

	},

}
