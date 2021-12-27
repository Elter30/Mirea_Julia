#=
Эта задача аналогична задаче 9, но дополнительно на неограниченном поле могут находиться изолированные прямолинейные перегородки, 
в том числе и неограниченно продолжающиеся в одну из своих сторон.

ДАНО: Где-то на неограниченном со всех сторон поле и без внутренних перегородок имеется единственный маркер. 
Робот - в произвольной клетке поля.

РЕЗУЛЬТАТ: Робот - в клетке с тем маркером.
=#

include("roblib.jl")

function marker!(rob::Robot)
    count = 0
    step = 1
    flag = false
    while flag == false
        for s in [Ost, Nord, West, Sud]
            if count == 2
                step += 1
                count = 0
            end
            for i in 1:step
                if isborder(rob, s)
                    go_around(rob, s)
                    flag = ismarker(rob)
                    if flag == true
                        break
                    end
                else
                    move!(rob, s)
                    flag = ismarker(rob)
                    if flag == true
                        break
                    end
                end
                if flag == true
                    break
                end
            end
            if flag == true
                break
            end
            count += 1
        end
    end
end

function go_around(r::Robot, main_side::HorizonSide)
    flag = false
    count = 1
    side = 0
    orthogonal_side = next(main_side)
    reverse_side = inverse(orthogonal_side)
    while flag == false
        num_move!(r, orthogonal_side, count)
        if isborder(r, main_side) == false
            flag = true
            side = orthogonal_side
            break
        end
        num_move!(r, reverse_side, count)

        num_move!(r, reverse_side, count)
        if isborder(r, main_side) == false
            flag = true
            side = reverse_side
            break
        end
        num_move!(r, orthogonal_side, count)
        count += 1
    end
    move!(r, main_side)
    num_move!(r, inverse(side), count)
end

marker!(r)