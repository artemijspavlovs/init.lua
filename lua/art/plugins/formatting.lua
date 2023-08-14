local null_ls_status, null_ls = pcall(require, "null-ls")
if not null_ls_status then
	print("failed to load null_ls in null_ls.lua")
	return
end

local mason_null_ls_status, mason_null_ls = pcall(require, "mason-null-ls")
if not mason_null_ls_status then
	print("failed to load mason_null_ls in plugins/lsp/mason.lua")
	return
end

-- -----
-- config
-- -----
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
	-- setup formatters & linters
	sources = {
		--  to disable file types use
		--  "formatting.prettier.with({disabled_filetypes = {}})" (see null-ls docs)
		formatting.stylua, -- lua formatter
		formatting.prettier, -- js/ts formatter
		diagnostics.eslint_d.with({ -- js/ts linter
			-- only enable eslint if root has .eslintrc.js (not in youtube nvim video)
			condition = function(utils)
				return utils.root_has_file(".eslintrc.js") -- change file extension if you use something else
			end,
		}),
	},

	-- configure format on save
	on_attach = function(current_client, bufnr)
		if current_client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({
						filter = function(client)
							--  only use null-ls for formatting instead of lsp server
							return client.name == "null-ls"
						end,
						bufnr = bufnr,
					})
				end,
			})
		end
	end,
})

mason_null_ls.setup({
	ensure_installed = {
		"stylua",
		"prettier",
		"eslint_d",
		"terraform_fmt",
	},
})
