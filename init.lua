require("config.lazy")

-- Indent Spacing
vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")

-- Editor Apperance
vim.cmd("set number")
vim.opt.relativenumber = true
vim.cmd("set cursorline")
vim.cmd("set signcolumn=yes")

-- Diagnostic Symbols
vim.diagnostic.config({
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.INFO] = "󰋇",
			[vim.diagnostic.severity.HINT] = "󰌵",
		},
	},
})

-- Auto Set 'End Of Buffer' Character To Blank
vim.api.nvim_create_autocmd({ "BufWinEnter", "BufEnter", "ColorScheme" }, {
	callback = function()
		vim.opt.fillchars:append({ eob = " " })
	end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
	callback = function()
		(vim.hl or vim.highlight).on_yank()
	end,
})

-- Auto Delete Empty Buffers
vim.api.nvim_create_autocmd({ "BufLeave", "BufWinLeave" }, {
	callback = function(args)
		local bufnr = args.buf
		local bufname = vim.api.nvim_buf_get_name(bufnr)
		local is_modified = vim.api.nvim_buf_get_option(bufnr, "modified")
		local is_empty = bufname == ""

		-- Only delete if it's unnamed, not modified, and not a terminal or special buffer
		if is_empty and not is_modified and vim.api.nvim_buf_is_loaded(bufnr) then
			vim.schedule(function()
				if vim.api.nvim_buf_is_valid(bufnr) then
					vim.api.nvim_buf_delete(bufnr, { force = true })
				end
			end)
		end
	end,
})

-- Auto Create File Paths
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	callback = function(args)
		local file_path = vim.fn.expand("%:p")
		local dir_path = vim.fn.fnamemodify(file_path, ":h")

		if not vim.loop.fs_stat(dir_path) then
			os.execute("mkdir -p " .. dir_path)
		end
	end,
})

-- Auto Format on Save
vim.api.nvim_create_autocmd("BufWritePre", {
	callback = function()
		vim.lsp.buf.format({ async = false })
	end,
})
