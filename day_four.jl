
function ok_year(year_str::String, lo::Int, hi::Int)
    if length(year_str) != 4
        return false
    end
    return lo <= parse(Int, year_str) <= hi
end

function ok_pid(pid_str::String)
    return !isnothing(match(r"^[0-9]{9}$", pid_str))
end

function ok_hcl(hcl_str::String)
    return !isnothing(match(r"^#[0-9a-f]{6}$", hcl_str))
end

function ok_hgt(hgt_str::String)
    if endswith(hgt_str, "in")
        hgt = tryparse(Int, hgt_str[1:end-2])
        lo, hi = 59, 76
    elseif endswith(hgt_str, "cm")
        hgt = tryparse(Int, hgt_str[1:end-2])
        lo, hi = 150, 193
    else
        hgt = Nothing()
    end
    if isnothing(hgt)
        return false
    else
        return lo <= hgt <= hi
    end
end

function ok_ecl(ecl_str::String)
    return ecl_str in Set(["amb", "blu", "brn", "gry", "grn", "hzl", "oth"])
end

expected_keys = Dict([
    ("byr", x -> ok_year(x, 1920, 2002)),
    ("iyr", x -> ok_year(x, 2010, 2020)),
    ("eyr", x -> ok_year(x, 2020, 2030)),
    ("hgt", ok_hgt),
    ("hcl", ok_hcl),
    ("ecl", ok_ecl),
    ("pid", ok_pid),
    ("cid", x -> true),
])

function solve_one()
    data = Dict([("cid", "123")])
    tot = 0

    for line in readlines("data/day_four.txt")
        if length(line) == 0
            if all(haskey(data, key) for key in keys(expected_keys))
                tot += 1
            end
            data = Dict([("cid", "123")])
        else
            for key in split(line, ' ')
                k, v = map(String, split(key, ':'))
                data[k] = v
            end
        end
    end
    return tot
end

function solve_two()
    data = Dict([("cid", "123")])
    tot = 0

    for line in readlines("data/day_four.txt")
        if length(line) == 0
            if all(haskey(data, key) for key in keys(expected_keys))
                tot += 1
            end
            data = Dict([("cid", "123")])
        else
            for key in split(line, ' ')
                k, v = map(String, split(key, ':'))
                if !haskey(expected_keys, k) | expected_keys[k](v)
                    data[k] = v
                end
            end
        end
    end
    return tot
end

println(solve_one())
println(solve_two())
