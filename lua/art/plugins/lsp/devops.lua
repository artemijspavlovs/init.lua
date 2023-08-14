local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
	print("failed to load lspconfig in plugins/lsp/rust.lua")
	return
end

local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status then
	print("failed to load cmp_nvim_lsp in plugins/lsp/rust.lua")
	return
end

vim.cmd([[silent! autocmd! filetypedetect BufRead,BufNewFile *.tf]])
vim.cmd([[autocmd BufRead,BufNewFile *.hcl set filetype=hcl]])
vim.cmd([[autocmd BufRead,BufNewFile .terraformrc,terraform.rc set filetype=hcl]])
vim.cmd([[autocmd BufRead,BufNewFile *.tf,*.tfvars set filetype=terraform]])
vim.cmd([[autocmd BufRead,BufNewFile *.tfstate,*.tfstate.backup set filetype=json]])

-- autocompletion
local cmp_status, cmp = pcall(require, "cmp")
if not cmp_status then
	print("failed to load cmp in plugins/lsp/rust.lua")
	return
end

cmp.setup.filetype({ "tf", "terraform" }, {
	sources = cmp.config.sources({
		{ name = "luasnip" }, -- snipped engine
		{ name = "nvim_lsp" }, -- from language server
	}, {
		{ name = "path" }, -- file paths
		{ name = "buffer" }, -- source current buffer

		{ name = "nvim_lsp_signature_help" }, -- display function signatures with current parameter emphasized
	}),
})

local devops_on_attach = function(client, bufnr)
	lspconfig.on_attach(client, bufnr)
	print("devops")
end

local devops_capabilities = cmp_nvim_lsp.default_capabilities()

local devops_lsps = {
	"terraformls",
	"tflint",
	"ansiblels",
	"jsonls",
	"dockerls",
	"yamlls",
	"bashls",
}

for _, lsp in ipairs(devops_lsps) do
	lspconfig[lsp].setup({
		on_attach = devops_on_attach,
		capabilities = devops_capabilities,
	})
end

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	pattern = { "*.tf", "*.tfvars" },
	callback = function()
		vim.lsp.buf.format()
	end,
})
