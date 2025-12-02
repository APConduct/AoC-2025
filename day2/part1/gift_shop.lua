--- Checks if the input number is made only of some sequence of digits repeated twice
---@param input integer
---@return boolean
local repeated_sequence = function(input)
    local input_str = tostring(input)
    local len = #input_str
    if len % 2 ~= 0 then
        return false
    end
    local half_len = len / 2
    local first_half = input_str:sub(1, half_len)
    local second_half = input_str:sub(half_len + 1, len)
    return first_half == second_half
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
