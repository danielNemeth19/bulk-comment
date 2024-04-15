table.unpack = table.unpack or unpack

local commentMap = {
    lua = "-- ",
    python = "# ",
    yaml = "# ",
    go = "// ",
    javascript = "// ",
    typescript = "// ",
    css = {
        "/* ",
        " */"
    },
    html = {
        "<!--",
        "-->"
    }
}

---@class Commenter
---@field filetype string
---@field symbol any
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

---@param line string
function Commenter:is_empty_row(line)
    local non_whitespace = line:match("%S+")
    if non_whitespace == nil then
        return true
    end
    return false
end

---@param row integer
---@param num_whitespace integer
function Commenter:_toggle_inline_style(row, num_whitespace)
    vim.api.nvim_win_set_cursor(0, { row, num_whitespace })
    vim.api.nvim_put({ self.symbol }, 'c', false, false)
end

---@param line string
---@param row integer
---@param num_whitespace integer
function Commenter:_toggle_block_style(line, row, num_whitespace)
    local endpos = line:len()
    vim.api.nvim_win_set_cursor(0, { row, endpos })
    vim.api.nvim_put({ self.symbol[2] }, 'c', true, false)

    vim.api.nvim_win_set_cursor(0, { row, num_whitespace })
    vim.api.nvim_put({ self.symbol[1] }, 'c', false, false)
end

---@param line string
function Commenter:is_commented(line)
    if type(self.symbol) == "string" then
        local num_chars = self.symbol:len()
    else
        local num_chars = self.symbol[1]:len()
    end
    if line.sub(line, 1, num_chars) == self.symbol then
        return true
    end
    return false
end

-- TODO: implement actual toogle functionality
function Commenter:toggle_comment()
    local line = vim.api.nvim_get_current_line()

    local row, _ = table.unpack(vim.api.nvim_win_get_cursor(0))
    if self:is_empty_row(line) then
        vim.api.nvim_win_set_cursor(0, { row + 1, 0 })
        return
    end

    if not self:is_commented(line) then
        local num_whitespace = self:count_whitespace(line)
        if type(self.symbol) == "string" then
            self:_toggle_inline_style(row, num_whitespace)
        else
            self:_toggle_block_style(line, row, num_whitespace)
        end

        local total_row_num = vim.api.nvim_buf_line_count(0)
        if row ~= total_row_num then
            vim.api.nvim_win_set_cursor(0, { row + 1, num_whitespace })
        end
    else
        print("already commented line")
        -- doesn't work...
        vim.api.nvim_buf_set_lines(0, 1, self.symbol:len(), false, {})
    end
end

return Commenter
