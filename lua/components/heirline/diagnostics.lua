local conditions = require("heirline.conditions")
local Diagnostics = {

	condition = conditions.has_diagnostics,

	-- Fetching custom diagnostic icons
	static = {},

	init = function(self)
		self.error_icon = vim.diagnostic.config()["signs"]["text"][vim.diagnostic.severity.ERROR]
		self.warn_icon = vim.diagnostic.config()["signs"]["text"][vim.diagnostic.severity.WARN]
		self.info_icon = vim.diagnostic.config()["signs"]["text"][vim.diagnostic.severity.INFO]
		self.hint_icon = vim.diagnostic.config()["signs"]["text"][vim.diagnostic.severity.HINT]

		self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
		self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
		self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
		self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
	end,

	update = { "DiagnosticChanged", "BufEnter" },

	{
		provider = function(self)
			-- 0 is just another output, we can decide to print it or not!
			return self.errors > 0 and (self.error_icon .. self.errors .. " ")
		end,
		hl = { fg = "red" },
	},
	{
		provider = function(self)
			return self.warnings > 0 and (self.warn_icon .. self.warnings .. " ")
		end,
		hl = { fg = "yellow" },
	},
	{
		provider = function(self)
			return self.info > 0 and (self.info_icon .. self.info .. " ")
		end,
		hl = { fg = "blue" },
	},
	{
		provider = function(self)
			return self.hints > 0 and (self.hint_icon .. self.hints .. " ")
		end,
		hl = { fg = "green" },
	},
}

return Diagnostics
