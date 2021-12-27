#=

ДАНО: Робот находится в произвольной клетке ограниченного прямоугольного поля без внутренних перегородок и маркеров.
РЕЗУЛЬТАТ: Робот — в исходном положении в центре прямого креста из маркеров, расставленных вплоть до внешней рамки.

krest!(rob::Robot) - рисует крест из маркеров относительно начального положения

=#

include("roblib.jl")

function next(side::HorizonSide)
    return HorizonSide(mod(Int(side) + 1, 4))
end    

function draw_line!(r, side)
    num_steps = 0
    while move_if_possible(r, side) == true
        putmarker!(r)
        num_steps += 1
    end

    return num_steps
end

function come_back!(r, side, num_steps)
    for i in 1:num_steps
        move_if_possible(r, side)
    end
end

function krest!(rob::Robot)
    num_steps = 0
    for side in [Nord, West, Sud, Ost]
        num_steps = draw_line!(rob, side)
        come_back!(rob, inverse(side), num_steps)
    end
    putmarker!(rob)
end

krest!(r)