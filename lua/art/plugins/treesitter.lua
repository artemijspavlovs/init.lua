local treesitter_status, treesitter = pcall(require, "nvim-treesitter.configs")
if not treesitter_status then
	print("failed to load treesitter in plugins/treesitter.lua")
	return
end

treesitter.setup({
	highlight = {
		enable = true,
		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
		-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
		-- Using this option may slow down your editor, and you may see some duplicate highlights.
		-- Instead of true it can also be a list of languages
		additional_vim_regex_highlighting = false,
		disable = {},
	},

	autotag = {
		enable = true,
		enable_rename = true,
		enable_close = true,
		enable_close_on_slash = true,
		disable = {},
	},

	indent = {
		enable = true,
		disable = {},
	},
	-- A list of parser names, or 'all' (the five listed parsers should always be installed)
	ensure_installed = {
		"typescript",
		"javascript",
		"tsx",
		"html",
		"css",

		"rust",

		"lua",

		"vim",
		"vimdoc",
		"query",
        
		"go",
		"gomod",
		"gosum",

		"markdown",
		"markdown_inline",
		"hcl",
	},

	rainbow = {
		enable = true,
		extended_mode = true,
		max_file_lines = nil,
	},

	-- Install parsers synchronously (only applied to `ensure_installed`)
	sync_install = false,

	-- Automatically install missing parsers when entering buffer
	-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
	auto_install = true,
})

