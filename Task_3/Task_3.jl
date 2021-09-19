function draw!(x, side)
    putmarker!(x)
    while !isborder(x, side)
        move!(x, side)
        putmarker!(x)
    end
    if !isborder(x, Nord)
        move!(x, Nord)
    end
end

function num_move!(x, side)
    coun = 0
    while isborder(x, side) == 0
        move!(x, side)
        coun +=1
    end
    return coun
end

function max_move!(x, side)
    while isborder(x, side) == 0
        move!(x, side)
    end
end

function move_coun!(x, side, num)
    for i in 1:num
        move!(x, side)
    end
end

function area!(rob)
    num_x = num_move!(rob, West)
    num_y = num_move!(rob, Sud)

    while (isborder(rob, Nord) && isborder(rob, Ost)) == false
        if !isborder(rob, Ost)
            draw!(rob, Ost)
        else
            draw!(rob, West)
        end
    end

    max_move!(rob, West)
    max_move!(rob, Sud)

    move_coun!(rob, Nord, num_y)
    move_coun!(rob, Ost, num_x)
end

area!(r)