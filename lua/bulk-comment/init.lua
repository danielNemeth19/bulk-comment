local M = {}

local commentMap = {
	lua = "--",
	python = "# ",
	go = "//"
}

M.get_file_type = function ()
	local type = vim.bo.filetype
	M['type'] = type
	if commentMap[type] then
		M['comment_string'] = commentMap[type]
		print("type is ".. M["comment_string"])
		local line = vim.api.nvim_get_current_line()
		print("line is ".. line)
		local pos = vim.fn.getpos('.')
		local rn, col = pos[2], pos[3]
		print("row ".. rn, "col: ".. col)
	else
		print("type is ".. type)
	end
end



return M
