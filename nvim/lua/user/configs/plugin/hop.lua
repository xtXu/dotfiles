local status_ok, hop = pcall(require, "hop")
if not status_ok then
	vim.notify("Plugin hop not found !")
  return
end

hop.setup {
  -- Hop configuration goes there
	jump_on_sole_occurrence = true,
}
