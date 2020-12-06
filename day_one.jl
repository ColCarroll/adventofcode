import DelimitedFiles

data = DelimitedFiles.readdlm("data/day_one.txt", ',', Int)
complements = 2020 .- data

println(prod(intersect(complements, data)))

for j in data
    complements = 2020 - j .- data
    matches = intersect(complements, data)
    if length(matches) > 0
        println(j * prod(matches))
        break
    end
end
