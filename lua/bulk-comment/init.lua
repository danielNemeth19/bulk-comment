table.unpack = table.unpack or unpack
local M = {}

local Commenter = require("bulk-comment.commenter")

M.get_file_type = function ()
	local filetype = vim.bo.filetype
	M['type'] = filetype
	local commenter = Commenter:new(filetype)
	if commenter.symbol then
		print("We'll have work to do")
		commenter:toggle_comment()
	else
		print("Not yet supported: ".. filetype .. commenter.symbol)
	end
end


return M
