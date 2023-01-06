local status_ok, autopairs = pcall(require, "nvim-autopairs")
if not status_ok then
	vim.notify("Plugin nvim-autopairs not found !")
  return
end


autopairs.setup {
	enable_moveright = true
}
