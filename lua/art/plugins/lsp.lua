local mason_status, mason = pcall(require, "mason")
if not mason_status then
	print("failed to import mason in plugins/lsp/mason.lua")
	return
end

local mason_lspconfig_status, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status then
	print("failed to import mason_lspconfig in plugins/lsp/mason.lua")
	return
end

-- -----
-- config
-- -----
mason.setup({})

mason_lspconfig.setup({
	ensure_installed = {
		-- lua
		"lua_ls",

		-- web
		"cssmodules_ls",
		"cssls",
		"html",
		"emmet_ls",

		"graphql",

		"tsserver",
		"eslint",

		-- go
		"golangci_lint_ls",
		"gopls",

		-- rust
		"rust_analyzer",
		-- "codelldb",

		-- devops
		"terraformls",
		"tflint",
		"ansiblels",
		"jsonls",
		"dockerls",
		"yamlls",
		"bashls",
		-- "tfsec",
	},
})
