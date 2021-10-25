#=

ДАНО: Робот - в произвольной клетке поля (без внутренних перегородок и маркеров)
РЕЗУЛЬТАТ: Робот - в исходном положении, и все клетки по периметру внешней рамки промакированы

inverse(side::HorizonSide) - подключается из библиотечного файла roblib.jl

perimetr!(rob::Robot) - красит периметр внешней рамки маркерами и возвращает робота в исходное положение

=#
function draw!(x::Robot, side::HorizonSide)
    while !isborder(x, side)
        move!(x, side)
        putmarker!(x)
    end
end

function go_to_corner!(x::Robot, mvs::AbstractArray)
    max_move!(x, Sud, mvs)
    max_move!(x, West, mvs)
end

function max_move!(x::Robot, side::HorizonSide, mvs::AbstractArray)
    while !isborder(x, side)
        move!(x, side)
        push!(mvs, side)
    end
end

function return_back!(x::Robot, mvs::AbstractArray)
    while length(mvs) > 0
        last_move = pop!(mvs)
        move!(x, inverse(last_move))
    end
end

function perimeter!(rob::Robot)
    arr = []

    go_to_corner!(rob, arr)

    for s in [Nord,Ost, Sud, West]
        draw!(rob, s)
    end

    return_back!(rob, arr)
end

perimeter!(r)
