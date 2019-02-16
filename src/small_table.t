local function small_table(key_type, value_type, max_size)

    local struct pair {
        key : key_type
        value : value_type
    }

    local struct small_table {
        len : int,
        pairs : pair[max_size]
    }

    terra small_table:init() 
        self.len = 0
    end

    terra small_table:size() return self.len end
    terra small_table:is_empty() return self.len == 0 end
    terra small_table:is_full() return self.len == max_size end

    terra small_table:put(key : key_type, value : value_type)
        var pair = self:get(key)
        if pair ~= nil then
            pair.value = value
            return true
        end

        if self.len < max_size then
            self.pairs[self.len].key = key
            self.pairs[self.len].value = value
            self.len = self.len + 1
            return true
        else
            return false
        end
    end

    terra small_table:get(key : key_type) : &pair
        for i=0,self.len do
            if self.pairs[i].key == key then
                return &self.pairs[i]
            end
        end
        return nil
    end

    terra small_table:index(key : key_type) : int
        for i=0,self.len do
            if self.pairs[i].key == key then
                return i
            end
        end
        return self.len
    end

    terra small_table:at(index : int) : &pair
        if index >= 0 and index < self.len then
            return &self.pairs[index]
        else
            return nil
        end
    end

    terra small_table:del(key : key_type)
        var index = self:index(key)
        if index < self.len then
            if index < self.len - 1 then
                for i=index,self.len do
                    self.pairs[i] = self.pairs[i+1]
                end
            end
            self.len = self.len - 1
        end
    end

    return small_table, pair
end

return small_table
