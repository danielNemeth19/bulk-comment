describe("bulk-comment", function ()
	it("can require", function ()
		require("bulk-comment")
	end)
	it("can count whitespaces", function ()
		local examples = {
			{line = "example 1", result = 0 },
			{ line = " example 2", result = 1 },
			{ line = "  example 3", result = 2 },
			{ line = "   example 4", result = 3 }
		}

		for _, example in ipairs(examples) do
			local res = require("bulk-comment").get_col_for_line(example.line)
			assert.are.same(res, example.result)
		end
	end)
end)
