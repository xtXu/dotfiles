local status_ok, dressing = pcall(require, "dressing")
if not status_ok then
	vim.notify("Plugin dressing not found !")
  return
end

dressing.setup{
	input = {
		enabled = true,
		border = "single"
	},

	select = {
		enabled = false,
	}
}
