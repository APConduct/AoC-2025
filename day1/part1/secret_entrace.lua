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
    local pwd_inc = 0
    for _, v in ipairs(moves) do
        if string.find(v, "R") then
            local ton = tonumber(string.sub(v, 2))
            print("Turning R by ", ton)
            local prev_pos = pos
            pos = pos + ton
            if pos > 99 then
                pos = pos % 100
            end
            if prev_pos <= 99 and pos < prev_pos then
                pwd_inc = pwd_inc + 1
            end
        elseif string.find(v, "L") then
            local ton = tonumber(string.sub(v, 2))
            print("Turning L by ", ton)
            local prev_pos = pos
            pos = pos - ton
            if pos < 0 then
                pos = (pos + 100) % 100
            end
            if prev_pos >= 0 and pos > prev_pos then
                pwd_inc = pwd_inc + 1
            end
        end
        print("New position: ", pos)
        if pos == 0 then
            pwd_inc = pwd_inc + 1
        end
    end
    return pwd_inc
end

print("The password is:", find_password(position, rotations))
