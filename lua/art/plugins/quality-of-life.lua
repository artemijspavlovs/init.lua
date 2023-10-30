-- trouble - bottom pane with diagnostic data
vim.keymap.set("n", "<Leader>trt", ":TroubleToggle<CR>")

-- indent highlighting
vim.opt.list = true
vim.opt.listchars:append("space:⋅")
vim.opt.listchars:append("eol:↴")
