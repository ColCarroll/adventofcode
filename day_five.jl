function seat_to_bin(seat_str::String, letters::Tuple{String,String})::String
    for (i, letter) in enumerate(letters)
        seat_str = replace(seat_str, letter => i - 1)
    end
    return seat_str
end

function parse_ticket(ticket_str::String)::Tuple{Int,Int}
    row = parse(Int, seat_to_bin(ticket_str[1:7], ("F", "B")), base = 2)
    seat = parse(Int, seat_to_bin(ticket_str[8:10], ("L", "R")), base = 2)
    return (row, seat)
end

function seat_id(ticket_str::String)::Int
    (row, seat) = parse_ticket(ticket_str)
    return 8 * row + seat
end

function solve_one()
    return maximum(map(seat_id, readlines("data/day_five.txt")))
end

function solve_two()
    ids = map(seat_id, readlines("data/day_five.txt"))
    expected_tot = (length(ids) + 1) * (maximum(ids) + minimum(ids)) / 2
    return expected_tot - sum(ids)
end

println(solve_one())
println(solve_two())
