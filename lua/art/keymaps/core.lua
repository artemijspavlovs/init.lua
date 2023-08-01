vim.g.mapleader = " "

-- navigation
vim.keymap.set("n", "<leader>oe", vim.cmd.Ex) -- open file explorer

vim.keymap.set("n", "j", "jzz") -- jump down a line and keep cursor in the middle
vim.keymap.set("n", "k", "kzz") -- jump up a line and keep cursor in the middle

vim.keymap.set("n", "gg", "ggzz") -- jump to the beginning of the file and keep cursor in the middle
vim.keymap.set("n", "G", "Gzz") -- jump to the end of the file and keep cursor in the middle
vim.keymap.set("n", "{", "{zz") -- jump code block up and keep cursor in the middle
vim.keymap.set("n", "}", "}zz") -- jump code block down and keep cursor in the middle

vim.keymap.set("n", "<C-u>", "<C-u>zz") -- jump half page up and keep cursor in the middle
vim.keymap.set("n", "<C-d>", "<C-d>zz") -- jump half page down and keep cursor in the middle

-- quality of life bindings for blazingly fast dev life
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv") -- in visual mode, move selected code down
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv") -- in visual mode, move selected code up

vim.keymap.set("n", "J", "mzJ`z") -- append the line below you to the current line with a space in between
vim.keymap.set("n", "n", "nzzzv") -- keep search terms in the middle when looking things up
vim.keymap.set("n", "N", "Nzzzv") -- keep search terms in the middle when looking things up

vim.keymap.set("x", "<leader>p", '"_dP') -- paste over text without loosing the copy buffer

-- copy into the system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]]) -- yank into system clipboard
vim.keymap.set("n", "<leader>Y", [["+Y]]) -- yank  current line into system clipboard

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]]) -- delete current line into system clipboard

vim.keymap.set("n", "Q", "<nop>") -- unbind Q
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]]) -- replace the word that the cursor is on

