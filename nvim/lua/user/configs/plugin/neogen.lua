local status_ok, neogen = pcall(require, "neogen")
if not status_ok then
	vim.notify("Plugin neogen not found !")
	return
end

neogen.setup({
	snippet_engine = "luasnip"
})

