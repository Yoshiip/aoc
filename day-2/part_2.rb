#!/usr/bin/env ruby


if __FILE__ == $0
    file = File.open("input.txt")
    sum = 0
    file.read.each_line do |line|
        line.sub! ':', ';'
        line = line.delete("\n")
        array = line.split('; ')
        array.delete_at(0)
        
        minimum = {
            "red" => 0,
            "green" => 0,
            "blue" => 0
        }

        array.each do |reveal|
            cubes = reveal.split(', ')
            cubes.each do |cube|
                cube_splitted = cube.split(' ')
                if cube_splitted[0].to_i > minimum[cube_splitted[1]]
                    minimum[cube_splitted[1]] = cube_splitted[0].to_i
                end
            end
        end
        sum += minimum["red"] * minimum["green"] * minimum["blue"]
        
    end
    puts "#{sum}"
end