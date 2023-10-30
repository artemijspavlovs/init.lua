local go_status, go = pcall(require, "go")
if not go_status then
	print("failed to load go in plugins/lsp/go.lua")
	return
end

local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status then
	print("failed to load cmp_nvim_lsp in plugins/lsp/go.lua")
	return
end

-- format on save
local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.go",
	callback = function()
		require("go.format").goimport()
	end,
	group = format_sync_grp,
})

-- autocompletion
local cmp_status, cmp = pcall(require, "cmp")
if not cmp_status then
	return
end

cmp.setup.filetype("go", {
	sources = cmp.config.sources({
		{ name = "luasnip" }, -- snipped engine
		{ name = "nvim_lsp" }, -- from language server
	}, {
		{ name = "path" }, -- file paths
		{ name = "buffer" }, -- source current buffer

		{ name = "nvim_lsp_signature_help" }, -- display function signatures with current parameter emphasized
	}),
})

-- -------
-- config
-- -------
local go_on_attach = function(client, bufnr)
	local opts = { buffer = bufnr, remap = false }
	-- lsp bindings
	vim.keymap.set("n", "<leader>lgdf", vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "<leader>lgdc", vim.lsp.buf.declaration, opts)
	vim.keymap.set("n", "<leader>lgi", vim.lsp.buf.implementation, opts)
	vim.keymap.set("n", "<leader>lgr", vim.lsp.buf.references, opts)
	vim.keymap.set("n", "<leader>lca", vim.lsp.buf.code_action, opts)

	-- vim diagnostics
	vim.keymap.set("n", "<leader>lof", vim.diagnostic.open_float, opts)
	vim.keymap.set("n", "<leader>lsh", vim.lsp.buf.signature_help, opts)
	-- go bindings
	vim.keymap.set("n", "<leader>gocm", ":GoCmt<CR>", opts) -- add comment describing the current item
	vim.keymap.set("n", "<leader>goe", ":GoIfErr<CR>", opts) -- add if err != boilerplate
	vim.keymap.set("n", "<leader>gor", ":GoRun<CR>", opts) -- run go code

	vim.keymap.set("n", "<leader>goca", ":GoCodeAction<CR>", opts) -- show go code actions
	vim.keymap.set("n", "<C-CR>", ":GoCodeAction<CR>", opts) -- show go code actions

	vim.keymap.set("n", "<leader>god", ":GoDoc<CR>", opts) -- view Docs for the package
	vim.keymap.set("n", "<leader>gotih", ":GoToggleInlay<CR>", opts) -- inlay hints
	vim.keymap.set("n", "<leader>gopo", ":GoPkgOutline<CR>", opts) -- view Doc outline for the package
	vim.keymap.set("n", "<leader>gogr", ":GoGenerateReturn<CR>", opts) -- view Doc outline for the package

	vim.keymap.set("n", "<leader>goot", ":GoAltV!<CR>", opts) -- open _test file
	vim.keymap.set("n", "<leader>gort", ":GoTest<CR>", opts) -- open _test file

	vim.keymap.set("n", "<leader>goatj", ":GoAddTag json<CR>", opts) -- add json tags to struct
	vim.keymap.set("n", "<leader>goatt", ":GoAddTag toml<CR>", opts) -- add json tags to struct
	vim.keymap.set("n", "<leader>goatd", ":GoAddTag db<CR>", opts) -- add db tags to struct
	vim.keymap.set("n", "<leader>gormt", ":GoRmTag<CR>", opts) -- add db tags to struct

	vim.keymap.set("n", "<leader>gofst", ":GoFillStruct<CR>", opts) -- fill struct with all fields
	vim.keymap.set("n", "<leader>gofsw", ":GoFillSwitch<CR>", opts) -- fill switch with all options
	vim.keymap.set("n", "<leader>gofp", ":GoFixPlurals<CR>", opts) -- shorten function property definition, pull all props of same type together
end

go.setup({
	lsp_cfg = {
		on_attach = go_on_attach,
		capabilities = cmp_nvim_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities()),
	},
})
