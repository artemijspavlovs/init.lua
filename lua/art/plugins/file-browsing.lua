-- telescope, harpoon
local telescope_status, telescope = pcall(require, "telescope.builtin")
if not telescope_status then
	print("failed to load telescope in plugins/file-browsing.lua")
	return
end

local harpoon_mark_status, harpoon_mark = pcall(require, "harpoon.mark")
if not harpoon_mark_status then
	print("failed to load harpoon_mark in plugins/file-browsing.lua")
	return
end

local harpoon_ui_status, harpoon_ui = pcall(require, "harpoon.ui")
if not harpoon_ui_status then
	print("failed to load harpoon_ui in plugins/file-browsing.lua")
	return
end

-- -----
-- keymaps
-- -----
vim.keymap.set("n", "<leader>tff", telescope.find_files, {}) -- search for files by name
vim.keymap.set("n", "<leader>tfg", telescope.git_files, {}) -- search for git tracked files by name
vim.keymap.set("n", "<leader>tfs", telescope.live_grep, {}) -- search for strings

vim.keymap.set("n", "<C-a>", harpoon_mark.add_file) -- add file path to harpoon cache
vim.keymap.set("n", "<leader>htm", harpoon_ui.toggle_quick_menu) -- toggle harpoon window
