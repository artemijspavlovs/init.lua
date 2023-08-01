local mark_status, mark = pcall(require, "harpoon.mark")
if not mark_status then
	print("failed to load mark in keymaps/harpoon.lua")
	return
end

local ui_status, ui = pcall(require, "harpoon.ui")
if not ui_status then
	print("failed to load ui in keymaps/harpoon.lua")
	return
end

vim.keymap.set("n", "<C-a>", mark.add_file) -- add file path to harpoon cache
vim.keymap.set("n", "<leader>htm", ui.toggle_quick_menu) -- toggle harpoon window

