#=

ДАНО: Робот - рядом с горизонтальной перегородкой (под ней), бесконечно продолжающейся в обе стороны, 
в которой имеется проход шириной в одну клетку.
РЕЗУЛЬТАТ: Робот - в клетке под проходом


=#

include("roblib.jl")

function door!(rob::Robot)
    flag = false
    count = 1
    while flag == false
        num_move!(rob, West, count)
        if(isborder(rob, Nord) == false)
            flag = true
            break
        end
        num_move!(rob, Ost, count)

        num_move!(rob, Ost, count)
        if(isborder(rob, Nord) == false)
            flag = true
            break
        end
        num_move!(rob, West, count)
        count += 1
    end
end

door!(r)