do_run(pressed_ms::Integer, time::Integer, distance::Integer) = pressed_ms * (time - pressed_ms) > distance

function race(time::Integer, distance::Integer)
    total = 0
    for i in 0:time
        if do_run(i, time, distance)
            total = 1 + total
        end
    end
    return total
end


function do_all_races()
    array = Int64[]
    push!(array, race(46, 358))
    push!(array, race(68, 1054))
    push!(array, race(98, 1807))
    push!(array, race(66, 1080))
    return array[1] * array[2] * array[3] * array[4];
end

println(do_all_races())