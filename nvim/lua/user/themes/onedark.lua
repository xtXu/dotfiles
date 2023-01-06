local status_ok, theme = pcall(require, "onedark")
if not status_ok then
	-- vim.notify("onedark theme not found!")
	return
end

theme.setup {
    style = 'dark'
}
theme.load()
