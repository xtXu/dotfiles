local status_ok, comment = pcall(require, "Comment")
local ts_comment_ok, _ = pcall(require, "ts_context_commentstring")

if not status_ok then
	vim.notify("Plugin Comment.nvim not found !")
	return
end

if not ts_comment_ok then
	vim.notify("ts_comment isn't enabled! ")
	comment.setup()
	return
end

comment.setup {
	pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
}


