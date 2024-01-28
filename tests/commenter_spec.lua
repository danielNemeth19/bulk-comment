describe("commenter class", function ()
	it("can require", function ()
		require("bulk-comment.commenter")
	end)
	it("can initialize lua commenter", function ()
		local Commenter = require("bulk-comment.commenter")
		local c = Commenter:new('lua')
		assert.equals(c.filetype, 'lua')
		assert.equals(c.symbol, "-- ")
	end)
	it("can initialize python commenter", function ()
		local Commenter = require("bulk-comment.commenter")
		local c = Commenter:new('python')
		assert.equals(c.filetype, 'python')
		assert.equals(c.symbol, "# ")
	end)
	it("can initialize lua commenter", function ()
		local Commenter = require("bulk-comment.commenter")
		local c = Commenter:new('go')
		assert.equals(c.filetype, 'go')
		assert.equals(c.symbol, "// ")
	end)
	it("sets symbol as none for unknown filetype", function ()
		local Commenter = require("bulk-comment.commenter")
		local c = Commenter:new('unknown-language')
		assert.equals(c.filetype, 'unknown-language')
		assert.equals(c.symbol, nil)
	end)
	it("can count whitespaces", function ()
		local examples = {
			{line = "example 1", result = 0 },
			{ line = " example 2", result = 1 },
			{ line = "  example 3", result = 2 },
			{ line = "   example 4", result = 3 }
		}
		local Commenter = require("bulk-comment.commenter")
		local c = Commenter:new('lua')

		for _, example in ipairs(examples) do
			local res = c:count_whitespace(example.line)
			assert.equals(res, example.result)
		end
	end)
end)
