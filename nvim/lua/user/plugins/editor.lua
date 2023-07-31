return {

	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		cmd = "Neotree",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
		keys = {
			-- {
			-- 	"<leader>fe",
			-- 	function()
			-- 		require("neo-tree.command").execute({ toggle = true, dir = require("lazyvim.util").get_root() })
			-- 	end,
			-- 	desc = "Explorer NeoTree (root dir)",
			-- },
			{
				"tt",
				function()
					require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
				end,
				desc = "Explorer NeoTree (cwd)",
			},
		},
		deactivate = function()
			vim.cmd([[Neotree close]])
		end,
		init = function()
			if vim.fn.argc() == 1 then
				local stat = vim.loop.fs_stat(vim.fn.argv(0))
				if stat and stat.type == "directory" then
					require("neo-tree")
				end
			end
		end,
		opts = {
			sources = { "filesystem", "buffers", "git_status", "document_symbols" },
			open_files_do_not_replace_types = { "terminal", "Trouble", "qf", "Outline" },
			filesystem = {
				bind_to_cwd = false,
				follow_current_file = { enabled = true },
				use_libuv_file_watcher = true,
			},
			window = {
				width = 30,
				mappings = {
					["<space>"] = "none",
					["t"] = "none",
					["o"] = "open",
				},
			},
			default_component_configs = {
				indent = {
					with_markers = false,
				},
			},
		},
		config = function(_, opts)
			require("neo-tree").setup(opts)
			vim.api.nvim_create_autocmd("TermClose", {
				pattern = "*lazygit",
				callback = function()
					if package.loaded["neo-tree.sources.git_status"] then
						require("neo-tree.sources.git_status").refresh()
					end
				end,
			})
		end,
	},

	-- NvimTree
	-- {
	-- 	"nvim-tree/nvim-tree.lua",
	-- 	dependencies = {
	-- 		"nvim-tree/nvim-web-devicons"
	-- 	},
	-- 	lazy = false,
	-- 	keys = {
	-- 		{ "tt", "<Cmd>NvimTreeFindFileToggle<CR>" },
	-- 	},
	-- 	-- highlights = require("catppuccin.groups.integrations.bufferline").get(),
	-- 	-- event = "VeryLazy",
	-- 	config = function()
	-- 		require("nvim-tree").setup { -- BEGIN_DEFAULT_OPTS
	-- 			-- ignore_ft_on_setup = {"alpha"},
	-- 			diagnostics = {
	-- 				enable = true,
	-- 				show_on_dirs = false,
	-- 				debounce_delay = 50,
	-- 				icons = {
	-- 					hint = "",
	-- 					info = "",
	-- 					warning = "",
	-- 					error = "",
	-- 				},
	-- 			},
	--
	-- 			renderer = {
	-- 				group_empty = true,
	-- 				highlight_opened_files = "name",
	-- 			},
	--
	-- 			update_focused_file = {
	-- 				enable = true,
	-- 			}
	--
	-- 		} -- END_DEFAULT_OPTS
	--
	-- 		-- open on setup
	-- 		local function open_nvim_tree(data)
	-- 			-- buffer is a [No Name]
	-- 			local no_name = data.file == "" and vim.bo[data.buf].buftype == ""
	--
	-- 			-- buffer is a directory
	-- 			local directory = vim.fn.isdirectory(data.file) == 1
	--
	-- 			-- if not no_name and not directory then
	-- 			-- 	return
	-- 			-- end
	-- 			if not directory then
	-- 				return
	-- 			end
	--
	-- 			-- change to the directory
	-- 			if directory then
	-- 				vim.cmd.cd(data.file)
	-- 			end
	--
	-- 			-- open the tree
	-- 			require("nvim-tree.api").tree.open()
	-- 		end
	--
	-- 		vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
	-- 	end,
	--
	-- 	init = function()
	-- 		-- nvim-tree required
	-- 		vim.g.loaded = 1
	-- 		vim.g.loaded_netrwPlugin = 1
	-- 	end
	--
	-- },

	-- fzf-lua
	{
		"ibhagwan/fzf-lua",
		dependencies = {
			"nvim-tree/nvim-web-devicons"
		},
		keys = {
			{ "<leader>ff",
				"<cmd>lua require('fzf-lua').files({cmd = 'fd --type f --exclude build --exclude logs --exclude devel'})<CR>" },
			{ "<leader>fg",  "<cmd>lua require('fzf-lua').live_grep_native()<CR>" },
			{ "<leader>fG",  "<cmd>lua require('fzf-lua').grep()<CR>" },
			{ "<leader>fb",  "<cmd>lua require('fzf-lua').buffers()<CR>" },
			{ "<leader>fh",  "<cmd>lua require('fzf-lua').help_tags()<CR>" },
			{ "<leader>fo",  "<cmd>lua require('fzf-lua').oldfiles()<CR>" },
			{ "<leader>fq",  "<cmd>lua require('fzf-lua').quickfix()<CR>" },
			{ "<leader>fs",  "<cmd>lua require('fzf-lua').lsp_document_symbols()<CR>" },
			{ "<leader>fS",  "<cmd>lua require('fzf-lua').lsp_workspace_symbols()<CR>" },
			{ "<leader>fd",  "<cmd>lua require('fzf-lua').lsp_definitions()<CR>" },
			{ "<leader>ftd", "<cmd>lua require('fzf-lua').lsp_typedefs()<CR>" },
			{ "<leader>fr",  "<cmd>lua require('fzf-lua').lsp_references()<CR>" },
			{ "<leader>fi",  "<cmd>lua require('fzf-lua').lsp_implementations()<CR>" },
			{ "<leader>fe",  "<cmd>lua require('fzf-lua').diagnostics_document()<CR>" },
			{ "<leader>fE",  "<cmd>lua require('fzf-lua').diagnostics_workspace()<CR>" },
		},
		config = function()
			require("fzf-lua").setup({
				files = {
					fd_opts = "--color=never --type f --hidden --exclude .git",
				},
			})
		end,
		init = function()
			-- setting in lsp
			-- keymap(bufnr, "n", "gd", "<cmd>lua require('fzf-lua').lsp_definitions({ jump_to_single_result = true })<CR>", opts)
			-- keymap(bufnr, "n", "gr", "<cmd>lua require('fzf-lua').lsp_references({ jump_to_single_result = true })<CR>", opts)
			-- keymap(bufnr, "n", "gD", "<cmd>lua require('fzf-lua').lsp_declarations()<CR>", opts)
			-- keymap(bufnr, "n", "gi", "<cmd>lua require('fzf-lua').lsp_implementations()<CR>", opts)
		end,

	},

	-- aerial
	{
		"stevearc/aerial.nvim",
		-- event = { "BufReadPre", "BufNewFile" },
		enabled = false,
		cmd = { "AerialToggle" },
		keys = {
			{ "<leader>a", "<cmd>AerialToggle<CR>" }
		},
		filter_kind = false,
		highlight_on_hover = true,
		config = function()
			require("aerial").setup({
				backends = { "lsp", "treesitter", "markdown", "man" },
				-- optionally use on_attach to set keymaps when aerial has attached to a buffer
				on_attach = function(bufnr)
					-- Jump forwards/backwards with '{' and '}'
					vim.keymap.set('n', '{', '<cmd>AerialPrev<CR>', { buffer = bufnr })
					vim.keymap.set('n', '}', '<cmd>AerialNext<CR>', { buffer = bufnr })
				end
			})
		end,
	},

	-- symbols-outline
	{
		"simrat39/symbols-outline.nvim",
		-- enabled = false,
		cmd = { "SymbolsOutline" },
		keys = {
			{ "<leader>o", "<cmd>SymbolsOutline<CR>" }
		},
		opts = {
			keymaps = { -- These keymaps can be a string or a table for multiple keys
				-- close = {"<Esc>", "q"},
				-- goto_location = "<Cr>",
				-- focus_location = "o",
				hover_symbol = "gh",
				toggle_preview = "p",
				-- rename_symbol = "r",
				-- code_actions = "a",
				-- fold = "h",
				-- unfold = "l",
				-- fold_all = "W",
				-- unfold_all = "E",
				-- fold_reset = "R",
			},
		},

	},

	-- toggleterm
	{
		"akinsho/toggleterm.nvim",
		keys = {
			{ "<c-\\>" },
			{ "<leader>t", "<Cmd>exe v:count1 . 'ToggleTerm direction=float'<CR>" }
		},

		config = function()
			require("toggleterm").setup {
				open_mapping = [[<c-\>]],
				float_opts = {
					border = 'curved',
					width = function(term)
						return math.floor(0.6 * vim.o.columns)
					end,
					height = function(term)
						return math.floor(0.7 * vim.o.lines)
					end,
				},
			}

			function _G.set_terminal_keymaps()
				local opts = { buffer = 0 }
				vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
				vim.keymap.set('t', 'kj', [[<C-\><C-n>]], opts)
				vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
				vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
				vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
				vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
			end

			-- if you only want these mappings for toggle term use term://*toggleterm#* instead
			vim.cmd('autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()')
			-- vim.keymap.set('n', '<leader>t', [[<Cmd>ToggleTerm direction=float<CR>]], opts)

			-- vim.cmd('noremap <silent><leader>t <Cmd>exe v:count1 . "ToggleTerm direction=float"<CR>')
		end

	},

	-- gitsigns
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			signs = {
				add = { text = '▎' },
				change = { text = '░' },
				delete = { text = '▏' },
				topdelete = { text = '▔' },
				changedelete = { text = '▒' },
			},

			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns

				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				-- Navigation
				map('n', '<leader>hj', function()
					if vim.wo.diff then return ']c' end
					vim.schedule(function() gs.next_hunk() end)
					return '<Ignore>'
				end, { expr = true })

				map('n', '<leader>hk', function()
					if vim.wo.diff then return '[c' end
					vim.schedule(function() gs.prev_hunk() end)
					return '<Ignore>'
				end, { expr = true })

				-- Actions
				map({ 'n', 'v' }, '<leader>hs', ':Gitsigns stage_hunk<CR>')
				map({ 'n', 'v' }, '<leader>hr', ':Gitsigns reset_hunk<CR>')
				map('n', '<leader>hS', gs.stage_buffer)
				map('n', '<leader>hu', gs.undo_stage_hunk)
				map('n', '<leader>hR', gs.reset_buffer)
				map('n', '<leader>hp', gs.preview_hunk)
				map('n', '<leader>hb', function() gs.blame_line { full = true } end)
				-- map('n', '<leader>tb', gs.toggle_current_line_blame)
				map('n', '<leader>hd', gs.diffthis)
				map('n', '<leader>hD', function() gs.diffthis('~') end)
				-- map('n', '<leader>td', gs.toggle_deleted)

				-- Text object
				map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
			end
		}

	},

	-- diffview
	{

		"sindrets/diffview.nvim",
		-- event = "VeryLazy",
		cmd = { "DiffViewOpen", "DiffviewFileHistory" },
		dependencies = {
			"nvim-lua/plenary.nvim"
		},
		keys = {
			{ "<leader>df", ":DiffviewOpen<cr>" },
			{ "<leader>dh", ":DiffviewFileHistory<cr>" },
			{ "<leader>dc", ":DiffviewClose<cr>" },
			{ "<leader>dr", ":DiffviewRefresh<cr>" },
			{ "<leader>dt", ":DiffviewToggleFiles<cr>" },

		},
		config = function()
			local diffview = require("diffview")
			local actions = require("diffview.actions")

			diffview.setup({
				keymaps = {
					disable_defaults = false, -- Disable the default keymaps
					view = {
						-- The `view` bindings are active in the diff buffers, only when the current
						-- tabpage is a Diffview.
						["<tab>"]      = actions.select_next_entry, -- Open the diff for the next file
						["<s-tab>"]    = actions.select_prev_entry, -- Open the diff for the previous file
						["gf"]         = actions.goto_file, -- Open the file in a new split in the previous tabpage
						["<C-w><C-f>"] = actions.goto_file_split, -- Open the file in a new split
						["<C-w>gf"]    = actions.goto_file_tab, -- Open the file in a new tabpage
						["<leader>e"]  = actions.focus_files, -- Bring focus to the file panel
						["<leader>b"]  = actions.toggle_files, -- Toggle the file panel.
						["g<C-x>"]     = actions.cycle_layout, -- Cycle through available layouts.
						["[x"]         = actions.prev_conflict, -- In the merge_tool: jump to the previous conflict
						["]x"]         = actions.next_conflict, -- In the merge_tool: jump to the next conflict
						["<leader>co"] = actions.conflict_choose("ours"), -- Choose the OURS version of a conflict
						["<leader>ct"] = actions.conflict_choose("theirs"), -- Choose the THEIRS version of a conflict
						["<leader>cb"] = actions.conflict_choose("base"), -- Choose the BASE version of a conflict
						["<leader>ca"] = actions.conflict_choose("all"), -- Choose all the versions of a conflict
						["dx"]         = actions.conflict_choose("none"), -- Delete the conflict region
					},
					diff1 = { --[[ Mappings in single window diff layouts ]] },
					diff2 = { --[[ Mappings in 2-way diff layouts ]] },
					diff3 = {
						-- Mappings in 3-way diff layouts
						{ { "n", "x" }, "2do", actions.diffget("ours") }, -- Obtain the diff hunk from the OURS version of the file
						{ { "n", "x" }, "3do", actions.diffget("theirs") }, -- Obtain the diff hunk from the THEIRS version of the file
					},
					diff4 = {
						-- Mappings in 4-way diff layouts
						{ { "n", "x" }, "1do", actions.diffget("base") }, -- Obtain the diff hunk from the BASE version of the file
						{ { "n", "x" }, "2do", actions.diffget("ours") }, -- Obtain the diff hunk from the OURS version of the file
						{ { "n", "x" }, "3do", actions.diffget("theirs") }, -- Obtain the diff hunk from the THEIRS version of the file
					},
					file_panel = {
						["j"]             = actions.next_entry, -- Bring the cursor to the next file entry
						["<down>"]        = actions.next_entry,
						["k"]             = actions.prev_entry, -- Bring the cursor to the previous file entry.
						["<up>"]          = actions.prev_entry,
						["<cr>"]          = actions.select_entry, -- Open the diff for the selected entry.
						["o"]             = actions.select_entry,
						["<2-LeftMouse>"] = actions.select_entry,
						["-"]             = actions.toggle_stage_entry, -- Stage / unstage the selected entry.
						["S"]             = actions.stage_all, -- Stage all entries.
						["U"]             = actions.unstage_all, -- Unstage all entries.
						["X"]             = actions.restore_entry, -- Restore entry to the state on the left side.
						["L"]             = actions.open_commit_log, -- Open the commit log panel.
						["<c-b>"]         = actions.scroll_view( -0.25), -- Scroll the view up
						["<c-f>"]         = actions.scroll_view(0.25), -- Scroll the view down
						["<tab>"]         = actions.select_next_entry,
						["<s-tab>"]       = actions.select_prev_entry,
						["gf"]            = actions.goto_file,
						["<C-w><C-f>"]    = actions.goto_file_split,
						["<C-w>gf"]       = actions.goto_file_tab,
						["i"]             = actions.listing_style, -- Toggle between 'list' and 'tree' views
						["f"]             = actions.toggle_flatten_dirs, -- Flatten empty subdirectories in tree listing style.
						["R"]             = actions.refresh_files, -- Update stats and entries in the file list.
						["<leader>e"]     = actions.focus_files,
						["<leader>b"]     = actions.toggle_files,
						["g<C-x>"]        = actions.cycle_layout,
						["[x"]            = actions.prev_conflict,
						["]x"]            = actions.next_conflict,
					},
					file_history_panel = {
						["g!"]            = actions.options, -- Open the option panel
						["<C-A-d>"]       = actions.open_in_diffview, -- Open the entry under the cursor in a diffview
						["y"]             = actions.copy_hash, -- Copy the commit hash of the entry under the cursor
						["L"]             = actions.open_commit_log,
						["zR"]            = actions.open_all_folds,
						["zM"]            = actions.close_all_folds,
						["j"]             = actions.next_entry,
						["<down>"]        = actions.next_entry,
						["k"]             = actions.prev_entry,
						["<up>"]          = actions.prev_entry,
						["<cr>"]          = actions.select_entry,
						["o"]             = actions.select_entry,
						["<2-LeftMouse>"] = actions.select_entry,
						["<c-b>"]         = actions.scroll_view( -0.25),
						["<c-f>"]         = actions.scroll_view(0.25),
						["<tab>"]         = actions.select_next_entry,
						["<s-tab>"]       = actions.select_prev_entry,
						["gf"]            = actions.goto_file,
						["<C-w><C-f>"]    = actions.goto_file_split,
						["<C-w>gf"]       = actions.goto_file_tab,
						["<leader>e"]     = actions.focus_files,
						["<leader>b"]     = actions.toggle_files,
						["g<C-x>"]        = actions.cycle_layout,
					},
					option_panel = {
						["<tab>"] = actions.select_entry,
						["q"]     = actions.close,
					},
				},
			})
		end


	},

	--trouble
	{

		"folke/trouble.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
		keys = {
			{ "<leader>xx", "<cmd>TroubleToggle<cr>" },
			{ "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>" },
			{ "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>" },
			{ "<leader>xq", "<cmd>TroubleToggle quickfix<cr>" },

		},
		config = function()
			require("trouble").setup {
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
				height = 20,
				action_keys = { -- key mappings for actions in the trouble list
					jump_close = { "<cr>", "<tab>" }, -- jump to the diagnostic or open / close folds
					jump = { "o" }, -- jump to the diagnostic and close the list
				},
			}
			-- setting in lsp
			-- keymap("n", "gd", "<cmd>TroubleToggle lsp_definitions<cr>", opts)
			-- keymap("n", "gr", "<cmd>TroubleToggle lsp_references<cr>", opts)
		end

	},
}
