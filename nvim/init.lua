-- NOTE: operators can take the normal search '/' as movement
-- NOTE: i in V Mode acts kinda the same as f in N Mode
-- TODO: plugins should be imported by importance
-- ie, if you want Comment plugin no matter what,
-- then dont put it after stt plugin import that you might break later

-- backstage plugins: nui, nio, web-dev-icons, plenary, codeicons,
-- workspace plugins: notify, fidget, gitsigns, tls, fine-cmd, tls-cmd,
-- in-buffer plugins: ufo, bqf, comment, surround, aerial,
-- on-buffer plugins: lsp-config, lsp-format, lsp-lint, navic, ts, ts-ts, ts-to, dap, dap-ui, sttusline

-- set leaders
vim.g.leader = "`"
vim.g.localleader = "<"

-- convenient variable
keymap_arg = { noremap = true, silent = false }
map = vim.keymap.set
inspect = vim.inspect

-- allegedly enhances plugins load times
vim.loader.enable()

require "core:options"
require "core:bindings"

require "plenary.async"
vim.notify = require "fidget".setup {}
vim.notify = require "notify"
vim.notify.setup {
	background_colour = "#000000",
}


require "_gitsigns"
require "comment"
require "_aerial"
require "lsp"
require "nio" -- dep for dap-ui
require "_dap"
-- require "nvim-ts-autotag".setup()
require "tls"
require "ts"
require "themes"
require "statusline"
