using DataFrames
import DelimitedFiles
using CSV

data = DataFrame(CSV.File(
    "data/day_two.txt";
    header = ["min-max", "char", "pwd"],
    delim = " ",
))
nums = split.(data[!, "min-max"], "-")
nums = transpose(hcat(map(x -> parse.(Int, x), nums)...))

data[!, "lo"] = nums[:, 1]
data[!, "hi"] = nums[:, 2]

data[!, "char"] = rstrip.(data[!, "char"], ':')

data[!, "counts"] = count.(data[!, "char"], data[!, "pwd"])

data[!, "compliant"] =
    (data[!, "counts"] .>= data[!, "lo"]) .& (data[!, "counts"] .<= data[!, "hi"])


println(sum(data[!, "compliant"]))

function make_sum()
    tot = 0
    for row in eachrow(data)
        target = row.char
        tot += (row.pwd[row.lo:row.lo] == target) ⊻ (row.pwd[row.hi:row.hi] == target)
    end
    return tot
end
println(make_sum())
