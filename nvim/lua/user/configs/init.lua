local M = {}

-- local starts_with = require("user.utils").starts_with
-- local ends_with = require("user.utils").ends_with

M.setup = function()
  local config_dir = vim.fn.stdpath('config') .. '/lua/user/configs/plugin'
  -- plugins do not need to load, NOTE: no .lua suffix required
  local unload_plugins = {
    -- "init", -- we don't need to load init again
  }

  local unload_flag = {}
  for _, v in pairs(unload_plugins) do
    unload_flag[v] = true
  end
  for _, fname in pairs(vim.fn.readdir(config_dir)) do
		local cut_suffix_fname = fname:sub(1, #fname - #'.lua')
		if unload_flag[cut_suffix_fname] == nil then
			local file = "user.configs.plugin." .. cut_suffix_fname
			local status_ok, _ = pcall(require, file)
			if not status_ok then
				vim.notify('Failed loading ' .. fname, vim.log.levels.ERROR)
			end
		end
  end
end

M.setup()
