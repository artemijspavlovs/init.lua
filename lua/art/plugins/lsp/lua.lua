local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
	print("failed to load lspconfig in plugins/lsp/go.lua")
	return
end

local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status then
	print("failed to load cmp_nvim_lsp in plugins/lsp/rust.lua")
	return
end

-- autocompletion
local cmp_status, cmp = pcall(require, "cmp")
if not cmp_status then
	return
end

cmp.setup.filetype("lua", {
	sources = cmp.config.sources({
		{ name = "luasnip" }, -- snipped engine
		{ name = "nvim_lsp" }, -- from language server
	}, {
		{ name = "path" }, -- file paths
		{ name = "buffer" }, -- source current buffer

		{ name = "nvim_lua" }, -- complete neovim's Lua runtime API such vim.lsp.*
		{ name = "nvim_lsp_signature_help" }, -- display function signatures with current parameter emphasized
	}),
})

local lua_capabilities = cmp_nvim_lsp.default_capabilities()
local lua_on_attach = function(_, bufnr)
	print("lua")
end

local opts = {
	on_attach = lua_on_attach,
	capabilities = lua_capabilities,
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim", "augroup" },
			},
		},
	},
}

lspconfig["lua_ls"].setup(opts)
