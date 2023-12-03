#!/usr/bin/env ruby

MINIMUM = {
    "red" => 12,
    "green" => 13,
    "blue" => 14
}

if __FILE__ == $0
    file = File.open("input.txt")
    file_data = file.read
    total = 0
    file_data.each_line do |line|
        line.sub! ':', ';'
        line = line.delete("\n")
        array = line.split('; ')
        game_id = array[0].delete("Game ")
        array.delete_at(0)
        valid = true
        array.each do |reveal|
            cubes = reveal.split(', ')
            cubes.each do |cube|
                cube_splitted = cube.split(' ')
                if cube_splitted[0].to_i > MINIMUM[cube_splitted[1]]
                    valid = false
                end
            end
        end
        if valid
            total += game_id.to_i
        end
        
    end
    puts "#{total}"
end