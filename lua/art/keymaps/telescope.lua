local tbuiltin_status, tbuiltin = pcall(require, "telescope.builtin")
if not tbuiltin_status then
	print("failed to load tbuiltin in keymaps/telescope.lua")
	return
end

vim.keymap.set("n", "<leader>tff", tbuiltin.find_files, {}) -- search for files by name
vim.keymap.set("n", "<leader>tfg", tbuiltin.git_files, {}) -- search for git tracked files by name
vim.keymap.set("n", "<leader>tfs", tbuiltin.live_grep, {}) -- search for strings

