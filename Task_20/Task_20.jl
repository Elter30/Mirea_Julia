#=
Посчитать число всех горизонтальных прямолинейных перегородок (вертикальных - нет)
=#

include("roblib.jl")

function gorizontal_line_count(rob::Robot)
    go_to_corner!(rob, (Sud, West))

    ans = 0
    border_check = false
    side = Ost

    while !isborder(r, Nord)
        while !isborder(r, side)
            ans, border_check = find_lines(r, ans, border_check, Nord)
            move!(r,side)
        end
        ans, border_check = find_lines(r, ans, border_check, Nord)

        side = inverse(side)
        move!(r, Nord)
    end
    println(ans)
end

function find_lines(r::Robot, ans::Int, border_check, side::HorizonSide)
    if isborder(r, side)
        border_check = true
    end
    if !isborder(r, side) && border_check
        border_check = false
        ans += 1
    end
    return ans, border_check
end

gorizontal_line_count(r)