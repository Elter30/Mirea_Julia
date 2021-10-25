#=

ДАНО: Робот - в произвольной клетке ограниченного прямоугольного поля
РЕЗУЛЬТАТ: Робот - в исходном положении, и все клетки поля промакированы

area!(x::Robot) - закрашивает все клетки поля и возвращает робота в начальное положение

Функции go_to_corner!(x::Robot, mvs::AbstractArray), moves!(x::Robot, side::HorizonSide), return_back!(x::Robot, mvs::AbstractArray) - подключаются из библиотечного файла roblib.jl

=#
include("roblib.jl")

function draw!(x, side)
    putmarker!(x)
    while !isborder(x, side)
        move!(x, side)
        putmarker!(x)
    end
    if !isborder(x, Nord)
        move!(x, Nord)
    end
end


function area!(rob)
    arr = []

    go_to_corner!(rob, arr, West, Sud)

    while (isborder(rob, Nord) && isborder(rob, Ost)) == false
        if !isborder(rob, Ost)
            draw!(rob, Ost)
        else
            draw!(rob, West)
        end
    end

    moves!(rob, West)
    moves!(rob, Sud)

    return_back!(rob, arr)
end

area!(r)