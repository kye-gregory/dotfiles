local ViMode = {
	init = function(self)
		self.mode = vim.fn.mode(1) -- :h mode()
	end,
	static = {
		mode_names = {
			-- Normal modes
			n = "Normal",
			no = "Normal",
			nov = "Normal",
			noV = "Normal",
			["no\22"] = "Normal",
			niI = "Normal",
			niR = "Normal",
			niV = "Normal",
			nt = "Normal",

			-- Visual modes
			v = "Visual",
			vs = "Visual",
			V = "Visual",
			Vs = "Visual",
			["\22"] = "Visual",

			-- Select modes
			["\22s"] = "Select",
			s = "Select",
			S = "Select",
			["\19"] = "Select",

			-- Insert modes
			i = "Insert",
			ic = "Insert",
			ix = "Insert",

			-- Replace modes
			R = "Replace",
			Rc = "Replace",
			Rx = "Replace",
			Rv = "Replace",
			Rvc = "Replace",
			Rvx = "Replace",

			-- Command-line mode
			c = "Command",

			-- Ex mode
			cv = "Ex",

			-- Prompt modes
			r = "...",
			rm = "More",
			["r?"] = "Confirm",

			-- Shell mode
			["!"] = "Shell",

			-- Terminal mode
			t = "Terminal",
		},
		mode_colors = {
			n = "red",
			i = "green",
			v = "cyan",
			V = "cyan",
			["\22"] = "cyan",
			c = "orange",
			s = "purple",
			S = "purple",
			["\19"] = "purple",
			R = "orange",
			r = "orange",
			["!"] = "red",
			t = "red",
		},
	},
	-- String Display
	provider = function(self)
		return "%2(" .. string.upper(self.mode_names[self.mode]) .. "%)"
	end,

	-- Highlight Group
	hl = function(self)
		local mode = self.mode:sub(1, 1) -- get only the first mode character
		return { fg = self.mode_colors[mode], bold = true }
	end,

	-- Update Callback
	update = {
		"ModeChanged",
		pattern = "*:*",
		callback = vim.schedule_wrap(function()
			vim.cmd("redrawstatus")
		end),
	},
}

return ViMode
