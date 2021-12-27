include("roblib.jl")


function draw!(x, side)
    putmarker!(x)
    while move_if_possible(x, side) == true
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