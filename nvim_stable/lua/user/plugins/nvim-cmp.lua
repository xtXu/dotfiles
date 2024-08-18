return {
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
					["<C-k>"] = cmp.mapping.select_prev_item {behavior = cmp.SelectBehavior.Select},
					["<C-j>"] = cmp.mapping.select_next_item {behavior = cmp.SelectBehavior.Select},
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
					-- ["<Tab>"] = cmp.mapping(function(fallback)
					-- 	if cmp.visible() then
					-- 		cmp.select_next_item {}
					-- 	elseif has_words_before() then
					-- 		cmp.complete()
					-- 	else
					-- 		fallback()
					-- 	end
					-- end, { "i", "s" }),
					-- ["<S-Tab>"] = cmp.mapping(function(fallback)
					-- 	if cmp.visible() then
					-- 		cmp.select_prev_item { behavior = cmp.SelectBehavior.Select }
					-- 	else
					-- 		fallback()
					-- 	end
					-- end, { "i", "s" }),
					["<Tab>"] = cmp.mapping(function(fallback)
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
}
