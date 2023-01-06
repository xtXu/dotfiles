local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
	vim.notify("Plugin telescope not found !")
  return
end

local actions = require('telescope.actions')
-- telescope.setup {
telescope.setup {
	defaults = {
		-- path_display= {
		-- 	shorten = {
		-- 		len = 2,
		-- 		exclude = {1, -1, -2}
		-- 	}
		-- },
		dynamic_preview_title = true,
		path_display = {"smart"},
		file_ignore_patterns = {"build/", "devel/" ,"logs/"},

		-- layout_config = {
		-- 	horizontal = {
		-- 		prompt_position = "top"
		-- 	}
		-- },

    mappings = {
			i = {
        ["<C-n>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,

        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,

        ["<Down>"] = actions.cycle_history_next,
        ["<Up>"] = actions.cycle_history_prev,

        ["<CR>"] = actions.select_default,
        ["<C-x>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<C-t>"] = actions.select_tab,

        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,

        ["<PageUp>"] = actions.results_scrolling_up,
        ["<PageDown>"] = actions.results_scrolling_down,

      },

      n = {
        ["<esc>"] = actions.close,
        ["<C-c>"] = actions.close,
        ["<CR>"] = actions.select_default,
        ["<C-x>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<C-t>"] = actions.select_tab,

        ["<Down>"] = actions.move_selection_next,
        ["<Up>"] = actions.move_selection_previous,
        ["gg"] = actions.move_to_top,
        ["G"] = actions.move_to_bottom,

        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,

        ["<PageUp>"] = actions.results_scrolling_up,
        ["<PageDown>"] = actions.results_scrolling_down,

      },
    },
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
		buffers = {
			mappings = {
				i = {
					["<C-d>"] = "delete_buffer",
				},
				n = {
					["d"] = "delete_buffer",
				}
			}
		}
  },
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    },
		["ui-select"] = {
      require("telescope.themes").get_cursor {
        -- even more opts
      }
		},

		live_grep_args = {
			default_mappings = {
				i = {
					["<C-j>"] = actions.move_selection_next,
					["<C-k>"] = actions.move_selection_previous,
				}
			},
		}
  }
}



local fzf_status_ok, _ = pcall(require, "fzf_lib")
if fzf_status_ok then
	telescope.load_extension('fzf')
end

local neoclip_status_ok, _ = pcall(require, "neoclip")
if neoclip_status_ok then
	telescope.load_extension('neoclip')
end

local args_status_ok, _ = pcall(require, "telescope._extensions.live_grep_args")
if args_status_ok then
	telescope.load_extension("live_grep_args")
end

local term_status_ok, term = pcall(require, "telescope-toggleterm")
if term_status_ok then
	term.setup {
		telescope_mappings = {
			-- <K> : kill the terminal buffer (default) .
			["K"] = term.actions.exit_terminal,
			["<C-c>"] = actions.close,
		},
	}
telescope.load_extension('toggleterm')
end

-- local project_status_ok, _ = pcall(require, "telescope._extensions.project" )
local project_status_ok, _ = pcall(require, "project_nvim" )
if project_status_ok then
	telescope.load_extension('projects')
end


local ui_status_ok, _ = pcall(require, "telescope._extensions.ui-select")
if ui_status_ok then
	telescope.load_extension("ui-select")
end

local session_status_ok, _ = pcall(require, "possession")
if session_status_ok then
	telescope.load_extension("possession")
end
