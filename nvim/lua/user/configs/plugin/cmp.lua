local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
	vim.notify("Plugin cmp not found !")
	return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
	vim.notify("Plugin luasnip not found !")
	return
end

require("luasnip/loaders/from_vscode").lazy_load()

local check_backspace = function()
	local col = vim.fn.col "." - 1
	return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
end

--   פּ ﯟ   some other good icons
local kind_icons = {
	Text = "",
	Method = "m",
	Function = "",
	Constructor = "",
	Field = "",
	Variable = "",
	Class = "",
	Interface = "",
	Module = "",
	Property = "",
	Unit = "",
	Value = "",
	Enum = "",
	Keyword = "",
	Snippet = "",
	Color = "",
	File = "",
	Reference = "",
	Folder = "",
	EnumMember = "",
	Constant = "",
	Struct = "",
	Event = "",
	Operator = "",
	TypeParameter = "",
}
-- find more here: https://www.nerdfonts.com/cheat-sheet
--
-- local select_behavior = cmp.SelectBehavior.Select
local select_behavior = cmp.SelectBehavior.Insert

local MAX_ABBR_WIDTH = 35
local get_ws = function (max, len)
  return (" "):rep(max - len)
end

cmp.setup {
	-- sorting = {
	-- 	comparators = {
	-- 		cmp.config.compare.offset,
	-- 		cmp.config.compare.exact,
	-- 		cmp.config.compare.recently_used,
	-- 		require("clangd_extensions.cmp_scores"),
	-- 		cmp.config.compare.kind,
	-- 		cmp.config.compare.sort_text,
	-- 		cmp.config.compare.length,
	-- 		cmp.config.compare.order,
	-- 	},
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
			-- require('luasnip').lsp_expand(args.body) -- For `luasnip` users
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
		format = function(entry, vim_item)
			-- Kind icons
			vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
			-- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
			vim_item.menu = ({
				nvim_lsp = "[LSP]",
				nvim_lua = "[NVIM_LUA]",
				luasnip = "[Snippet]",
				buffer = "[Buffer]",
				path = "[Path]",
				latex_symbols = "[LATEX]",
			})[entry.source.name]
			-- vim_item.abbr = string.sub(vim_item.abbr,1,35)
			if #vim_item.abbr > MAX_ABBR_WIDTH then
				vim_item.abbr = string.sub(vim_item.abbr, 1, MAX_ABBR_WIDTH)
			else
				vim_item.abbr = vim_item.abbr .. get_ws(MAX_ABBR_WIDTH, #vim_item.abbr)
			end
			return vim_item
		end,
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
		documentation = {
			border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
		}
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
	})
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = 'path' }
	}, {
		{ name = 'cmdline' }
	})
})

