local status_ok, neoclip = pcall(require, "neoclip")
if not status_ok then
	vim.notify("Plugin neoclip not found !")
  return
end

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

neoclip.setup({
	preview = false;
	keys = {
		telescope = {
			i = {
				-- select = '<cr>',
				paste = {'<cr>', '<c-p>'},
				paste_behind = '<c-P>',
				replay = '<c-q>',  -- replay a macro
				delete = '<c-d>',  -- delete an entry
				custom = {},
			},
			n = {
				-- select = '<cr>',
				--- It is possible to map to more than one key.
				paste = { '<cr>', 'p', '<c-p>' },
				paste_behind = 'P',
				replay = 'q',
				delete = 'd',
				custom = {},
			},
		},
	},

	filter = function(data)
    return not all(data.event.regcontents, is_whitespace)
  end,
})


