return {
	-- nvim-possession
	{
    "gennaro-tedesco/nvim-possession",
    dependencies = {
        "ibhagwan/fzf-lua",
    },
		keys = {
			{
				"<leader><leader>sl", function()
					require("nvim-possession").list()
				end
			},
			{
				"<leader><leader>sn", function()
					require("nvim-possession").new()
				end
			},
			{
				"<leader><leader>su", function()
					require("nvim-possession").update()
				end
			}

		},
    config = function()
			require("nvim-possession").setup ({
				autoswitch = {
					enable = true,
				},

				post_hook = function()
					require('nvim-tree').toggle(false, true)
				end
			})

		end,
	},
}
