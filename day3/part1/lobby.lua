local src_file = "input.txt"

local ratings = {}

for line in io.lines(src_file) do
    table.insert(ratings, line)
end

--- Finds joltage from its joltage rating
---@param rating string
---@return number
local find_joltage = function(rating)
    local max_num = -1
    for i = 1, #rating do
        local digit1 = tonumber(rating:sub(i, i))
        if digit1 ~= nil then
            for j = i + 1, #rating do
                local digit2 = tonumber(rating:sub(j, j))
                if digit2 ~= nil then
                    local current_num = digit1 * 10 + digit2
                    if current_num >= 10 and current_num <= 99 and current_num > max_num then
                        max_num = current_num
                    end
                end
            end
        end
    end
    return max_num
end

local total_joltage = 0

for _, rating in ipairs(ratings) do
    total_joltage = total_joltage + find_joltage(rating)
end

print(total_joltage)
