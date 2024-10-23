-- NOTE: require navic if you havent required it globally somewhere else
-- local navic = require "nvim-navic"
-- NOTE: likewise, require gitsigns if it's not globally available
-- require "gitsigns".setup {}

local cwd = vim.fn.getcwd()

-- hi
function hi()
	-- buf-modified
	vim.cmd("hi bM guibg=#3c392d guifg=#e596ab gui=bold")

	-- buf-num
	vim.cmd("hi bnS guibg=#3c392d guifg=#538ac3")
	vim.cmd("hi bnB guibg=#3c392d guifg=#6fc1f7")
	vim.cmd("hi bnN guibg=#3c392d guifg=#6fc1f7")

	-- cursor-pos
	vim.cmd("hi crsC guibg=#3c392d guifg=#89c189")
	vim.cmd("hi crsS1 guibg=#3c392d guifg=#538a53")
	vim.cmd("hi crsR guibg=#3c392d guifg=#89c189")
	vim.cmd("hi crsS2 guibg=#3c392d guifg=#538a53")
	vim.cmd("hi crsAR guibg=#3c392d guifg=#89c189")

	-- file-name
	vim.cmd("hi fN guibg=#3c392d guifg=#fb6e80")

	-- file-type
	vim.cmd("hi fT guibg=#3c392d guifg=#e596ab")

	-- filler
	vim.cmd("hi filler guibg=#3c392d")

	-- git-branch
	vim.cmd("hi gB guibg=#3c392d guifg=#f24989")

	-- git-diff
	vim.cmd("hi gA guibg=#3c392d guifg=#64d175")
	vim.cmd("hi gR guibg=#3c392d guifg=#d23c48")
	vim.cmd("hi gM guibg=#3c392d guifg=#ea7f00")

	-- lsp-diagnostics
	vim.cmd("hi lspI guibg=#3c392d guifg=#64d175")
	vim.cmd("hi lspE guibg=#3c392d guifg=#d23c48")
	vim.cmd("hi lspW guibg=#3c392d guifg=#ea7f00")
	vim.cmd("hi lspH guibg=#3c392d guifg=#0f97a6")

	-- lsp-server
	vim.cmd("hi lspS guibg=#3c392d guifg=#f24989")

	-- mode
	vim.cmd("hi mN guibg=#3c392d guifg=#e5286e gui=bold,italic")
	vim.cmd("hi mI guibg=#3c392d guifg=#c0a789 gui=bold,italic")
	vim.cmd("hi mV guibg=#3c392d guifg=#6a4da1 gui=bold,italic")
	vim.cmd("hi mR guibg=#3c392d guifg=#64a783 gui=bold,italic")
	vim.cmd("hi mC guibg=#3c392d guifg=#c0e183 gui=bold,italic")
	vim.cmd("hi mT guibg=#3c392d guifg=#c07983 gui=bold,italic")
	-- select mode
	vim.cmd("hi mS guibg=#3c392d guifg=#c0cfd4 gui=bold,italic")
	-- confirm (prompt) mode
	vim.cmd("hi mP guibg=#3c392d guifg=#723b53 gui=bold,italic")

	-- navic
	vim.cmd("hi nvcC guibg=#3c392d guifg=#b0bcd3")
	vim.cmd("hi nvcS guibg=#3c392d guifg=#748097")
end

hi()

local vim_modes = {
	["n"] = { "NORMAL", "N" },
	["no"] = { "NORMAL (no)", "N" },
	["nov"] = { "NORMAL (nov)", "N" },
	["noV"] = { "NORMAL (noV)", "N" },
	["noCTRL-V"] = { "NORMAL", "N" },
	["niI"] = { "NORMAL i", "N" },
	["niR"] = { "NORMAL r", "N" },
	["niV"] = { "NORMAL v", "N" },

	["nt"] = { "TERMINAL", "T" },
	["ntT"] = { "TERMINAL (ntT)", "T" },

	["v"] = { "VISUAL", "V" },
	["vs"] = { "V-CHAR (Ctrl O)", "V" },
	["V"] = { "V-LINE", "V" },
	["Vs"] = { "V-LINE", "V" },
	[""] = { "V-BLOCK", "V" },

	["i"] = { "INSERT", "I" },
	["ic"] = { "INSERT (completion)", "I" },
	["ix"] = { "INSERT completion", "I" },

	["t"] = { "TERMINAL", "T" },
	["!"] = { "SHELL", "T" },

	["R"] = { "REPLACE", "R" },
	["Rc"] = { "REPLACE (Rc)", "R" },
	["Rx"] = { "REPLACEa (Rx)", "R" },
	["Rv"] = { "V-REPLACE", "R" },
	["Rvc"] = { "V-REPLACE (Rvc)", "R" },
	["Rvx"] = { "V-REPLACE (Rvx)", "R" },

	["s"] = { "SELECT", "S" },
	["S"] = { "S-LINE", "S" },
	[""] = { "S-BLOCK", "S" },

	["c"] = { "COMMAND", "C" },
	["cv"] = { "COMMAND", "C" },
	["ce"] = { "COMMAND", "C" },

	["r"] = { "PROMPT", "P" },
	["rm"] = { "MORE", "P" },
	["r?"] = { "CONFIRM", "P" },
	["x"] = { "CONFIRM", "P" },
}

local components = {
	buf_modified = function()
		-- if vim.cmd("echo getbufvar('%', '&mod')") == "1" then
		if vim.api.nvim_buf_get_option(0, "modified") then
			return "%#bM#۞ "
		else
			return ""
		end
	end,
	buf_num = function()
		return "%#bnB#b" .. "%#bnS#'" .. "%#bnN#%n "
	end,
	cursor_pos = function()
		local pos = vim.api.nvim_win_get_cursor(0)
		return "%#crsC#" .. pos[2] ..
			"%#crsS1#" .. ":" ..
			"%#crsR#" .. pos[1] ..
			"%#crsS2#" .. "/" ..
			"%#crsAR#" .. "%L" .. " "
	end,
	file_name = function()
		local ft = vim.api.nvim_buf_get_option(0, "filetype")
		if ft == "netrw" then
			local curdir = vim.b.netrw_curdir:gsub(cwd, "")
			return "%#fN#" .. curdir
		else
			local ro = vim.bo.readonly
			local filename = vim.fn.expand("%:.")
			if ro then
				return "%#fN#" .. "[YouDontHaveTheRight]"
			elseif filename == "" then
				return "%#fN#" .. "[AWildBufferAppears]"
			else
				return "%#fN#" .. filename
			end
		end
	end,
	file_type = function()
		local filetype = vim.api.nvim_buf_get_option(0, "filetype")
		if filetype == "" then
			return "%#fN#… "
		else
			return "%#fN#" .. filetype .. " "
		end
	end,
	filler = function()
		return "%#filler#" .. "%="
	end,
	git_branch = function()
		local branch = vim.b.gitsigns_status_dict
		if branch ~= nil and branch ~= "" then
			return "%#gB# " .. branch.head
		else
			return ""
		end
	end,
	git_diff = function()
		local git = vim.b.gitsigns_status_dict
		if git ~= nil then
			local added = git.added
			local removed = git.removed
			local modified = git.changed
			local gs = ""

			if added ~= nil and added > 0 then
				gs = gs .. "%#gA# " .. added .. " "
			end
			if modified ~= nil and modified > 0 then
				gs = gs .. "%#gM# " .. modified .. " "
			end
			if removed ~= nil and removed > 0 then
				gs = gs .. "%#gR# " .. removed .. " "
			end

			return gs
		else
			return ""
		end
	end,
	lsp_diagnostics = function()
		local d     = vim.diagnostic
		local error = #d.get(0, { severity = d.severity.ERROR })
		local warn  = #d.get(0, { severity = d.severity.WARN })
		local info  = #d.get(0, { severity = d.severity.INFO })
		local hint  = #d.get(0, { severity = d.severity.HINT })

		local ds    = " "

		if error > 0 then
			ds = ds .. "%#lspE#" .. " " .. error .. " "
		end
		if warn > 0 then
			ds = ds .. "%#lspW#" .. " " .. warn .. " "
		end
		if info > 0 then
			ds = ds .. "%#lspI#" .. " " .. info .. " "
		end
		if hint > 0 then
			ds = ds .. "%#lspH#" .. " " .. hint
		end

		return ds
	end,
	lsp_server = function()
		local lsp = vim.lsp.get_clients()
		if #lsp ~= 0 then
			if lsp[1] ~= nil then
				local server = lsp[1].name
				return "%#lspS#🕮" .. server .. " "
			end
		else
			return ""
		end
	end,
	navic = function()
		if #vim.lsp.get_clients() ~= 0 then
			local data = navic.get_data()

			if data ~= nil then
				local processed = ""
				for _, data in ipairs(data) do
					processed = processed ..
						"%#nvcC#" .. data.icon ..
						data.name .. "%#nvcS#" .. " -> "
				end

				return processed:sub(0, #processed - 4)
			end
		else
			return ""
		end
	end,
	mode = function()
		local mode = vim_modes[vim.api.nvim_get_mode().mode]
		local hl = mode[2]
		local code = mode[1]
		--
		return '%#m' .. hl .. "#." .. code .. " "
	end
}

local sl = {
	["buf-modified"] = components.buf_modified(),
	["buf-num"] = components.buf_num(),
	["cursor-pos"] = components.cursor_pos(),
	["file-name"] = components.file_name(),
	["file-type"] = components.file_type(),
	["filler"] = components.filler(),
	["git-branch"] = components.git_branch(),
	["git-diff"] = components.git_diff(),
	["lsp-diagnostics"] = components.lsp_diagnostics(),
	["lsp-server"] = components.lsp_server(),
	["navic"] = components.navic(),
	["mode"] = components.mode(),
}


function sl_()
	return string.format("%s %s %s %s %s %s %s %s %s %s %s %s %s",
		sl["mode"], sl["file-name"], sl["buf-modified"],
		sl["git-branch"], sl["git-diff"], sl["lsp-diagnostics"], sl["lsp-server"],
		sl["filler"], sl["navic"], sl["filler"],
		sl["file-type"], sl["buf-num"], sl["cursor-pos"])
end

sl_()

local gitb = function()
	local git = vim.b.gitsigns_status_dict
	local gb = ""
	if git ~= nil then
		local branch = git.head
		if branch ~= nil then
			gb = "%#gB# " .. branch
		end
	end

	if sl["git-branch"] ~= gb then
		sl["git-branch"] = gb
	end

	vim.opt.statusline = sl_()
end

local gitd = function()
	local git = vim.b.gitsigns_status_dict
	local gd = ""
	if git ~= nil then
		local added = git.added
		local removed = git.removed
		local modified = git.changed
		local gs = ""

		if added ~= nil and added > 0 then
			gs = gs .. "%#gA# " .. added .. " "
		end
		if modified ~= nil and modified > 0 then
			gs = gs .. "%#gM# " .. modified .. " "
		end
		if removed ~= nil and removed > 0 then
			gs = gs .. "%#gR# " .. removed .. " "
		end

		gd = gs
	end

	if sl["git-diff"] ~= gd then
		sl["git-diff"] = gd
	end

	vim.opt.statusline = sl_()
end

vim.api.nvim_create_augroup("statusline", { clear = true })
function update()
	-- buf-modified
	vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter", "TextChangedI", "TextChanged", "BufWritePost" }, {
		desc = "buf-modified event hook",
		group = "statusline",
		callback = function()
			-- if vim.cmd("echo getbufvar('%', '&mod')") == "1" then
			local bm = ""
			if vim.api.nvim_buf_get_option(0, "modified") then
				bm = "%#bM#۞ "
			end
			if sl["buf-modified"] ~= bm then
				sl["buf-modified"] = bm
			end
			vim.opt.statusline = sl_()
		end,
	})

	-- buf-num
	vim.api.nvim_create_autocmd({ "BufEnter" }, {
		desc = "buf-num event hook",
		group = "statusline",
		callback = function()
			local bn = "%#bnB#" .. "b" .. "%#bnS#'" .. "%#bnN#%n" .. " "
			if sl["buf-num"] ~= bn then
				sl["buf-num"] = bn
			end
			vim.opt.statusline = sl_()
		end,
	})

	-- cursor-pos
	vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
		desc = "cursor-pos event hook",
		group = "statusline",
		callback = function()
			local pos = vim.api.nvim_win_get_cursor(0)
			local cp = "%#crsC#" .. pos[2] ..
				"%#crsS1#" .. ":" ..
				"%#crsR#" .. pos[1] ..
				"%#crsS2#" .. "/" ..
				"%#crsAR#" .. "%L" .. " "
			if sl["cursor-pos"] ~= cp then
				sl["cursor-pos"] = cp
			end
			vim.opt.statusline = sl_()
		end,
	})

	-- file-name
	vim.api.nvim_create_autocmd({ "BufEnter" }, {
		desc = "file-name event hook",
		group = "statusline",
		callback = function()
			local fn = ""
			local ft = vim.api.nvim_buf_get_option(0, "filetype")

			local ro = vim.bo.readonly
			local filename = vim.fn.expand("%:.")
			if ro then
				fn = "%#fN#" .. "[YouDontHaveTheRight]"
			elseif filename == "" then
				fn = "%#fN#" .. "[AWildBufferAppears]"
			else
				fn = "%#fN#" .. filename
			end

			if sl["file-name"] ~= fn then
				sl["file-name"] = fn
			end

			vim.opt.statusline = sl_()
		end,
	})


	-- files special
	vim.api.nvim_create_autocmd({ "BufEnter", "FileType" }, {
		desc = "file-name event hook",
		group = "statusline",
		pattern = { "netrw", "TelescopePrompt", "qf" },
		callback = function()
			local fn = ""
			local ft = vim.api.nvim_buf_get_option(0, "filetype")
			if ft == "netrw" then
				local curdir = vim.b.netrw_curdir:gsub(cwd, "")
				fn = "%#fN#" .. curdir
			else
				local ro = vim.bo.readonly
				local filename = vim.fn.expand("%:.")
				if ro then
					fn = "%#fN#" .. "[YouDontHaveTheRight]"
				elseif filename == "" then
					fn = "%#fN#" .. "[AWildBufferAppears]"
				else
					fn = "%#fN#" .. filename
				end
			end

			if sl["file-name"] ~= fn then
				sl["file-name"] = fn
			end

			local fity = ""
			if ft == "" then
				fity = "%#fN#… "
			elseif ft == "qf" then
				fity = "%#fN#quickfix "
			else
				fity = "%#fN#" .. ft .. " "
			end

			if sl["file-type"] ~= fity then
				sl["file-type"] = fity
			end

			vim.opt.statusline = sl_()
		end,
	})

	-- file-type
	vim.api.nvim_create_autocmd({ "BufEnter" }, {
		desc = "file-type event hook",
		group = "statusline",
		callback = function()
			local filetype = vim.api.nvim_buf_get_option(0, "filetype")
			local ft = ""
			if filetype == "" then
				ft = "%#fN#… "
			else
				ft = "%#fN#" .. filetype .. " "
			end

			if sl["file-type"] ~= ft then
				sl["file-type"] = ft
			end

			vim.opt.statusline = sl_()
		end,
	})

	-- git-branch
	vim.api.nvim_create_autocmd({ "BufEnter", "VimResized" }, {
		desc = "git-branch event hook",
		group = "statusline",
		callback = function()
			local timer = vim.loop.new_timer()
			timer:start(200, 0, vim.schedule_wrap(gitb))
		end,
	})

	-- git-diff
	vim.api.nvim_create_autocmd({ "BufEnter", "VimResized", "BufWritePost" }, {
		desc = "git-diff event hook",
		group = "statusline",
		callback = function()
			local timer = vim.loop.new_timer()
			timer:start(200, 0, vim.schedule_wrap(gitd))
		end,
	})

	-- lsp-diagnostics
	vim.api.nvim_create_autocmd({ "BufEnter", "DiagnosticChanged" }, {
		desc = "lsp-diagnostics event hook",
		group = "statusline",
		callback = function()
			local ld    = ""
			local d     = vim.diagnostic
			local error = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
			local warn  = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
			local info  = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
			local hint  = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })

			if d ~= nil then
				local ds = " "

				if error > 0 then
					ds = ds .. "%#lspE#" .. " " .. error .. " "
				end
				if warn > 0 then
					ds = ds .. "%#lspW#" .. " " .. warn .. " "
				end
				if info > 0 then
					ds = ds .. "%#lspI#" .. " " .. info .. " "
				end
				if hint > 0 then
					ds = ds .. "%#lspH#" .. " " .. hint
				end
				ld = ds
			end

			if sl["lsp-diagnostics"] ~= ld then
				sl["lsp-diagnostics"] = ld
			end

			vim.opt.statusline = sl_()
		end,
	})

	-- lsp-server
	vim.api.nvim_create_autocmd({ "LspAttach", "LspDetach", "BufEnter", "VimResized" }, {
		desc = "lsp-server event hook",
		group = "statusline",
		callback = function()
			local lsp = vim.lsp.get_clients()
			local ls = ""
			if #lsp ~= 0 then
				if lsp[1] ~= nil then
					local server = lsp[1].name
					ls = "%#lspS#🕮" .. server .. " "
				end
			end

			if sl["lsp-server"] ~= ls then
				sl["lsp-server"] = ls
			end

			vim.opt.statusline = sl_()
		end,
	})

	-- navic
	-- FIXME: navic does not update in insert mode
	vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI", "CursorMovedC", }, {
		desc = "navic event hook",
		group = "statusline",
		callback = function()
			local nvc = ""
			if #vim.lsp.get_clients() ~= 0 then
				local data = navic.get_data()

				if data ~= nil then
					local processed = ""
					for _, data in ipairs(data) do
						processed = processed ..
							"%#nvcC#" .. data.icon ..
							data.name .. "%#nvcS#" .. " -> "
					end

					nvc = processed:sub(0, #processed - 4)
				end
			end

			if sl["navic"] ~= nvc then
				sl["navic"] = nvc
			end

			vim.opt.statusline = sl_()
		end,
	})

	-- vim mode
	vim.api.nvim_create_autocmd({ "ModeChanged", "VimResized" }, {
		desc = "vim mode event hook",
		group = "statusline",
		callback = function()
			local mode = vim_modes[vim.api.nvim_get_mode().mode]
			local vm = "%#mP#???"

			if mode ~= nil then
				local hl = mode[2]
				local code = mode[1]
				--
				vm = '%#m' .. hl .. "#." .. code .. " "
			end

			if sl["mode"] ~= vm then
				sl["mode"] = vm
			end

			vim.opt.statusline = sl_()
		end,
	})
end

update()

-- restores hi groups after theme change
vim.api.nvim_create_autocmd({ "ColorScheme" }, {
	desc = "colorscheme change hi restoration",
	group = "statusline",
	callback = function()
		hi()
		vim.opt.background = "dark"
	end,
})
