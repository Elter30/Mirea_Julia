include("roblib.jl")
function return_back!(x::Robot, mvs::AbstractArray, side1::HorizonSide, side2::HorizonSide)
    for i in 1:length(mvs)
        if(i % 2 == 1)
            num_move!(x, side1, mvs[i])
        else
            num_move!(x, side2, mvs[i])
        end
    end
end

function coord!(rob::Robot)
    num_steps = go_to_corner!(rob, (Ost, Nord))
    num_steps_West = sum(num_steps[1:2:end])
    num_steps_Sud = sum(num_steps[2:2:end])

    println(num_steps)

    num_move!(rob, West, num_steps_West)
    putmarker!(rob)
    num_steps_Ost = moves!(rob, West)

    num_move!(rob, Sud, num_steps_Sud)
    putmarker!(rob)
    num_steps_Nord = moves!(rob, Sud)

    num_move!(rob, Ost, num_steps_Ost)
    putmarker!(rob)
    moves!(rob, Ost)

    num_move!(rob, Nord, num_steps_Nord)
    putmarker!(rob)
    moves!(rob, Nord)

    return_back!(rob, num_steps, West, Sud)


end

coord!(r)