local lualine_status, lualine = pcall(require, "lualine")
if not lualine_status then
	print("failed to import lualine in plugins/ui.lua")
	return
end

local nightfox_status, nightfox = pcall(require, "nightfox")
if not nightfox_status then
	print("failed to import nightfox in plugins/ui.lua")
	return
end

-- -----
-- config
-- -----
lualine.setup({
	options = {
		icons_enabled = true,
		-- theme = "wombat",
		theme = "material",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {
			statusline = {},
			winbar = {},
		},
		ignore_focus = {},
		always_divide_middle = true,
		globalstatus = false,
		refresh = {
			statusline = 1000,
			tabline = 1000,
			winbar = 1000,
		},
	},
	sections = {
		-- lualine_a = { "mode" },
		lualine_a = {},
		lualine_b = { { "branch" }, { "diagnostics" } },
		lualine_c = { "diff" },
		lualine_x = {},
		lualine_y = {},
		lualine_z = {},
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {
		lualine_a = { "fileformat" },
		lualine_b = { "encoding", "filetype" },
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = {},
	},
	winbar = {
		lualine_a = { {
			"mode",
			icons_anebled = true,
			padding = 3,
		} },
		lualine_b = {
			{
				-- https://github.com/nvim-lualine/lualine.nvim#filename-component-options
				"filename",
				file_status = true,
				newfile_status = true,
				path = 1,
				symbols = {
					modified = "[+]", -- Text to show when the file is modified.
					readonly = "[-]", -- Text to show when the file is non-modifiable or readonly.
					unnamed = "[No Name]", -- Text to show for unnamed buffers.
					newfile = "[New]", -- Text to show for newly created file before first write
				},
			},
		},
		lualine_c = {},
		lualine_x = {},
		lualine_y = { {
			"progress",
		} },
		lualine_z = { {
			"location",
		} },
		inactive_winbar = {},
		extensions = {},
	},
	inactive_winbar = {
		lualine_a = { {
			"mode",
			icons_anebled = true,
			padding = 3,
		} },
		lualine_b = {
			{
				-- https://github.com/nvim-lualine/lualine.nvim#filename-component-options
				"filename",
				file_status = true,
				newfile_status = true,
				path = 1,
				symbols = {
					modified = "[+]", -- Text to show when the file is modified.
					readonly = "[-]", -- Text to show when the file is non-modifiable or readonly.
					unnamed = "[No Name]", -- Text to show for unnamed buffers.
					newfile = "[New]", -- Text to show for newly created file before first write
				},
			},
		},
		lualine_c = {},
		lualine_x = {},
		lualine_y = { {
			"progress",
		} },
		lualine_z = { {
			"location",
		} },
		inactive_winbar = {},
		extensions = {},
	},
})

nightfox.setup({
	options = {
		dim_inactive = true,
		styles = {
			comments = "italic",
			keywords = "bold",
			types = "italic,bold",
		},
	},
})
