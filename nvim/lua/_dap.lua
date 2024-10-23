-- -- -- -- -- -- -- -
-- nvim-dap - start --
-- -- -- -- -- -- -- -
local dap = require "dap"

--rust / c
dap.adapters.gdb = {
	type = "executable",
	command = "gdb",
	args = { "-i", "dap" }
}

dap.configurations.c = {
	{
		name = "Launch",
		type = "gdb",
		request = "launch",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		cwd = "${workspaceFolder}",
	},
}

dap.configurations.rust = {
	{
		name = "Launch",
		type = "gdb",
		request = "launch",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		cwd = "${workspaceFolder}",
	},
}

--golang
dap.adapters.delve = {
	type = "server",
	port = "38697",
	executable = {
		command = "dlv",
		args = { "dap", "-l", "127.0.0.1:38697" },
	}
}

dap.configurations.go = {
	{
		type = "delve",
		name = "Debug",
		request = "launch",
		showLog = false,
		program = "${file}",
	},
	{
		type = "delve",
		name = "Debug test",
		request = "launch",
		mode = "test",
		program = "${file}"
	},
	{
		type = "delve",
		name = "Debug test (go.mod)",
		request = "launch",
		mode = "test",
		program = "./${relativeFileDirName}"
	}
}

-- haskell
dap.adapters.haskell = {
	type = 'executable',
	command = 'haskell-debug-adapter',
	args = { '--hackage-version=0.0.33.0' },
}

dap.configurations.haskell = {
	{
		type = 'haskell',
		request = 'launch',
		name = 'Debug',
		workspace = '${workspaceFolder}',
		startup = "${file}",
		stopOnEntry = true,
		logFile = vim.fn.stdpath('data') .. '/haskell-dap.log',
		logLevel = 'WARNING',
		ghciEnv = vim.empty_dict(),
		ghciPrompt = "λ: ",
		-- Adjust the prompt to the prompt you see when you invoke the stack ghci command below
		ghciInitialPrompt = "λ: ",
		ghciCmd = "stack ghci --test --no-load --no-build --main-is TARGET --ghci-options -fprint-evld-with-show",
	},
}

-- TODO: dap commands; require'dap'.step_over(), continue(), eval(), toggle_breakpoint()...
-- TODO: dapui commands
-- map('n', '<c-cr>', ':lua require("dapui").setup()<cr>', keymap_arg)
map('n', '<a-\\>', ':lua require("dapui").toggle()<cr>', keymap_arg)

-- return function()
require('dapui').setup()


map('n', '<a-b>', ':lua require("dap").toggle_breakpoint()<cr>', keymap_arg)
map('n', '<a-c>', ':lua require("dap").continue()<cr>', keymap_arg)
map('n', '<a-o>', ':lua require("dap").step_over()<cr>', keymap_arg)
map('n', '<a-i>', ':lua require("dap").step_into()<cr>', keymap_arg)
map('n', '<a-r>', ':lua require("dap").repl.open()<cr>', keymap_arg)
map('n', '<a-l>', ':lua require("dap").repl.close()<cr>', keymap_arg)

--
-- 	local dap, dapui = require("dap"), require("dapui")
-- 	dap.listeners.after.event_initialized["dapui_config"] = function()
-- 		dapui.open({})
-- 	end
-- 	dap.listeners.before.event_terminated["dapui_config"] = function()
-- 		dapui.close({})
-- 	end
-- 	dap.listeners.before.event_exited["dapui_config"] = function()
-- 		dapui.close({})
-- 	end
-- end
