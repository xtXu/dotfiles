return {

	-- nvim-possession
	{
    "gennaro-tedesco/nvim-possession",
    dependencies = {
        "ibhagwan/fzf-lua",
    },

    config = function()
			require("nvim-possession").setup ({
				autoswitch = {
					enable = true,
				}
			})
		end,

    init = function()
        local possession = require("nvim-possession")
        vim.keymap.set("n", "<leader>sl", function()
            possession.list()
        end)
        vim.keymap.set("n", "<leader>sn", function()
            possession.new()
        end)
        vim.keymap.set("n", "<leader>su", function()
            possession.update()
        end)
    end,

		-- post_hook = function()
  --       require('nvim-tree').toggle(false, true)
  --   end
	},

	-- colorizer
	{
		"norcalli/nvim-colorizer.lua",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("colorizer").setup()
		end
	},

	-- vimtex
	{
		"lervag/vimtex",
		ft = {"tex", "bib"},
		config = function()
			vim.cmd[[
			filetype plugin indent on
			syntax enable
			]]

			-- vim.g.vimtex_view_method = 'okular'
			vim.g.vimtex_view_general_viewer = 'okular'
			vim.g.tex_flavor='latex'
			-- vim.g.vimtex_compiler_latexmk_engines = {
			--     _ = '-xelatex'
			-- }
			-- vim.cmd([[let g:vimtex_view_general_options
			-- \ = '-reuse-instance -forward-search @tex @line @pdf'
			-- \ . ' -inverse-search "' . exepath(v:progpath)
			-- \ . ' --servername ' . v:servername
			-- \ . ' --remote-send \"^<C-\^>^<C-n^>'
			-- \ . ':execute ''drop '' . fnameescape(''\%f'')^<CR^>'
			-- \ . ':\%l^<CR^>:normal\! zzzv^<CR^>'
			-- \ . ':call remote_foreground('''.v:servername.''')^<CR^>^<CR^>\""']])

			-- vim.g.tex_comment_nospell = 1
			vim.g.vimtex_quickfix_mode = 0
			-- vim.g.vimtex_compiler_progname = 'nvr'
			vim.g.vimtex_view_general_options = [[--unique file:@pdf\#src:@line@tex]]
			-- vim.g.vimtex_view_general_options_latexmk = '--reuse-instance'
			--
			vim.cmd[[
			let maplocalleader=";"
			]]
		end
	}


}
