local rust_tools_status, rust_tools = pcall(require, "rust-tools")
if not rust_tools_status then
	print("failed to load rust_tools in plugins/lsp/rust.lua")
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
	print("failed to load cmp in plugins/lsp/rust.lua")
	return
end

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	pattern = { "*.rs" },
	callback = function()
		vim.lsp.buf.format()
	end,
})

cmp.setup.filetype("rust", {
	sources = cmp.config.sources({
		{ name = "luasnip" }, -- snipped engine
		{ name = "nvim_lsp" }, -- from language server
	}, {
		{ name = "path" }, -- file paths
		{ name = "buffer" }, -- source current buffer

		{ name = "nvim_lsp_signature_help" }, -- display function signatures with current parameter emphasized
	}),
})

local rust_capabilities = cmp_nvim_lsp.default_capabilities()
local rust_on_attach = function(_, bufnr)
	local opts = { buffer = bufnr }
	-- lsp bindings
	vim.keymap.set("n", "<leader>lgdf", vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "<leader>lgdc", vim.lsp.buf.declaration, opts)
	vim.keymap.set("n", "<leader>lgi", vim.lsp.buf.implementation, opts)
	vim.keymap.set("n", "<leader>lgr", vim.lsp.buf.references, opts)
	vim.keymap.set("n", "<leader>lca", vim.lsp.buf.code_action, opts)
	-- vim diagnostics
	vim.keymap.set("n", "<leader>lof", vim.diagnostic.open_float, opts)
	vim.keymap.set("n", "<leader>lsh", vim.lsp.buf.signature_help, opts)

	-- rust tools bindings
	vim.keymap.set("n", "<leader>rsha", ":RustHoverActions<CR>", opts)
	-- Code action groups
	vim.keymap.set("n", "<C-CR>", ":RustCodeAction<CR>", opts)

	vim.keymap.set("n", "<leader>rsca", ":RustCodeAction<CR>", opts)
	vim.keymap.set("n", "<leader>rspm", ":RustParentModule<CR>", opts)
	vim.keymap.set("n", "<leader>rsr", ":RustRun<CR>", opts)

	vim.keymap.set("n", "<leader>rsoc", ":RustOpenCargo<CR>", opts)

	vim.keymap.set("n", "<leader>rss", ":RustStartStandaloneServerForBuffer<CR>", opts)
end

rust_tools.setup({
	server = {
		standalone = true,
		on_attach = rust_on_attach,
		capabilities = rust_capabilities,
	},
})
