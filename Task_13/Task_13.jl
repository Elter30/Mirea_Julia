#=

ДАНО: Робот - в произвольной клетке ограниченного прямоугольной рамкой поля без внутренних перегородок и маркеров.
РЕЗУЛЬТАТ: Робот - в исходном положении в центре косого креста (в форме X) из маркеров.

diag!(rob::Robot) - рисует косой крест с центром в начальном положении Робота

=#

include("roblib.jl")

function draw!(x::Robot, side1::HorizonSide, side2::HorizonSide)
    while (isborder(x, side1) || isborder(x, side2)) == false
        move!(x, side1)
        move!(x, side2)
        putmarker!(x)
    end
end

function back!(x::Robot, side1::HorizonSide, side2::HorizonSide)
    while ismarker(x)
        move!(x, side1)
        move!(x, side2)
    end
end


function diag!(rob::Robot)
    vec = West
    for s in [Nord, Sud]
        draw!(rob, vec, s)
        back!(rob, inverse(vec), inverse(s))
    end

    vec = Ost
    for s in [Nord, Sud]
        draw!(rob, vec, s)
        back!(rob, inverse(vec), inverse(s))
    end

    putmarker!(rob)
end

diag!(r)