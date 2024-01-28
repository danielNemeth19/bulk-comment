local commentMap = {
	lua = "-- ",
	python = "# ",
	go = "// "
}

---@class Commenter
---@field filetype string
---@field symbol string
local Commenter = {}
Commenter.__index = Commenter

---@return Commenter
---@param filetype string
function Commenter:new(filetype)
	local self = setmetatable({}, Commenter)
	self.__index = self
	self.filetype = filetype
	self.symbol = self:_set_symbol()
	return self
end

---@protected
function Commenter._set_symbol(self)
	local symbol = commentMap[self.filetype]
	return symbol
end

--- @param line string
function Commenter:count_whitespace(line)
	local num_whitespace = line:match("^%s*"):len()
	return num_whitespace
end

-- TODO: don't toggle if no code under cursor
-- implement actual toogle functionality
function Commenter.toggle_comment(self)
	local line = vim.api.nvim_get_current_line()
	local num_whitespace = self:count_whitespace(line)
	local row, _ = table.unpack(vim.api.nvim_win_get_cursor(0))
	vim.api.nvim_win_set_cursor(0, {row, num_whitespace})
	vim.api.nvim_put({self.symbol}, 'c', false, false)
	vim.api.nvim_win_set_cursor(0, {row + 1, num_whitespace})
end

return Commenter
