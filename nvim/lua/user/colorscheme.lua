-- local colorscheme = "catppuccin"
-- local colorscheme = "onedark"
local colorscheme = "base46"


-- because my base46 theme that migrated from Nvchad/base46
-- can't be loaded using "colorscheme base46"
-- so this chunk is spcecified for base46 theme
if colorscheme == "base46" then
	local status_ok, _ = pcall(require, colorscheme)
	if not status_ok then
		vim.notify("colorcheme " .. colorscheme .. " not found!")
	else 
		require("user.themes." .. colorscheme)
	end
	return
end

-- try to call the theme configuration if exists
local ok, _ = pcall(require, "user.themes." .. colorscheme)

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end
