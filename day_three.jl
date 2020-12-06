import DelimitedFiles

data = DelimitedFiles.readdlm("data/day_three.txt", ' ')

function count(data, rsteps, dsteps)
    tot = 0
    for (idx, row) in enumerate(data)
        if (idx - 1) % dsteps == 0
            slope = rsteps / dsteps
            row_idx = (Int((idx - 1) * slope) % length(row)) + 1
            if row[row_idx] == '#'
                tot += 1
            end
        end
    end
    return tot
end

function solve()
    tot = 1
    for (rstep, dstep) in ((1, 1), (3, 1), (5, 1), (7, 1), (1, 2))
        tot *= count(data, rstep, dstep)
    end
    return tot
end

println(count(data, 3, 1))
println(solve())
