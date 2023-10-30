print("artpav.dev")

require("art.packer")
require("art.keymaps.core")
require("art.options.core")

require("art.plugins.ui") -- package manager
require("art.plugins.file-browsing") -- telescope, harpoon
require("art.plugins.syntax-highlighting") -- treesitter
require("art.plugins.quality-of-life") -- additional plugin configuration

require("art.plugins.lsp") -- mason, mason-lspconfig
require("art.plugins.lsp.go")
require("art.plugins.lsp.rust")
require("art.plugins.lsp.lua")
require("art.plugins.lsp.devops")
require("art.plugins.lsp.web")

require("art.plugins.formatting") -- null-ls, mason-null-ls
require("art.plugins.autocompletion") -- cmp, luasnip, lspkind
