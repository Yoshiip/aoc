local open = io.open

local function read_file(path)
    local file = open(path, "rb")
    if not file then return nil end
    local content = file:read "*a"
    file:close()
    return content
end


local function line_is_zero(row)
    for i = 1, #row, 1 do
        if row[i] ~= 0 then
            return false
        end
    end
    return true
end

local function calculate_next_line(row)
    local new_row = {};
    for i = 1, #row - 1, 1 do
        table.insert(new_row, row[i + 1] - row[i])
    end
    return new_row;
end

local sum = 0

local fileContent = read_file("input.txt");
if fileContent ~= nil then
    for line in fileContent:gmatch("[^\r\n]+") do
        local values = {}
        for number in line:gmatch("%S+") do
            table.insert(values, tonumber(number))
        end


        -- reverse list
        local reversed_values = {}
        for i=#values, 1, -1 do
            reversed_values[#reversed_values+1] = values[i]
        end

        local schema = {
            reversed_values,
        }


        local line = reversed_values

        while line_is_zero(line) ~= true do
            line = calculate_next_line(line)
            table.insert(schema, line)
        end

        for i = #schema, 1, -1 do
            if i ~= #schema then
                table.insert(schema[i], schema[i][#schema[i]] + schema[i + 1][#schema[i]])
            else
                table.insert(schema[i], schema[i][#schema[i]])
            end
        end
        sum = sum + schema[1][#schema[1]]
    end
end
print(sum)