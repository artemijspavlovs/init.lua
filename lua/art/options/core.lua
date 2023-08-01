-- line numbers
vim.opt.relativenumber = true -- show relative line numbers
vim.opt.nu = true -- shows absolute line number on cursor line (when relative number is on)

-- tabs & indentation
vim.opt.tabstop = 4 -- 2 spaces for tabs (prettier default)
vim.opt.shiftwidth = 4 -- 2 spaces for indent width
vim.opt.softtabstop = 4
vim.opt.expandtab = true -- expand tab to spaces
vim.opt.autoindent = true -- copy indent from current line when starting new one

-- line wrapping
vim.opt.wrap = true -- enable line wrapping

-- search settings
vim.opt.ignorecase = true -- ignore case when searching
vim.opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- cursor line
vim.opt.cursorline = true -- highlight the current cursor line

-- turn on termguicolors
vim.opt.termguicolors = true
vim.opt.background = "dark" -- colorschemes that can be light or dark will be made dark
vim.opt.signcolumn = "yes" -- show sign column so that text doesn't shift
--
-- split windows
vim.opt.splitright = true -- split vertical window to the right
vim.opt.splitbelow = true -- split horizontal window to the bottom

vim.opt.iskeyword:append("-") -- consider string-string as whole word

vim.opt.smartindent = true
-- undo & undotree
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.termguicolors = true

vim.opt.scrolloff = 24 -- keep 24 line margin when scrolling
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

-- vim.opt.colorcolumn = "80" -- draw a line at 80 symbols

