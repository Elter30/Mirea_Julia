#=
ДАНО: Робот - в произвольной клетке ограниченного прямоугольного поля, на котором могут находиться также внутренние прямоугольные
 перегородки (все перегородки изолированы друг от друга, прямоугольники могут вырождаться в отрезки)

РЕЗУЛЬТАТ: Робот - в исходном положении и в углах поля стоят маркеры

mark_corner!(rob::Robot) - закрашивает все углы и возвращает Робота в начальное положение

=#
include("roblib.jl")

function draw_corner!(x::Robot)
    for side in (Nord, Ost, Sud, West)
        moves!(x, side)
        putmarker!(x)
    end
end


function mark_corner!(rob::Robot)
    arr = []
    go_to_corner!(rob, arr, West, Sud)
    draw_corner!(rob)
    return_back!(rob, arr)
end

mark_corner!(r)