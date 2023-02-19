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
	},

	-- markdown preview
	{
		"iamcco/markdown-preview.nvim",
		build = function() vim.fn["mkdp#util#install"]() end,
		ft = {"markdown"},
		config = function ()
			vim.g.mkdp_auto_start = 0
			vim.g.mkdp_auto_close = 1
			vim.g.mkdp_refresh_slow = 0
			vim.g.mkdp_command_for_global = 0
			vim.g.mkdp_open_to_the_world = 0
			vim.g.mkdp_open_ip = ''
			vim.g.mkdp_browser = ''
			vim.g.mkdp_echo_preview_url = 0
			vim.g.mkdp_browserfunc = ''
			vim.cmd[[
			let g:mkdp_preview_options = {
					\ 'mkit': {},
					\ 'katex': {},
					\ 'uml': {},
					\ 'maid': {},
					\ 'disable_sync_scroll': 0,
					\ 'sync_scroll_type': 'middle',
					\ 'hide_yaml_meta': 1,
					\ 'sequence_diagrams': {},
					\ 'flowchart_diagrams': {},
					\ 'content_editable': v:false,
					\ 'disable_filename': 0,
					\ 'toc': {}
					\ }
			]]
			vim.g.mkdp_markdown_css = ''
			vim.g.mkdp_highlight_css = ''
			vim.g.mkdp_port = ''
			vim.g.mkdp_page_title = '「${name}」'
			vim.g.mkdp_filetypes = {'markdown'}
			vim.g.mkdp_theme = 'light'
		end,
		init = function ()
			local opts = { noremap = true, silent = true }
			local keymap = vim.api.nvim_set_keymap
			keymap("n", "<leader>mdp", ":MarkdownPreviewToggle<cr>", opts)
		end

	}


}
