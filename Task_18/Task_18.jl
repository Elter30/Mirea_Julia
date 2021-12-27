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