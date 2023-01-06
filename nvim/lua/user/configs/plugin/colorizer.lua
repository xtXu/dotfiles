local status_ok, colorizer = pcall(require, "colorizer")
if not status_ok then
	vim.notify("Plugin colorizer not found !")
  return
end

colorizer.setup()
