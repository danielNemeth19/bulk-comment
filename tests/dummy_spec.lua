-- for tests look at: https://github.com/terrortylor/nvim-comment
local assert = require("luassert.assert")
local mock = require("luassert.mock")

describe("commenter class", function()
    before_each(function()
        Commenter = require("bulk-comment.commenter")
        API_MOCK = mock(vim.api, true)
    end)
    after_each(function()
        mock.revert(API_MOCK)
    end)
    it("can add block style comment - whitespace", function ()
        local c = Commenter:new('css')
        local line = "  margin-left: auto;"

        API_MOCK.nvim_get_current_line.returns(line)
        API_MOCK.nvim_win_get_cursor.returns({ 10, 2 })
        c:toggle_comment()

        -- vim.api.nvim_win_set_cursor(0, { row, endpos })
        -- vim.api.nvim_put({ self.symbol[2] }, 'c', true, false)

        -- vim.api.nvim_win_set_cursor(0, { row, num_whitespace })
        -- vim.api.nvim_put({ self.symbol[1] }, 'c', false, false)
        assert.stub(API_MOCK.nvim_win_set_cursor).was_called_with(0, { 10, line:len() })
        assert.stub(API_MOCK.nvim_put).was_called_with({ " */" }, 'c', false, false)
        assert.stub(API_MOCK.nvim_win_set_cursor).was_called_with(0, { 10, 2 })
        assert.stub(API_MOCK.nvim_put).was_called_with({ "/* " }, 'c', false, false)
    end)
end)
