require("nvim-tree").setup({
	filters = {
		dotfiles = false,
	},
	respect_buf_cwd = false,
	update_focused_file = {
		enable = true,
	},
	renderer = {
		-- highlight_opened_files = "none",
		root_folder_label = false,
		indent_markers = {
			enable = true,
		},
		icons = {
			show = {
				file = true,
				folder = true,
				folder_arrow = true,
				git = false,
			}

		}
	},
	-- open_on_setup = true,
	git = {
		enable = true,
		ignore = false,
	},
	filesystem_watchers = {
		enable = true,
	},
	diagnostics = {
		enable = true,
		icons = {
			hint = "",
			info = "",
			warning = "",
			error = "",
		},
	},
	hijack_netrw = true,
	disable_netrw = true,
	hijack_cursor = true,
	view = {
		adaptive_size = true,
		width = 20,
		-- hide_root_folder = false,
		side = "left",
		-- mappings = {
		-- 	custom_only = false,
		-- 	list = {},
		-- },
		number = false,
		relativenumber = false,
		signcolumn = "yes",
		float = {
			enable = false,
			quit_on_focus_loss = false,
			open_win_config = {
				relative = "editor",
				border = "rounded",
				width = 30,
				height = 30,
				row = 1,
				col = 1,
			},
		},
	},
})

vim.cmd([[
autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif
]])

local nvim_tree_events = require("nvim-tree.events")
local bufferline_api = require("bufferline.api")

local function get_tree_size()
	return require("nvim-tree.view").View.width
end

nvim_tree_events.subscribe("TreeOpen", function()
	bufferline_api.set_offset(get_tree_size())
end)

nvim_tree_events.subscribe("Resize", function()
	bufferline_api.set_offset(get_tree_size())
end)

nvim_tree_events.subscribe("TreeClose", function()
	bufferline_api.set_offset(0)
end)
