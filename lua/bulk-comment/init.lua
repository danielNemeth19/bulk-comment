local M = {}

M.get_file_type = function ()
	local myType = vim.bo.filetype
	M['type'] = myType
	if myType == "lua" then
		print("this is a lua file")
		M['comment_string'] = "--"
	elseif myType == "python" then
		print("this is a python file")
		M['comment_string'] = "#"
	end
end


M.get_file_type()
P(M)

return M
