return {
	-- Comment
	{
		"numToStr/Comment.nvim",
		keys = {
			"gcc", "gbc", "gco", "gcO", "gcA",
			{ "gc", "gb", mode = "v" },
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
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end
	},


	-- hop
	-- {
	-- 	"phaazon/hop.nvim",
	-- 	version = 'v2.*', -- optional but strongly recommended
	-- 	keys = {
	-- 		{ 'f', false, mode="s" },
	-- 		{ 'F', false, mode="s" },
	-- 		{ 't', false, mode="s" },
	-- 		{ 'T', false, mode="s" },
	--
	-- 		{ "f", "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>", mode="" },
	-- 		{ "F", "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>", mode="" },
	-- 		{ "t", "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })<cr>", mode="" },
	-- 		{ "T", "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })<cr>", mode="" },
	-- 		{ "<leader>s", "<cmd>lua require'hop'.hint_char2()<cr>", mode="" },
	-- 		{ "<leader>/", "<cmd>lua require'hop'.hint_patterns()<cr>", mode="" },
	-- 		{ "<leader><leader>l", "<cmd>lua require'hop'.hint_lines()<cr>", mode="" },
	-- 		{ "<leader><leader>j", "<cmd>lua require'hop'.hint_lines({direction = require'hop.hint'.HintDirection.AFTER_CURSOR})<cr>", mode="" },
	-- 		{ "<leader><leader>k", "<cmd>lua require'hop'.hint_lines({direction = require'hop.hint'.HintDirection.BEFORE_CURSOR})<cr>", mode="" },
	--
	-- 	},
	-- 	config = function()
	-- 		-- you can configure Hop the way you like here; see :h hop-config
	-- 		require'hop'.setup {
	-- 			jump_on_sole_occurrence = true
	-- 		}
	-- 	end
	--
	-- },

	-- leap.nvim
	-- {
	-- 	"ggandor/leap.nvim",
	-- 	config = function()
	-- 		require('leap').add_default_mappings()
	-- 	end
	-- },
	-- {
	-- 	"ggandor/flit.nvim",
	-- 	dependencies = {
	-- 		"ggandor/leap.nvim",
	-- 	},
	-- 	config = function()
	-- 		require('flit').setup {
	-- 			labeled_modes = "nv",
	-- 		}
	-- 	end
	-- },
	-- {
	-- 	"ggandor/leap-ast.nvim",
	-- 	dependencies = {
	-- 		"ggandor/leap.nvim",
	-- 	},
	-- 	config = function()
	-- 		vim.keymap.set({'n', 'x', 'o'}, '<C-s>', function() require'leap-ast'.leap() end, {})
	-- 	end
	-- },
	-- {
	-- 	"ggandor/leap-spooky.nvim",
	-- 	dependencies = {
	-- 		"ggandor/leap.nvim",
	-- 	},
	-- 	config = function()
	-- 		require('leap-spooky').setup {}
	-- 	end
	-- },


	-- flash.nvim
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		---@type Flash.Config
		opts = {},
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash",
			},
			{
				"S",
				mode = { "n", "o", "x" },
				function()
					require("flash").treesitter()
				end,
				desc = "Flash Treesitter",
			},
			{
				"r",
				mode = "o",
				function()
					require("flash").remote()
				end,
				desc = "Remote Flash",
			},
			{
				"R",
				mode = { "o", "x" },
				function()
					require("flash").treesitter_search()
				end,
				desc = "Flash Treesitter Search",
			},
			{
				"<c-s>",
				mode = { "c" },
				function()
					require("flash").toggle()
				end,
				desc = "Toggle Flash Search",
			},
		},
		config = function ()
			require("flash").setup {
				label = {
					rainbow = {
						enabled = true,
					}
				}
			}
		end
	},



	-- autopairs
	{
		"windwp/nvim-autopairs",
		keys = {
			{ "\"", mode = "i" },
			{ "\'", mode = "i" },
			{ "(",  mode = "i" },
			{ "{",  mode = "i" },
			{ "[",  mode = "i" },
		},
		config = function()
			require("nvim-autopairs").setup {
				enable_moveright = true,
				check_ts = true
			}
		end
	},

	-- luasnip
	{
		"L3MON4D3/LuaSnip",
		keys = function()
			return {}
		end,
	},

	-- coq
	-- {
	-- 	"ms-jpq/coq_nvim",
	-- 	version = "coq",
	-- 	event = "InsertEnter",
	-- 	dependencies = {
	-- 		{"ms-jpq/coq.artifacts", version="artifacts"},
	-- 		{"ms-jpq/coq.thirdparty", version="3p"},
	-- 	}
	--
	-- },

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

			{ "L3MON4D3/LuaSnip", version = "v1.*" },
			"rafamadriz/friendly-snippets",
			"onsails/lspkind.nvim"
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			local lspkind = require("lspkind")

			require("luasnip/loaders/from_vscode").lazy_load()

			-- local check_backspace = function()
			-- 	local col = vim.fn.col "." - 1
			-- 	return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
			-- end
			local has_words_before = function()
				unpack = unpack or table.unpack
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
			end

			-- local select_behavior = cmp.SelectBehavior.Select
			local select_behavior = cmp.SelectBehavior.Insert


			cmp.setup({
				sorting = {
					comparators = {
						require("clangd_extensions.cmp_scores"),
						cmp.config.compare.offset,
						cmp.config.compare.exact,
						cmp.config.compare.recently_used,
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
					["<A-k>"] = cmp.mapping(cmp.mapping.scroll_docs( -1), { "i", "c" }),
					["<A-j>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
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
						elseif has_words_before() then
							cmp.complete()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item { behavior = cmp.SelectBehavior.Select }
						else
							fallback()
						end
					end, { "i", "s" }),
					["<C-n>"] = cmp.mapping(function(fallback)
						if luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),
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
					{ name = "nvim_lsp",     max_item_count = 1000000 },
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
				experimental = {
					ghost_text = true,
					native_menu = false,
				},
				completion = {
					keyword_length = 2,
				},
			})

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
		cmd = { "Neogen", "Neogen func", "Neogen class", "Neogen type" },
		keys = {
			{ "<leader>nc", "<cmd>lua fun(require)('neogen').generate({type='class'})<CR>", desc = "doxygen class" },
			{ "<leader>nf", "<cmd>lua require('neogen').generate({type='file'})<CR>",       desc = "doxygen file" },
			{ "<leader>nt", "<cmd>lua require('neogen').generate({type='type'})<CR>",       desc = "doxygen type" },
			{ "<leader>nn", "<cmd>lua require('neogen').generate()<CR>",                    desc = "doxygen" },
		},
		config = function()
			require("neogen").setup({
				snippet_engine = "luasnip"
			})
		end,
		-- Uncomment next line if you want to follow only stable versions
		-- version = "*"
	},

	-- neoclip
	{
		"AckslD/nvim-neoclip.lua",
		event = { "BufReadPre", "BufNewFile" },
		keys = {
			{ "<leader>p", "<cmd>lua require('neoclip.fzf')()<cr>" }
		},
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
				default_register = '+',
				preview = false,
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
		end,

	},

	-- inc rename
	{
		"smjonas/inc-rename.nvim",
		-- keys = { "<leader>rn" };
		lazy = true,
		config = function()
			require("inc_rename").setup()
			-- key setting in lsp handler
			-- local opts = { noremap = true, silent = true }
			-- vim.api.nvim_set_keymap("n", "<leader>rn", ":IncRename ", opts)
		end,
	},

}
