
function solve_one()
    data = Nothing()
    tot = 0

    for line in readlines("data/day_six.txt")
        if length(line) == 0
            tot += length(data)
            data = Nothing()
        else
            if isnothing(data)
                data = Set(line)
            else
                data = intersect(data, line)
            end
        end
    end
    return tot + length(data)
end

println(solve_one())
