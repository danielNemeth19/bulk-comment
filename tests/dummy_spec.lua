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
end)
