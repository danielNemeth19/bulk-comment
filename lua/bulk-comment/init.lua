local M = {}

local Commenter = require("bulk-comment.commenter")

M.get_file_type = function ()
	local filetype = vim.bo.filetype
	M['type'] = filetype
	local commenter = Commenter:new(filetype)
	if commenter.symbol then
		commenter:toggle_comment()
	else
		print("Not yet supported: ".. filetype)
	end
end

return M
