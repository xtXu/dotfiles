return {
	-- Comment
	{
    "numToStr/Comment.nvim",
		keys = {
			"gcc", "gbc", "gco", "gcO", "gcA",
			{"gc", "gb", mode="v"},
		},
		dependencies = {
			"JoosepAlviste/nvim-ts-context-commentstring",
		},
		config = function()
			require('Comment').setup {
				pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
			}
		end
	},

	-- surround
	{
		"kylechui/nvim-surround",
		version = "*",
		config = function()
        require("nvim-surround").setup({
            -- Configuration here, or leave empty to use defaults
        })
    end
	},


	-- hop
	{
		"phaazon/hop.nvim",
		version = 'v2.*', -- optional but strongly recommended
		config = function()
			-- you can configure Hop the way you like here; see :h hop-config
			require'hop'.setup { 
				jump_on_sole_occurrence = true
			}
			
			local opts = { noremap = true, silent = true }

			vim.api.nvim_set_keymap('', 'f', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>", {})
			vim.api.nvim_set_keymap('', 'F', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>", {})
			vim.api.nvim_set_keymap('', 't', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })<cr>", {})
			vim.api.nvim_set_keymap('', 'T', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })<cr>", {})
			vim.api.nvim_set_keymap('', '<leader>s', "<cmd>lua require'hop'.hint_char2()<cr>", {})
			vim.api.nvim_set_keymap('', '<leader>/', "<cmd>lua require'hop'.hint_patterns()<cr>", {})
			vim.api.nvim_set_keymap('', '<leader><leader>l', "<cmd>lua require'hop'.hint_lines()<cr>", {})
			vim.api.nvim_set_keymap('', '<leader><leader>j', "<cmd>lua require'hop'.hint_lines({direction = require'hop.hint'.HintDirection.AFTER_CURSOR})<cr>", {})
			vim.api.nvim_set_keymap('', '<leader><leader>k', "<cmd>lua require'hop'.hint_lines({direction = require'hop.hint'.HintDirection.BEFORE_CURSOR})<cr>", {})


			vim.api.nvim_del_keymap('s', 'f')
			vim.api.nvim_del_keymap('s', 'F')
			vim.api.nvim_del_keymap('s', 't')
			vim.api.nvim_del_keymap('s', 'T')

		end

	},

	
	-- autopairs
	{
		"windwp/nvim-autopairs",
		keys = {
			{"\"",mode="i"},
			{"\'",mode="i"},
			{"(",mode="i"},
			{"{",mode="i"},
			{"[",mode="i"},
		},
		config = function()
			require("nvim-autopairs").setup {
				enable_moveright = true,
				check_ts = true
			}
		end
	},

	-- cmp
	{
		"hrsh7th/nvim-cmp",
		-- event = "VeryLazy",
		event = "InsertEnter",
		dependencies = {
			 "hrsh7th/cmp-nvim-lsp", -- lsp completion
			 "hrsh7th/cmp-nvim-lua", -- neovim lua api completion
			 "hrsh7th/cmp-buffer", -- buffer completions
			 "hrsh7th/cmp-path", -- path completions
			 "hrsh7th/cmp-cmdline", -- cmdline completions
			 "saadparwaiz1/cmp_luasnip", -- snippet completions
			 "hrsh7th/cmp-nvim-lsp-document-symbol", -- cmd line symbol source
			 -- "hrsh7th/cmp-nvim-lsp-signature-help",
			 -- "ray-x/lsp_signature.nvim",
			 "kdheepak/cmp-latex-symbols",

			 {"L3MON4D3/LuaSnip", version="v1.*"},
			 "rafamadriz/friendly-snippets",
			 "onsails/lspkind.nvim"
		},
		config = function() 
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			local lspkind = require("lspkind")
			
			require("luasnip/loaders/from_vscode").lazy_load()

			local check_backspace = function()
				local col = vim.fn.col "." - 1
				return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
			end

			-- local select_behavior = cmp.SelectBehavior.Select
			local select_behavior = cmp.SelectBehavior.Insert


			cmp.setup {
				sorting = {
					comparators = {
						cmp.config.compare.offset,
						cmp.config.compare.exact,
						cmp.config.compare.recently_used,
						require("clangd_extensions.cmp_scores"),
						cmp.config.compare.kind,
						cmp.config.compare.sort_text,
						cmp.config.compare.length,
						cmp.config.compare.order,
					},
				 },
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body) -- For `luasnip` users.
					end,
				},
				mapping = {
					["<C-k>"] = cmp.mapping.select_prev_item { behavior = select_behavior },
					["<C-j>"] = cmp.mapping.select_next_item { behavior = select_behavior },
					["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
					["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
					["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
					["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
					["<C-c>"] = cmp.mapping {
						i = cmp.mapping.abort(),
						c = cmp.mapping.close(),
					},
					-- Accept currently selected item. If none selected, `select` first item.
					-- Set `select` to `false` to only confirm explicitly selected items.
					["<CR>"] = cmp.mapping.confirm { select = true },
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item { behavior = select_behavior }
						elseif luasnip.expandable() then
							luasnip.expand()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						-- elseif check_backspace() then
						-- 	fallback()
						else
							fallback()
						end
					end, {
						"i",
						"s",
					}),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item { behavior = cmp.SelectBehavior.Select }
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, {
						"i",
						"s",
					}),
				},
				formatting = {
					fields = { "kind", "abbr", "menu" },
					format = lspkind.cmp_format({
						mode = "symbol_text",
						menu = ({
							nvim_lsp = "[LSP]",
							nvim_lua = "[Nvim_Lua]",
							luasnip = "[Snippet]",
							buffer = "[Buffer]",
							path = "[Path]",
							latex_symbols = "[Latex]",
						}),
						maxwidth = 35,
						ellipsis_char = "...",
					}),
				},
				sources = {
					{ name = "nvim_lsp", max_item_count = 1000000},
					{ name = "nvim_lua" },
					{ name = "luasnip" },
					{ name = "latex_symbols" },
					-- { name = 'nvim_lsp_signature_help' },
					{ name = "buffer" },
					{ name = "path" },
				},
				confirm_opts = {
					behavior = cmp.ConfirmBehavior.Replace,
					select = false,
				},
				window = {
					-- bordered = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
					-- bordered = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
					-- completion = cmp.config.window.bordered(),
					-- documentation = cmp.config.window.bordered(),
					-- documentation = {
					-- 	border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
					-- }
				},
				experimental = {
					ghost_text = true,
					native_menu = false,
				},
				completion = {
					keyword_length = 2,
				},
			}

			-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline({ '/', '?' }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = 'nvim_lsp_document_symbol' }
				}, {
					{ name = 'buffer' }
				}),
				formatting = {
					format = lspkind.cmp_format({
						mode = "symbol",
						maxwidth = 35,
						ellipsis_char = "...",
					}),
				},
			})

			-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline(':', {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = 'path' }
				}, {
					{ name = 'cmdline' }
				}),

				formatting = {
					format = lspkind.cmp_format({
						mode = "symbol",
						maxwidth = 35,
						ellipsis_char = "...",
					}),
				},
			})
		end
	},

	-- Neogen (doxygen support)
	{
    "danymat/neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
		cmd = {"Neogen", "Neogen func", "Neogen class", "Neogen type"},
		keys = {"<leader>nc", "<leader>nf", "<leader>nt", "<leader>nn"},
    config = function ()
    	require("neogen").setup({
				snippet_engine = "luasnip"
			})

		local opts = { noremap = true, silent = true }
		local keymap = vim.api.nvim_set_keymap
		keymap("n", "<leader>nc", "<cmd>lua require('neogen').generate({type='class'})<CR>", opts)
		keymap("n", "<leader>nf", "<cmd>lua require('neogen').generate({type='file'})<CR>", opts)
		keymap("n", "<leader>nt", "<cmd>lua require('neogen').generate({type='type'})<CR>", opts)
		keymap("n", "<leader>nn", "<cmd>lua require('neogen').generate()<CR>", opts)
    end,
    -- Uncomment next line if you want to follow only stable versions
    -- version = "*" 
	},

	-- neoclip
	{
		"AckslD/nvim-neoclip.lua",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local function is_whitespace(line)
				return vim.fn.match(line, [[^\s*$]]) ~= -1
			end

			local function all(tbl, check)
				for _, entry in ipairs(tbl) do
					if not check(entry) then
						return false
					end
				end
				return true
			end

			require("neoclip").setup({
				preview = false;
				keys = {
					fzf = {
						select = 'default',
						paste = 'ctrl-p',
						paste_behind = 'ctrl-P',
						custom = {},
					},
				},

				filter = function(data)
					return not all(data.event.regcontents, is_whitespace)
				end,
			})

			local opts = { noremap = true, silent = true }
			vim.api.nvim_set_keymap("n", "<leader>p", "<cmd>lua require('neoclip.fzf')()<cr>", opts)

		end,

	}

}
