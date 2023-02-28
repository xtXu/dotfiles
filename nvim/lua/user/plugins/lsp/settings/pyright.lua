local util = require 'lspconfig.util'

return {
  settings = {
    python =  {
			analysis = {
				autoSearchPaths = true,
				diagnosticMode = "workspace",
				useLibraryCodeForTypes = true,
				typeCheckingMode = "off",
			},
    },
  },

	-- root_dir = function(fname)
	-- 	local root_files = {
	-- 			'pyproject.toml',
	-- 			'setup.py',
	-- 			'setup.cfg',
	-- 			'requirements.txt',
	-- 			'Pipfile',
	-- 			'pyrightconfig.json',
	-- 	}
	-- 	return util.root_pattern(unpack(root_files))(fname) or util.find_git_ancestor(fname) or util.path.dirname(fname)
	-- end,
	-- single_file_support = true,
}


