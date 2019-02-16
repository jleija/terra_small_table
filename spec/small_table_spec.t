local small_table = require("small_table")

describe("small table", function()
    local small_table_type = small_table(int, int, 3)

    local my_table = global(small_table_type)

    local terra instance()
        return &my_table
    end

    before_each(function()
        instance():init()
    end)

    it("should create an empty table", function()
        assert.is.equal(0, instance():size())
        assert.is.truthy(instance():is_empty())
        assert.is.falsy(instance():is_full())
    end)

    it("should return nil when it cannot find the key", function()
        assert.is.equal(nil, instance():get(1))
    end)

    it("should store and retrieve a value by key", function()
        instance():put(3, 33)
        assert.is.equal(1, instance():size())
        local pair = instance():get(3)
        assert.is.truthy(pair)
        assert.is.equal(3, pair.key)
        assert.is.equal(33, pair.value)
    end)

    it("should return the pairs index when it finds the key", function()
        instance():put(1, 11)
        instance():put(2, 22)
        instance():put(3, 33)

        assert.is.equal(1, instance():index(2))
        assert.is.equal(22, instance():at(1).value)
    end)

    it("should return nil when index is out of range", function()
        instance():put(1, 11)

        assert.is.equal(nil, instance():at(1))
        assert.is.equal(1, instance():size())
        assert.is.equal(nil, instance():at(-1))
        assert.is.truthy(instance():index(0))
    end)

    it("should return false when put exceeds the max number of keys", function()
        assert.is.truthy(instance():put(1,0))
        assert.is.truthy(instance():put(2,0))
        assert.is.truthy(instance():put(3,0))
        assert.is.equal(3, instance():size())
        assert.is.falsy(instance():put(4,0))
        assert.is.equal(3, instance():size())
    end)

    it("should overwrite existing key value with new value", function()
        assert.is.truthy(instance():put(1,10))
        assert.is.equal(10, instance():get(1).value)
        assert.is.truthy(instance():put(1,100))
        assert.is.equal(100, instance():get(1).value)
        assert.is.equal(1, instance():size())
    end)

    it("can delete existing values", function()
        assert.is.truthy(instance():put(1,10))
        assert.is.truthy(instance():put(2,20))
        assert.is.truthy(instance():put(3,30))
        assert.is.equal(3, instance():size())

        instance():del(2)

        assert.is.falsy(instance():get(2))
        assert.is.equal(10, instance():get(1).value)
        assert.is.equal(30, instance():get(3).value)
        assert.is.equal(2, instance():size())

        instance():del(3)
        assert.is.equal(10, instance():get(1).value)
        assert.is.equal(1, instance():size())
    end)

    it("should not change anything with a delete of a non-existing key", function()
        assert.is.truthy(instance():put(1,10))
        assert.is.truthy(instance():put(2,20))
        assert.is.truthy(instance():put(3,30))
        assert.is.equal(3, instance():size())

        instance():del(58)

        assert.is.equal(10, instance():get(1).value)
        assert.is.equal(20, instance():get(2).value)
        assert.is.equal(30, instance():get(3).value)
        assert.is.equal(3, instance():size())
    end)

    it("can be copied as a c-struct", function()
        instance():put(1, 11)
        instance():put(2, 22)
        instance():put(3, 33)

        local terra copy_table( t : &small_table_type)
            var x : small_table_type = @t
            return x
        end

        local table_copy = copy_table(instance())

        assert.is.equal(33, table_copy:get(3).value)

        instance():del(2)
        assert.is.falsy(instance():get(2))
        assert.is.equal(22, table_copy:get(2).value)

        assert.is.equal(3, table_copy:size())
        assert.is.equal(2, instance():size())
    end)

end)

