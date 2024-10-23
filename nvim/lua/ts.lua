require "nvim-treesitter-textobjects"
require "nvim-treesitter-textsubjects"
require "nvim-treesitter.configs".setup {
	ignore_install = {},
	modules = {},
	diagnostics = { disable = { "missing-fields" } },

	ensure_installed = { "c", "lua", "query", "heex", "vim", "vimdoc", "comment", "elixir", "bash", "markdown", "regex", "rust",
		"typescript", "gleam", "javascript", "css", "html", "go", "ocaml", "zig" },

	sync_install = false,

	auto_install = true,

	highlight = {
		additional_vim_regex_highlighting = false,
		enable = true,
	},

	indent = { enable = true },

	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<leader>q",
			node_incremental = "<leader>]",
			scope_incremental = false,
			node_decremental = "<leader>[",
		}
	},
	autopairs = { enable = true },
	autotag = { enable = true },
	context_commentstring = { enable = true, enable_autocmd = true },
	textobjects = {
		lsp_interop = { enable = true },
		select = {
			enable = true,
			keymaps = {
				["al"] = "@loop.outer",
				["il"] = "@loop.inner",
				["ab"] = "@block.outer",
				["ib"] = "@block.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ap"] = "@parameter.outer",
				["ip"] = "@parameter.inner",
				["ak"] = "@comment.outer",
				["ik"] = "@comment.inner",
			},
		},
		swap = {
			enable = true,
			swap_next = {
				["<Leader>cs"] = "@parameter.inner",
			},
			swap_previous = {
				["<Leader>sc"] = "@parameter.inner",
			},
		},
		move = {
			enable = true,
			set_jumps = true,
			goto_next_start = { ["]]"] = "@function.outer" },
			goto_next_end = { ["]}"] = "@function.outer" },
			goto_previous_start = { ["[["] = "@function.outer" },
			goto_previous_end = { ["[{"] = "@function.outer" },
		},
	},
	textsubjects = {
		enable = true,
		prev_selection = ',', -- (Optional) keymap to select the previous selection
		keymaps = {
			['<leader><leader>'] = 'textsubjects-smart',
			['<leader-a>'] = 'textsubjects-container-outer',
			['<leader-i>'] = { 'textsubjects-container-inner', desc = "Select inside containers (classes, functions, etc.)" },
		},
	},
}
