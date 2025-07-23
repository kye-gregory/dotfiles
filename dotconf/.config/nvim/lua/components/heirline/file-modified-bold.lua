local FileModifiedBold = {
	hl = function()
		if vim.bo.modified then
			return { bold = true, force = true }
		end
	end,
}

return FileModifiedBold
