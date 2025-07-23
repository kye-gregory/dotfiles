local function scan_plugins()
	local plugins = {}
	local files = vim.fn.glob("~/.config/nvim/lua/plugins/**/*.lua", true, true)
	for _, file in ipairs(files) do
		local mod = file:match("lua/(.+)%.lua$"):gsub("/", ".")
		local ok, plugin = pcall(require, mod)
		if ok then
			table.insert(plugins, plugin)
		else
			vim.notify("Failed to load plugin: " .. mod, vim.log.levels.ERROR)
		end
	end
	return plugins
end

return scan_plugins
