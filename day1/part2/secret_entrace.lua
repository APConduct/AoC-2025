local io = require("io")
local string = require("string")

local src_file = "input.txt"
-- table to hold all the rotations from the input file
local rotations = {}
-- starting position
local position = 50
-- incrementer for the password. acc by one when position is 0 after a rotation

for line in io.lines(src_file) do
    table.insert(rotations, line)
end

local function find_password(pos, moves)
    local password_acc = 0
    for _, v in ipairs(moves) do
        if string.find(v, "R") then
            local move_value = tonumber(string.sub(v, 2))
            -- Count how many times we pass through 0 when moving right
            local times_through_zero = math.floor((pos + move_value) / 100)
            password_acc = password_acc + times_through_zero
            -- Calculate final position
            pos = (pos + move_value) % 100
        elseif string.find(v, "L") then
            local move_value = tonumber(string.sub(v, 2))
            -- Count how many times we pass through 0 when moving left
            local times_through_zero = 0
            if pos == 0 then
                -- If we're at 0 and move left, we pass through 0 every 100 clicks
                times_through_zero = math.floor(move_value / 100)
            elseif move_value >= pos then
                -- We pass through 0 when we've moved pos clicks, then every 100 clicks after
                times_through_zero = math.floor((move_value - pos) / 100) + 1
            end
            password_acc = password_acc + times_through_zero
            -- Calculate final position
            pos = ((pos - move_value) % 100 + 100) % 100
        end
    end
    return password_acc
end

-- print the password (pwd_inc)
print("The password is:", find_password(position, rotations))
