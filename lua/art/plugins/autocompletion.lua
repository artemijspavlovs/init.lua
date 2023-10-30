-- autocompletion
local cmp_status, cmp = pcall(require, "cmp")
if not cmp_status then
	return
end

-- snippet engine
local luasnip_status, luasnip = pcall(require, "luasnip")
if not luasnip_status then
	return
end

-- -----
-- options
-- -----
vim.opt.completeopt = { "menuone", "noselect", "noinsert" }
vim.opt.shortmess = vim.opt.shortmess + { c = true }
vim.api.nvim_set_option("updatetime", 300)

-- Fixed column for diagnostics to appear
-- Show autodiagnostic popup on cursor hover_range
-- Goto previous / next diagnostic warning / error
-- Show inlay_hints more frequently
vim.cmd([[
set signcolumn=yes
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]])

-- -----
-- config
-- -----
require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},

	mapping = cmp.mapping.preset.insert({
		["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
		["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion

		-- Add tab support
		["<S-Tab>"] = cmp.mapping.select_prev_item(), -- previous suggestion with shift+tab
		["<Tab>"] = cmp.mapping.select_next_item(), -- next suggestion with tab

		["<C-h>"] = cmp.mapping.scroll_docs(-4), -- scroll docs up
		["<C-l>"] = cmp.mapping.scroll_docs(4), -- scroll docs down

		["<C-Space>"] = cmp.mapping.complete(),
		["<Esc>"] = cmp.mapping.close(), -- cancel autocompletion popup

		["<CR>"] = cmp.mapping.confirm({
			cmp.ConfirmBehavior.Insert,
			select = true,
		}),
	}),

	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},

	-- configure lspkind for vscode-like icons
	formatting = {},
})
