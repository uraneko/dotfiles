-- modifier key
local mod = '<esc>'

-- substitute
map('n', mod .. 's', ':%s/', keymap_arg)
map('v', mod .. 's', ':s/', keymap_arg)

-- esc
map('t', '<esc>', '<c-Bslash><c-n>', keymap_arg)
-- map('i', mod .. 'z>', '<ESC>', keymap_arg)
-- map('v', mod .. 'z>', '<ESC>', keymap_arg)
-- map('c', mod .. 'z>', '<c-c>', keymap_arg)
-- map('o', mod .. 'z>', '<esc>', keymap_arg)

-- new terminal
map('n', mod .. '<t>', ':terminal<cr>', keymap_arg)

-- netrw
map('n', mod .. 'e', ':Explore <CR><cr>', keymap_arg)

map('n', mod .. 'w', ':up<cr>', keymap_arg)
map('n', mod .. 'd', ':bd<cr>', keymap_arg)
map('n', mod .. '<Right>', ':bn<cr>', keymap_arg)
map('n', mod .. '<Left>', ':bp<cr>', keymap_arg)

-- command
map("n", "<space>", ":")
map("v", "<space>", ":")

-- insert break
-- map('i', '<End>', '<C-o>', keymap_arg)

--map({'n', 'v'}, mod .. 'n>', M.StepUp, keymap_arg)
--map({'n', 'v'}, mod .. 'm>', M.StepDown, keymap_arg)

-- view mode move count from the first line in selection

-- insert new line from normal mode
-- map('n', 'j', 'o<esc>', keymap_arg)
-- map('n', 'J', 'O<esc>', keymap_arg)

-- copy to clipboard
map('v', mod .. 'y', ":'<,'>:w !bat | wl-copy<cr><cr>", keymap_arg)

-- pane control
-- map('n', 'z', '<c-w>', keymap_arg)
map('n', 'zv', '<c-w>v', keymap_arg)
map('n', 'zs', '<c-w>s', keymap_arg)
map('n', 'zx', '<c-w>q', keymap_arg)
map('n', '<s-z>', '<c-w>w', keymap_arg)
map('n', 'z<Right>', '<c-w>l', keymap_arg)
map('n', 'z<left>', '<c-w>h', keymap_arg)
map('n', 'z<up>', '<c-w>k', keymap_arg)
map('n', 'z<down>', '<c-w>j', keymap_arg)

-- leavepre = function()
-- 	package.loaded.lspconfig = nil
-- end
--
-- local fbuftype = vim.bo.buftype -- this nullifies my c-z binding
--
-- vim.cmd("autocmd VimLeavePre * call leavepre()")
--
-- -- NOTE: :int(roduction) command
--
-- -- load opt module
-- function opt_loader(name)
--     vim.cmd("packadd " .. name)
--     require name
--     require mod_reflector(name)
-- end
--
-- -- reflector for configs from opt plugin names
-- function mod_reflector(name)
--     if name == "ale" or name == "lsp-config" then
-- 	return "lsp"
--     else if name == "nvim-dap" then
-- 	return "dap"
--     else if name == "pigments" then
-- 	return load_additional_pigments()
--     end
-- end
