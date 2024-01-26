table.unpack = table.unpack or unpack
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
		local line = vim.api.nvim_get_current_line()
		--print("line is ".. line)
		--local rn, col = table.unpack(vim.api.nvim_win_get_cursor(0))
		--print("row ".. rn, "col: ".. col)
		--vim.api.nvim_put({"--"}, 'c', false, false)
		local line_to_set = M["comment_string"] .. line
		vim.api.nvim_set_current_line(line_to_set)
	else
		print("type is ".. type)
	end
end



return M
