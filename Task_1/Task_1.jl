#=

ДАНО: Робот находится в произвольной клетке ограниченного прямоугольного поля без внутренних перегородок и маркеров.
РЕЗУЛЬТАТ: Робот — в исходном положении в центре прямого креста из маркеров, расставленных вплоть до внешней рамки.

krest!(rob::Robot) - рисует крест из маркеров относительно начального положения

=#
function draw!(x::Robot, side::HorizonSide)
    while !isborder(x, side)
        move!(x, side)
        putmarker!(x)
    end
end
function come_back!(x::Robot, side::HorizonSide)
    while ismarker(x)
        move!(x, side)
    end
end
function inverse(side::HorizonSide)
    return HorizonSide((Int(side) + 2) % 4)
end
function krest!(rob::Robot)
    for s in [Nord,West, Sud, Ost]
        draw!(rob, s)
        come_back!(rob, inverse(s))
    end
    putmarker!(rob)
end
krest!(r)
