function backup!(x)
    move!(x, Nord)
    while isborder(x, West) == false
        move!(x, West)
    end
end

function draw!(x, side, leng)
    putmarker!(x)
    for i in 1:leng
        move!(x, Ost)
        putmarker!(x)
    end
end

function num_move!(x, side)
    num = 0
    while isborder(x, side) == false
        move!(x, side)
        num += 1
    end
    return num
end

function max_move!(x, side)
    while isborder(x, side) == false
        move!(x, side)
    end
end

function move_coun!(x, side, leng)
    for i in 1:leng
        move!(x, side)
    end
end

function stairs!(rob)
    num_x = num_move!(rob, Ost)
    num_y = num_move!(rob, Sud)
    leng_step = num_move!(rob, West)

    while leng_step != 0
        draw!(rob, Nord, leng_step)
        if isborder(rob, Nord)
            break
        end
        backup!(rob)
        leng_step -= 1
    end

    max_move!(rob, Ost)
    max_move!(rob, Sud)

    move_coun!(rob, West, num_x)
    move_coun!(rob, Nord, num_y)
end

stairs!(r)