-- auto install packer if not installed
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end
local packer_bootstrap = ensure_packer() -- true if packer was just installed

-- autocommand that reloads neovim and installs/updates/removes plugins
-- when file is saved
vim.cmd([[
augroup packer_user_config
autocmd!
autocmd BufWritePost packer.lua source <afile> | PackerSync
augroup end
]])

-- import packer safely
local status, packer = pcall(require, "packer")
if not status then
	return
end

return packer.startup(function(use)
	-- packer can manage itself
	use({ "wbthomason/packer.nvim" })

	-- generic dependencies
	use({ "nvim-lua/plenary.nvim" })

	-- -------
	-- plugins/ui.lua
	-- -------
	-- colorscheme
	use({
		"EdenEast/nightfox.nvim",
		config = function()
			vim.cmd("colorscheme carbonfox")
		end,
	})

	-- bottom status line
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "nvim-tree/nvim-web-devicons", opt = true },
	})

	-- -------
	-- plugins/file-browsing.lua
	-- -------
	-- file browsing
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" }) -- dependency for better sorting performance
	use({ "nvim-telescope/telescope.nvim", branch = "0.1.x" }) -- fuzzy finder
	use({ "theprimeagen/harpoon" })

	-- -------
	-- plugins/syntax-highlight.lua
	-- -------
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
	})

	-- -------
	-- plugins/lsp.lua
	-- -------
	use({ "williamboman/mason.nvim" }) -- in charge of managing lsp servers, linters & formatters
	use({ "williamboman/mason-lspconfig.nvim" }) -- bridges gap b/w mason & lspconfig

	use({ "neovim/nvim-lspconfig" }) -- easily configure language servers

	-- visualize lsp progress
	use({
		"j-hui/fidget.nvim",
		tag = "legacy",
		config = function()
			require("fidget").setup()
		end,
	})

	-- -------
	-- plugins/lsp/go.lua
	-- -------
	use({
		"ray-x/guihua.lua",
	})
	use({
		"ray-x/go.nvim",
		tf = { "go", "gomod" },
		dependencies = {
			"neovim/nvim-lspconfig",
			"nvim-treesitter/nvim-treesitter",
			"ray-x/guihua.lua",
		},
	})

	-- -------
	-- plugins/lsp/rust.lua
	-- -------
	use({
		"simrat39/rust-tools.nvim",
		dependencies = { "nvim-tree/nvim-lspconfig" },
	})

	-- use({
	-- 	"rust-lang/rust.vim",
	-- })
	--
	-- use({
	-- 	"saecki/crates.nvim",
	-- 	tag = "v0.3.0",
	-- 	requires = { "nvim-lua/plenary.nvim" },
	-- 	config = function()
	-- 		require("crates").setup()
	-- 	end,
	-- })

	-- -------
	-- plugins/lsp/web.lua
	-- -------
	use({
		"pmizio/typescript-tools.nvim",
		requires = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
	})
	use({ "windwp/nvim-ts-autotag" })

	-- -------
	-- plugins/lsp/devops.lua
	-- -------
	use({
		"hashivim/vim-terraform",
		config = function()
			vim.g.terraform_align = 1
			vim.g.terraform_fmt_on_save = 1
		end,
	})

	-- -------
	-- plugins/formatting.lua
	-- -------
	-- ! null-ls will be archived soon
	use({ "jose-elias-alvarez/null-ls.nvim" }) -- configure formatters
	use({ "jay-babu/mason-null-ls.nvim" }) -- mason-lspconfig alternative for linters and formatters

	-- -------
	-- plugins/autocompletion.lua
	-- -------
	use({ "hrsh7th/nvim-cmp" }) -- completion plugin

	-- lsp completion source
	use({ "hrsh7th/cmp-nvim-lsp" }) -- for autocompletion

	-- useful completion sources:
	use({ "hrsh7th/cmp-nvim-lua" })
	use({ "hrsh7th/cmp-nvim-lsp-signature-help" })
	use({ "hrsh7th/cmp-path" })
	use({ "hrsh7th/cmp-buffer" })
	use({ "chrisgrieser/cmp-nerdfont" })

	-- snippets
	use({
		"L3MON4D3/LuaSnip",
		tag = "v2.*",
		-- install jsregexp (optional!:).
		run = "make install_jsregexp",
	})
	use({ "saadparwaiz1/cmp_luasnip" }) -- completion source for luasnip
	use({ "rafamadriz/friendly-snippets" }) -- useful snippets

	-- -------
	-- plugins/quality-of-life.lua
	-- -------
	use({ "RRethy/vim-illuminate" }) -- show the usage of the word at cursor
	use({ "nvim-tree/nvim-web-devicons" }) -- icons
	use({
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	})

	use({
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
		},
		config = function()
			require("todo-comments").setup({})
		end,
	})

	use({
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
	})

	use({
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	})

	use({
		"m-demare/hlargs.nvim",
		config = function()
			require("hlargs").setup()
		end,
	})

	use({
		"weilbith/nvim-code-action-menu",
		cmd = "CodeActionMenu",
	})

	-- best git client in the universe
	use({
		"kdheepak/lazygit.nvim",
		-- optional for floating window border decoration
		requires = {
			"nvim-lua/plenary.nvim",
		},
	})
end)
