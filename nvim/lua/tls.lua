local tls = require "telescope"

tls.setup {
	preview = true,
	file_ignore_patterns = {
		"node_modules/",
		"target/",
		"build/",
		"zig-out/",
		"zig-cache/",
	},
	defaults = {
		-- Default configuration for telescope goes here:
		-- config_key = value,
		layout_strategy = "flex",
	},
	pickers = {
		-- cmdline = {
		-- 	picker = {
		-- 		layout_config = {
		-- 			width  = 120,
		-- 			height = 25,
		-- 		}
		-- 	},
		-- 	mappings = {
		-- 		complete      = '<Tab>',
		-- 		run_selection = '<C-CR>',
		-- 		run_input     = '<CR>',
		-- 	},
		-- },
		live_grep = {
			-- additional_args = function() return { "--max-depth=99", } end
			max_depth = 99,
		},
		colorscheme = {
			enable_preview = true,
		}
		-- Default configuration for builtin pickers goes here:
		-- picker_name = {
		--   picker_config_key = value,
		--   ...
		-- }
		-- Now the picker_config_key will be applied every time you call this
		-- builtin picker
	},
}
-- if TLS is lazy loaded
tls.load_extension("notify")
tls.load_extension("aerial")

local mod = '<tab>'

-- telescope
map('n', mod .. 'o', ':Telescope oldfiles<CR>', keymap_arg)
map('n', mod .. 'a', ':Telescope aerial<CR>', keymap_arg)
map('n', mod .. 'g', ':Telescope live_grep <CR>', keymap_arg)
map('n', mod .. 'b', ':Telescope current_buffer_fuzzy_find<cr>', keymap_arg)
map('n', mod .. 'c', ':Telescope git_commits<CR>', keymap_arg)
map('n', mod .. 'n', ':Telescope notify<cr>', keymap_arg)
map('n', mod .. 'd', ':Telescope diagnostics<cr>', keymap_arg)
map('n', mod .. 't', ':Telescope colorscheme<cr>', keymap_arg)

-- map('n', '<space>', ':Telescope cmdline<CR>', { noremap = true, desc = "Cmdline" })
-- map('n', mod .. 'f', ':Telescope find_files <CR>', keymap_arg)
-- map('n', mod .. 'b', ':Telescope buffers <CR>', keymap_arg)
-- map('n', mod .. 'o', ':Telescope live_grep grep_open_files=true <CR>', keymap_arg)
-- map('n', mod .. ';', ':Telescope git_stash<CR>', keymap_arg)
-- map('n', mod .. 'B', ':Telescope git_branches<CR>', keymap_arg)
-- map('n', mod .. '?', ':Telescope git_status<CR>', keymap_arg)
-- map('n', mod .. '\\', ':Telescope treesitter<cr>', keymap_arg)
-- map('n', mod .. '\\', ':Telescope lsp_document_symbols<cr>', keymap_arg)
-- map('n', mod .. 'o', ':Telescope oldfiles', keymap_arg)
