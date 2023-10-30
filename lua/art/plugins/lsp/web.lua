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
	local opts = { buffer = bufnr }
	print("hello typescript!")
	-- lsp bindings
	vim.keymap.set("n", "<leader>lgdf", vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "<leader>lgdc", vim.lsp.buf.declaration, opts)
	vim.keymap.set("n", "<leader>lgi", vim.lsp.buf.implementation, opts)
	vim.keymap.set("n", "<leader>lgr", vim.lsp.buf.references, opts)
	vim.keymap.set("n", "<leader>lca", vim.lsp.buf.code_action, opts)

	-- vim diagnostics
	vim.keymap.set("n", "<leader>lof", vim.diagnostic.open_float, opts)
	vim.keymap.set("n", "<leader>lsh", vim.lsp.buf.signature_help, opts)

	-- typescript tools bindings
	vim.keymap.set("n", "<leader>tsoi", ":TSToolsOrganizeImports<CR>", opts)
	vim.keymap.set("n", "<leader>tsami", ":TSToolsAddMissingImports<CR>", opts)
	vim.keymap.set("n", "<leader>tsfa", ":TSToolsFixAll<CR>", opts)
	vim.keymap.set("n", "<leader>tsru", ":TSToolsRemoveUnused<CR>", opts)
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

typescript_tools.setup({
	on_attach = typescript_on_attach,
	capabilities = typescript_capabilities,

	settings = {
		separate_diagnostic_server = true,
	},
})
