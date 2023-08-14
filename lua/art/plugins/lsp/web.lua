local typescript_tools_status, typescript_tools = pcall(require, "typescript-tools")
if not typescript_tools_status then
	print("failed to load typescript_tools in plugins/lsp/web.lua")
	return
end

local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status then
	print("failed to load cmp_nvim_lsp in plugins/lsp/web.lua")
	return
end

local cmp_status, cmp = pcall(require, "cmp")
if not cmp_status then
	print("failed to load cmp in plugins/lsp/web.lua")
	return
end

local typescript_capabilities = cmp_nvim_lsp.default_capabilities()
local typescript_on_attach = function(_, bufnr)
	print("hello typescript!")
end

cmp.setup.filetype({ "rust", "typescript", "typescriptreact", "javascript", "javascriptreact" }, {
	sources = cmp.config.sources({
		{ name = "luasnip" }, -- snipped engine
		{ name = "nvim_lsp" }, -- from language server
	}, {
		{ name = "path" }, -- file paths
		{ name = "buffer" }, -- source current buffer

		{ name = "nvim_lsp_signature_help" }, -- display function signatures with current parameter emphasized
	}),
})

typescript_tools.setup({})
