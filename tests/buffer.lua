describe("commenter class", function()
    before_each(function()
        local plugin = require("bulk-comment")
        vim.keymap.set("n", "cc", plugin.toggle, { desc = "testing commenter" })
    end)
    it("test my func", function()
        local buf = vim.api.nvim_create_buf(false, true)
        vim.api.nvim_buf_set_option(buf, "filetype", "lua")
        vim.api.nvim_command("buffer " .. buf)

        -- local buffer_input = vim.split(input, "\n")
        -- print(P(buffer_input))
        local input = { "local test = 3" }
        vim.api.nvim_buf_set_lines(0, 0, -1, true, input)
        vim.api.nvim_win_set_cursor(0, { 1, 0 })
        local keys = vim.api.nvim_replace_termcodes('dd', true, false, true)
        print("after termcodes " .. keys)
        vim.api.nvim_feedkeys(keys, "n", false)

        local row_num = vim.api.nvim_buf_line_count(0)
        print("rows in buffer " .. row_num)
        local result = vim.api.nvim_buf_get_lines(0, 0, row_num, false)
        for key, value in pairs(result) do
            print(key .. value)
        end
        assert.are.same({ "-- local test = 3" }, input)
    end)
end)
