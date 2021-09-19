function draw!(x, side)
    while !isborder(x, side)
        move!(x, side)
        putmarker!(x)
    end
end

function perimeter!(rob)
    coun = 0

    while !isborder(rob, Ost)
        move!(rob, Ost)
        coun += 1
    end

    for s in [Nord,West, Sud, Ost]
        draw!(rob, s)
    end
    move!(rob, Nord)

    while !ismarker(rob)
        putmarker!(rob)
        move!(rob, Nord)
    end

    move!(rob, Sud)
    for i in 1:coun
        move!(rob, West)
    end
end

perimeter!(r)
