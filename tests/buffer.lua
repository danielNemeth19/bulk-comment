local assert = require("luassert.assert")

local function buffer_setup(input, filetype)
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_option(buf, "filetype", filetype)
    vim.api.nvim_command("buffer " .. buf)
    vim.api.nvim_buf_set_lines(0, 0, -1, true, input)
end

local function comment_line(line)
    vim.api.nvim_win_set_cursor(0, { line, 0 })
    local keypress = vim.api.nvim_replace_termcodes('bc', true, false, true)
    vim.api.nvim_feedkeys(keypress, "x", false)
end

local function get_lines_from_buffer()
    local row_num = vim.api.nvim_buf_line_count(0)
    local buffer_content = vim.api.nvim_buf_get_lines(0, 0, row_num, false)
    return buffer_content
end

describe("bulk-comment module", function()
    before_each(function()
        local plugin = require("bulk-comment")
        vim.keymap.set("n", "bc", plugin.toggle, { desc = "testing commenter" })
    end)
    it("last row can be commented", function()
        local input = { "local test = 1" }
        local expected_output = { "-- local test = 1" }

        buffer_setup(input, "lua")
        comment_line(1)
        local buffer_content = get_lines_from_buffer()
        assert.are.same(expected_output, buffer_content)
    end)
end)
