
-- javier was here
-- this is a comment
-- chickenbutts

describe("small table", function()
    it("should create an empty table", function()
    	local my_table = small_table.new(int, int, 4)

        assert.is.equal(0, my_table:size())
--        assert.is.truthy(my_table:is_empty())
--        assert.is.falsy(my_table:is_full())
    end)
    pending("should store and retrieve a value by key", function()
    	local my_table = small_table.new(int, int, 4)

        my_table:put(3, 33)
        assert.is.equal(33, my_table:get(3))
    end)
end)

