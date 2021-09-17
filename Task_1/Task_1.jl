function draw!(x, side)
    while !isborder(x, side)
        move!(x, side)
        putmarker!(x)
    end
end
function come_back!(x, side)
    while ismarker(x)
        move!(x, side)
    end
end
function inverse(side)
    return HorizonSide((Int(side) + 2) % 4)
end
function krest!(rob)
    for s in [Nord,West, Sud, Ost]
        draw!(rob, s)
        come_back!(rob, inverse(s))
    end
    putmarker!(r)
end
krest!(r)
