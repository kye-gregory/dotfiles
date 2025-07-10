local conditions = require("heirline.conditions")
local GitBranch = {
	condition = conditions.is_git_repo,

	init = function(self)
		self.status_dict = vim.b.gitsigns_status_dict
	end,

	provider = function(self)
		return self.status_dict.head
	end,

	hl = { bold = true },
}
return GitBranch
