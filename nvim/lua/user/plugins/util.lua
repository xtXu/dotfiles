return {

	-- nvim-possession
	{
    "gennaro-tedesco/nvim-possession",
    dependencies = {
        "ibhagwan/fzf-lua",
    },

    config = function()
			require("nvim-possession").setup ({
				autoswitch = {
					enable = true,
				}
			}) 
		end,

    init = function()
        local possession = require("nvim-possession")
        vim.keymap.set("n", "<leader>sl", function()
            possession.list()
        end)
        vim.keymap.set("n", "<leader>sn", function()
            possession.new()
        end)
        vim.keymap.set("n", "<leader>su", function()
            possession.update()
        end)
    end,

		post_hook = function()
        require('nvim-tree').toggle(false, true)
    end
}


}
