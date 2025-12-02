--- Checks if the input number is made only of some sequence of digits repeated at least twice.
---@param num number
---@return boolean
local repeated_sequence = function(num)
    local str_num = tostring(num)
    local len = #str_num
    for seq_len = 1, math.floor(len / 2) do
        if len % seq_len == 0 then
            local sequence = string.sub(str_num, 1, seq_len)
            local repeated = true
            for i = seq_len + 1, len, seq_len do
                if string.sub(str_num, i, i + seq_len - 1) ~= sequence then
                    repeated = false
                    break
                end
            end
            if repeated then
                return true
            end
        end
    end
    return false
end

--- Splits a string by a given separator.
---@param str string
---@param sep string
---@return table<string>
local split = function(str, sep)
    local result = {}
    for part in string.gmatch(str, "([^" .. sep .. "]+)") do
        table.insert(result, part)
    end
    return result
end

---@type string
local content = io.open("input.txt", "r"):read()
local ranges = split(content, ",")

local bounds = {}
for _, range in ipairs(ranges) do
    local min_max = split(range, "-")
    table.insert(bounds, { tonumber(min_max[1]), tonumber(min_max[2]) })
end


local invalid_ids = {}
for _, bound in ipairs(bounds) do
    for i = bound[1], bound[2] do
        if repeated_sequence(i) then
            table.insert(invalid_ids, i)
        end
    end
end

-- add up all invalid ids
local total_invalid_ids = 0
for _, id in ipairs(invalid_ids) do
    total_invalid_ids = total_invalid_ids + id
end

print(total_invalid_ids)
