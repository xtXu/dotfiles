local status_ok, possession = pcall(require, "possession")
if not status_ok then
	vim.notify("Plugin possession not found !")
	return
end

possession.setup {
	silent = false,
	load_silent = true,
	debug = false,
	prompt_no_cr = false,
	autosave = {
		current = true, -- or fun(name): boolean
		tmp = false, -- or fun(): boolean
		tmp_name = 'tmp',
		on_load = true,
		on_quit = true,
	},
	commands = {
		save = 'PossessionSave',
		load = 'PossessionLoad',
		close = 'PossessionClose',
		delete = 'PossessionDelete',
		show = 'PossessionShow',
		list = 'PossessionList',
		migrate = 'PossessionMigrate',
	},
	plugins = {
		close_windows = {
			hooks = { 'before_save', 'before_load' },
			preserve_layout = true, -- or fun(win): boolean
			match = {
				floating = true,
				buftype = {},
				filetype = {},
				custom = false, -- or fun(win): boolean
			},
		},
		delete_hidden_buffers = {
			hooks = {
				'before_load',
				vim.o.sessionoptions:match('buffer') and 'before_save',
			},
			force = false, -- or fun(buf): boolean
		},
		nvim_tree = true,
		tabby = true,
		delete_buffers = false,
	},
}
