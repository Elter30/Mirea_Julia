#=
ДАНО: Робот - Робот - в произвольной клетке ограниченного прямоугольного поля

РЕЗУЛЬТАТ: Робот - в исходном положении, и клетки поля промакированы так: нижний ряд - полностью, следующий - весь, за исключением одной последней клетки на 
Востоке, следующий - за исключением двух последних клеток на Востоке, и т.д.
=#

include("roblib.jl")

function move_if_possible(r, main_side::HorizonSide)
    orthogonal_side = next(main_side)
    reverse_side = inverse(orthogonal_side)
    num_steps = 0

    while isborder(r, main_side) && !isborder(r,orthogonal_side)
        move!(r, orthogonal_side)
        num_steps += 1
    end

    leng = 0
    if !isborder(r, main_side)
        move!(r, main_side)
        leng += 1
    end

    if num_steps != 0
        while isborder(r, reverse_side)
            move!(r, main_side)
            leng += 1
        end
        num_move!(r, reverse_side, num_steps)
    end
    return leng
end

function move_back!(r::Robot, side::HorizonSide)
    leng = 1
    while leng != 0
        leng = move_if_possible(r, side)
    end

end


function stairs!(rob::Robot)
    arr = []
    go_to_corner!(rob, arr, West, Sud)

    putmarker!(rob)
    while !isborder(rob, Ost)
        move!(rob, Ost)
        putmarker!(rob)
    end

    field_length = moves!(rob, West)

    while !isborder(rob, Nord) && field_length > 0
        line_length = field_length
        move!(rob, Nord)
        while line_length > 0
            putmarker!(rob)
            line_length -= move_if_possible(rob, Ost)
        end

        move_back!(rob, West)
        field_length -= 1
    end

    go_to_corner!(rob, (West, Sud))

    return_back!(rob, arr)
end

stairs!(r)