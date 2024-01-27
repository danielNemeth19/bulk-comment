table.unpack = table.unpack or unpack
local M = {}

local commentMap = {
	lua = "--",
	python = "# ",
	go = "//"
}

--- @param line string
M.get_col_for_line = function (line)
	local num_whitespace = line:match("^%s*"):len()
	return num_whitespace
end

M.get_file_type = function ()
	local type = vim.bo.filetype
	M['type'] = type
	if commentMap[type] then
		M['symbol'] = commentMap[type]
		local line = vim.api.nvim_get_current_line()
		local n = M.get_col_for_line(line)
		local row, _ = table.unpack(vim.api.nvim_win_get_cursor(0))
		vim.api.nvim_win_set_cursor(0, {row, n})
		vim.api.nvim_put({M['symbol']}, 'c', false, false)
		vim.api.nvim_win_set_cursor(0, {row + 1, n})
	else
		print("type is ".. type)
	end
end


return M
