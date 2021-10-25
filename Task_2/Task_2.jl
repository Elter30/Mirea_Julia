#=

ДАНО: Робот - в произвольной клетке поля (без внутренних перегородок и маркеров)
РЕЗУЛЬТАТ: Робот - в исходном положении, и все клетки по периметру внешней рамки промакированы

inverse(side::HorizonSide) - подключается из библиотечного файла roblib.jl

perimetr!(rob::Robot) - красит периметр внешней рамки маркерами и возвращает робота в исходное положение

=#
include("roblib.jl")

function draw!(x::Robot, side::HorizonSide)
    while !isborder(x, side)
        move!(x, side)
        putmarker!(x)
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
