-- for tests look at: https://github.com/terrortylor/nvim-comment
local assert = require("luassert.assert")
local mock = require("luassert.mock")

local function buffer_setup(input, filetype)
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_option(buf, "filetype", filetype)
    vim.api.nvim_command("buffer " .. buf)
    vim.api.nvim_buf_set_lines(0, 0, -1, true, vim.split(input, '\n'))
end

local function toggle_line(line)
    vim.api.nvim_win_set_cursor(0, { line, 0 })
    local keypress = vim.api.nvim_replace_termcodes('bc', true, false, true)
    vim.api.nvim_feedkeys(keypress, "x", false)
end

local function get_lines_from_buffer()
    local row_num = vim.api.nvim_buf_line_count(0)
    local buffer_content = vim.api.nvim_buf_get_lines(0, 0, row_num, false)
    return buffer_content
end

describe("commenter class", function()
    before_each(function()
        Commenter = require("bulk-comment.commenter")
        API_MOCK = mock(vim.api, true)
    end)
    after_each(function()
        mock.revert(API_MOCK)
    end)
    -- TODO - why is this failing?
    it("commenting block style - with whitespace", function ()
        local input = "  margin-left: auto;"
        local expected_output = { "  /* margin-left: auto; */" }
        buffer_setup(input, "css")
        toggle_line(1)
        local buffer_content = get_lines_from_buffer()
        assert.are.same(expected_output, buffer_content)
    end)
end)
