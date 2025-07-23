local FileSize = {
	provider = function()
		local suffix = { "B", "kB", "MB", "GB", "TB" }
		local fsize = vim.fn.getfsize(vim.api.nvim_buf_get_name(0))
		fsize = (fsize < 0 and 0) or fsize

		if fsize < 1024 then
			return fsize .. suffix[1]
		end

		local i = math.min(math.floor(math.log(fsize) / math.log(1024)), #suffix - 1)
		local value = fsize / math.pow(1024, i)

		return string.format("%.2f%s", value, suffix[i + 1])
	end,
}

return FileSize
