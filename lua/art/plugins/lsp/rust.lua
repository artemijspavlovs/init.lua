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
	print("hello rust!")
	vim.keymap.set("n", "<C-.>", rust_tools.hover_actions.hover_actions, { buffer = bufnr })
	-- Code action groups
	vim.keymap.set("n", "<C-CR>", ":RustCodeAction<CR>", { buffer = bufnr })

	vim.keymap.set("n", "<leader>rsca", ":RustCodeAction<CR>", { buffer = bufnr })
	vim.keymap.set("n", "<leader>rspm", ":RustParentModule<CR>", { buffer = bufnr })

	vim.keymap.set("n", "<leader>rsoc", ":RustOpenCargo<CR>", { buffer = bufnr })

	vim.keymap.set("n", "<leader>rss", ":RustStartStandaloneServerForBuffer<CR>", { buffer = bufnr })
end

rust_tools.setup({
	server = {
		standalone = true,
		on_attach = rust_on_attach,
		capabilities = rust_capabilities,
	},
})
