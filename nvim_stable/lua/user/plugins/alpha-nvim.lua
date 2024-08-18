return {
	-- alpha (dashboard)
	{
		"goolord/alpha-nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons"
		},
		priority = 500,
		config = function()
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
				dashboard.button("ns", "  > Settings", ":e $MYVIMRC | :cd %:p:h | split . | wincmd k | pwd<CR>"),
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
}
