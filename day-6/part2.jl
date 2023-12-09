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

println(race(71530, 940200))